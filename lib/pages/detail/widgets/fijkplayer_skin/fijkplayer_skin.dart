// ignore_for_file: must_call_super, camel_case_types
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import './schema.dart' show VideoSourceFormat;
import './config.dart';
import './ui/top_bar.dart';
import './gesture_detector.dart';
import './ui/episode_list.dart';

bool lockStuff = false;
bool hideLockStuff = false;


class WithPlayerChangeSource {}

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final Size viewSize;
  final Rect texturePos;
  final BuildContext? pageContent;
  final String playerTitle;
  final Function? onChangeVideo;
  final int curTabIdx;
  final int curActiveIdx;
  final int startPosition;
  final ShowConfigAbs showConfig;
  final VideoSourceFormat? videoFormat;
  final VoidCallback? onCallBack;

  const CustomFijkPanel({
    Key? key,
    required this.player,
    required this.viewSize,
    required this.texturePos,
    this.pageContent,
    this.playerTitle = "",
    required this.showConfig,
    this.onChangeVideo,
    required this.videoFormat,
    required this.curTabIdx,
    required this.curActiveIdx,
    required this.startPosition,
    this.onCallBack,
  }) : super(key: key);

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  FijkPlayer get player => widget.player;
  ShowConfigAbs get showConfig => widget.showConfig;
  VideoSourceFormat get _videoSourceTabs => widget.videoFormat!;

  bool _lockStuff = lockStuff;
  bool _hideLockStuff = hideLockStuff;
  bool _drawerState = false;
  Timer? _hideLockTimer;

  FijkState? _playerState;
  bool _isPlaying = false;
  bool _showSeekTip = false;
  int _tabLength = 0;

  StreamSubscription? _currentPosSubs;

  AnimationController? _animationController;
  Animation<Offset>? _animation;
  late TabController _tabController;

  void initEvent() {
    _tabLength = _videoSourceTabs.video!.length;
    _showSeekTip = widget.startPosition > 0;
    _tabController = TabController(
      length: _tabLength,
      vsync: this,
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );
    // init animation
    _animation = Tween(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(_animationController!);
    // is not null
    if (_tabLength < 1) return;
    // init player state
    setState(() {
      _playerState = player.value.state;
    });
    if (player.value.duration.inMilliseconds > 0 && !_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    }
    // is not null
    if (_tabLength < 1) return;

    FijkOption fijkOption = FijkOption();
    // fijkOption.setHostOption("enable-snapshot", 1);
    // fijkOption.setPlayerOption("mediacodec-all-videos", 1);
    // fijkOption.setPlayerOption("enable-accurate-seek", 1);
    // fijkOption.setPlayerOption("accurate-seek-timeout", 500);
    fijkOption.setFormatOption("fflags", "fastseek");
    player.applyOptions(fijkOption);
    
    // autoplay and existurl
    if (showConfig.isAutoPlay && !_isPlaying) {
      int curTabIdx = widget.curTabIdx;
      int curActiveIdx = widget.curActiveIdx;
      changeCurPlayVideo(curTabIdx, curActiveIdx, startPosition: widget.startPosition);
    }
    player.addListener(_playerValueChanged);
    Wakelock.enable();
  }

  @override
  void initState() {
    super.initState();
    initEvent();
  }

  @override
  void dispose() {
    _currentPosSubs?.cancel();
    _hideLockTimer?.cancel();
    player.removeListener(_playerValueChanged);
    _tabController.dispose();
    _animationController!.dispose();
    Wakelock.disable();
    super.dispose();
  }

  // 获得播放器状态
  void _playerValueChanged() {
    if (player.value.duration.inMilliseconds > 0 && !_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    }
    setState(() {
      _playerState = player.value.state;
    });
  }

  // 切换UI 播放列表显示状态
  void changeDrawerState(bool state) {
    if (state) {
      setState(() {
        _drawerState = state;
      });
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController!.forward();
    });
  }

  // 切换UI lock显示状态
  void changeLockState(bool state) {
    setState(() {
      _lockStuff = state;
      if (state == true) {
        _hideLockStuff = true;
        _cancelAndRestartLockTimer();
      }
    });
  }

  // 切换播放源
  Future<void> changeCurPlayVideo(int tabIdx, int activeIdx, { int startPosition = 0 }) async {
    setState(() {
      _showSeekTip = false;
    });
    widget.onChangeVideo!(tabIdx, activeIdx, startPosition: startPosition);
  }

  void _cancelAndRestartLockTimer() {
    if (_hideLockStuff == true) {
      _startHideLockTimer();
    }
    setState(() {
      _hideLockStuff = !_hideLockStuff;
    });
  }

  void _startHideLockTimer() {
    _hideLockTimer?.cancel();
    _hideLockTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _hideLockStuff = true;
      });
    });
  }

  // 锁 组件
  Widget _buidLockStateDetctor() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _cancelAndRestartLockTimer,
      child: Container(
        child: AnimatedOpacity(
          opacity: _hideLockStuff ? 0.0 : 0.7,
          duration: const Duration(milliseconds: 400),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: showConfig.stateAuto && !player.value.fullScreen
                    ? barGap
                    : 0,
              ),
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    _lockStuff = false;
                    _hideLockStuff = true;
                  });
                },
                icon: const Icon(Icons.lock),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 抽屉组件 - 播放列表
  Widget _buildPlayerListDrawer() {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await _animationController!.reverse();
                setState(() {
                  _drawerState = false;
                });
              },
            ),
          ),
          Container(
            child: SlideTransition(
              position: _animation!,
              child: Container(
                height: window.physicalSize.height,
                width: 320,
                child: _buildPlayDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // build 剧集
  Widget _buildPlayDrawer() {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.4),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
        automaticallyImplyLeading: false,
        elevation: 0.1,
        title: _tabLength > 1 ? TabBar(
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          indicator: BoxDecoration(
            color: Colors.purple[700],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          tabs:
              _videoSourceTabs.video!.map((e) => Tab(text: e!.name!)).toList(),
          isScrollable: true,
          controller: _tabController,
        ) : const SizedBox(),
      ),
      body: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.5),
        child: _tabLength > 1 ? TabBarView(
          controller: _tabController,
          children: _createTabConList(),
        ) : ListView(children: _createTabConList(),),
      ),
    );
  }

  // 剧集 tabCon
  List<Widget> _createTabConList() {
    return buildEpisodeList(_videoSourceTabs, widget.curTabIdx, widget.curActiveIdx, (tabIdx, activeIdx) {
      changeCurPlayVideo(tabIdx, activeIdx);
    });
  }

  // 可以共用的架子
  Widget _buildPublicFrameWidget({
    required Widget slot,
    Color? bgColor,
  }) {
    return Container(
      color: bgColor,
      child: Stack(
        children: [
          showConfig.topBar
              ? Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height:
                        showConfig.stateAuto && !widget.player.value.fullScreen
                            ? barFillingHeight
                            : barHeight,
                    alignment: Alignment.topLeft,
                    child: buildTopBar(widget),
                  ),
                )
              : Container(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: showConfig.stateAuto && !widget.player.value.fullScreen
                        ? barGap
                        : 0),
                child: slot,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 错误slot
  Widget _buildErrorStateSlotWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: showConfig.stateAuto && !widget.player.value.fullScreen
                ? barGap
                : 0,
          ),
          // 失败图标
          const Icon(
            Icons.error,
            size: 50,
            color: Colors.white,
          ),
          // 错误信息
          const Text(
            "播放失败，您可以点击重试！",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // 重试
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              // 切换视频
              changeCurPlayVideo(widget.curTabIdx, widget.curActiveIdx);
            },
            child: const Text(
              "点击重试",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // 加载中slot
  Widget _buildLoadingStateSlotWidget() {
    return const SizedBox(
      width: barHeight * 0.8,
      height: barHeight * 0.8,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }

  // 未开始slot
  Widget _buildIdleStateSlotWidget() {
    return IconButton(
      iconSize: barHeight * 1.2,
      icon: const Icon(Icons.play_arrow, color: Colors.white),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      onPressed: () async {
        int newTabIdx = widget.curTabIdx;
        int newActiveIdx = widget.curActiveIdx;
        await changeCurPlayVideo(newTabIdx, newActiveIdx);
      },
    );
  }

  //
  Widget _buildSeekTips () {
    return _showSeekTip ? GestureDetector(
      onTap: () {
        changeCurPlayVideo(widget.curTabIdx, widget.curActiveIdx, startPosition: widget.startPosition);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Align(
          child: Text(
            '上次看到${_videoSourceTabs.video![widget.curTabIdx]!.list![widget.curActiveIdx]!.name} ${Duration(seconds: widget.startPosition).toString().split(".")[0]}，点击继续播放',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = player.value.fullScreen
        ? Rect.fromLTWH(
            0,
            0,
            widget.viewSize.width,
            widget.viewSize.height,
          )
        : Rect.fromLTRB(
            min(0.0, widget.texturePos.left),
            min(0.0, widget.texturePos.top),
            max(widget.viewSize.width, widget.texturePos.right),
            max(widget.viewSize.height, widget.texturePos.bottom),
          );

    List<Widget> ws = [];

    if (_playerState == FijkState.error) {
      ws.add(
        _buildPublicFrameWidget(
          slot: _buildErrorStateSlotWidget(),
          bgColor: Colors.black,
        ),
      );
    } else if ((_playerState == FijkState.asyncPreparing ||
            _playerState == FijkState.initialized) &&
        !_isPlaying) {
      ws.add(
        _buildPublicFrameWidget(
          slot: _buildLoadingStateSlotWidget(),
          bgColor: Colors.black,
        ),
      );
    } else if (_playerState == FijkState.idle && !_isPlaying) {
      ws.add(
        _buildPublicFrameWidget(
          slot: _buildIdleStateSlotWidget(),
          bgColor: Colors.black,
        ),
      );
      ws.add(
        Positioned(
          left: 10,
          bottom: 10,
          child: _buildSeekTips(),
        ),
      );
    } else {
      if (_lockStuff == true &&
          showConfig.lockBtn &&
          widget.player.value.fullScreen) {
        ws.add(
          _buidLockStateDetctor(),
        );
      } else if (_drawerState == true && widget.player.value.fullScreen) {
        ws.add(
          _buildPlayerListDrawer(),
        );
      } else {
        ws.add(
          GestureDetectorLayer(
            curActiveIdx: widget.curActiveIdx,
            curTabIdx: widget.curTabIdx,
            onChangeVideo: widget.onChangeVideo,
            player: widget.player,
            texturePos: widget.texturePos,
            showConfig: widget.showConfig,
            pageContent: widget.pageContent,
            playerTitle: widget.playerTitle,
            viewSize: widget.viewSize,
            videoFormat: widget.videoFormat,
            changeDrawerState: changeDrawerState,
            changeLockState: changeLockState,
          ),
        );
      }
    }

    return WillPopScope(
      child: Positioned.fromRect(
        rect: rect,
        child: Stack(
          children: ws,
        ),
      ),
      onWillPop: () async {
        if (!widget.player.value.fullScreen) widget.player.stop();
        return true;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

