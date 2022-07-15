import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/schema.dart' show VideoSourceFormat;
import 'package:waijudi/models/video_detail.dart';
import 'package:waijudi/util/time.dart';
import 'package:waijudi/pages/detail/widgets/skin/player.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player>
    with TickerProviderStateMixin {
  final FijkPlayer player = FijkPlayer();
  final DetailController controller = Get.find();
  // Map<String, List<Map<String, dynamic>>> videoList = {};
  late YoutubePlayerController _controller;

  VideoSourceFormat? _videoSourceTabs;
  late TabController _tabController;

  int _curTabIdx = 0;
  int _curActiveIdx = 0;
  int _seekPos = 0;
  int _tabLength = 0;
  late VideoDetail videoDetail;
  bool _showSeekTip = false;

  @override
  void dispose() {
    player.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // 钩子函数，用于更新状态
  void onChangeVideo(int curTabIdx, int curActiveIdx) {
    setState(() {
      _curTabIdx = curTabIdx;
      _curActiveIdx = curActiveIdx;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '$_curActiveIdx',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    videoDetail = controller.videoDetail.value;
    // videoList = controller.videoList;
    // 格式化json转对象
    _videoSourceTabs = VideoSourceFormat.fromJson(controller.videoList);
    _tabLength = _videoSourceTabs!.video!.length;
    // tabbar初始化
    _tabController = TabController(
      length: _tabLength,
      vsync: this,
    );
    // 如果是续播，则尝试回到上次的状态
    if (videoDetail.vodTimed > 0 && videoDetail.dramaId != controller.videoList['video']![0]['list'][0]['name']) {
      _curTabIdx = controller.lineList.indexWhere((line) => line.vodLineId == videoDetail.vodLineId);
      _curActiveIdx = controller.videoList['video']![_curTabIdx]['list']!.indexWhere((item) => item['name'] == videoDetail.dramaId);
    }
    _seekPos = videoDetail.vodTimed;
    _showSeekTip = _seekPos > 0;
  }

  void listener() {
    //
  }

  PreferredSizeWidget? buildAppBar() {
    if (_tabLength > 1) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(24),
        child: AppBar(
          backgroundColor: AppColors.LIGHT,
          automaticallyImplyLeading: false,
          primary: false,
          elevation: 0,
          title: TabBar(
            unselectedLabelColor: AppColors.LIGHT_GREY,
            tabs: _videoSourceTabs!.video!
                .map((e) => Tab(text: e!.name!))
                .toList(),
            isScrollable: true,
            controller: _tabController,
          ),
        ),
      );
    }
  }

  // build 剧集
  Widget buildPlayDrawer() {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: AppColors.LIGHT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                '${videoDetail.name}(${videoDetail.vodDoubanScore})',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.DARK,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                videoDetail.vodSub,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.DARK,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                videoDetail.vodActor,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.DARK,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                videoDetail.vodRemarks,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.DARK,
                ),
              ),
            ),
            Expanded(
              child: _tabLength > 1 ? TabBarView(
                controller: _tabController,
                children: createTabConList(),
              ) : ListView(children: createTabConList(),)
            ),
          ],
        )
      ),
    );
  }

  // 剧集 tabCon
  List<Widget> createTabConList() {
    List<Widget> list = [];
    _videoSourceTabs!.video!.asMap().keys.forEach((int tabIdx) {
      List<Widget> playListBtns = _videoSourceTabs!.video![tabIdx]!.list!
          .asMap()
          .keys
          .map((int activeIdx) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                  tabIdx == _curTabIdx && activeIdx == _curActiveIdx
                      ? AppColors.LIGHT_GREEN
                      : AppColors.LIGHT_GREY),
            ),
            onPressed: () => _selectToPlay(tabIdx, activeIdx),
            child: Text(
              _videoSourceTabs!.video![tabIdx]!.list![activeIdx]!.name!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList();
      //
      list.add(
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Wrap(
              direction: Axis.horizontal,
              children: playListBtns,
            ),
          ),
        ),
      );
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FijkView(
            height: 260,
            color: Colors.black,
            fit: FijkFit.cover,
            player: player,
            onDispose: (FijkData? data) {
              String currentDramaId = _videoSourceTabs!.video![_curTabIdx]!.list![_curActiveIdx]!.name!;
              var params = {
                "vod_line_id": videoDetail.vodLineId,
                "vod_time": timeToSecond(player.value.duration),
                "vod_id": videoDetail.id,
                "drama_id": Uri.encodeComponent(currentDramaId),
                "vod_timed": timeToSecond(player.currentPos),
              };
              if (player.currentPos.inMicroseconds > 0) {
                controller.addPlaybackRecord(params);
              }
            },
            panelBuilder: (
              FijkPlayer player,
              FijkData data,
              BuildContext context,
              Size viewSize,
              Rect texturePos,
            ) {
              /// 使用自定义的布局
              return YoutubePlayerBuilder(
                onExitFullScreen: () {
                  // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                },
                player: YoutubePlayer(
                  controller: _controller,
                ),
                builder: (context, player) => Scaffold(
                  appBar: AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.DARK,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    title: const Text(
                      'Youtube Player Flutter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 280,
            child: buildPlayDrawer(),
          ),
        ],
      )
    );
  }

  void _selectToPlay (int tabIdx, int activeIdx) async {
    setState(() {
      _curTabIdx = tabIdx;
      _curActiveIdx = activeIdx;
    });
    String nextVideoUrl =
        _videoSourceTabs!.video![tabIdx]!.list![activeIdx]!.url!;
    String nextDecVideoUrl = await controller.getVodDecrypt(nextVideoUrl);
    // 切换播放源
    // 如果不是自动开始播放，那么先执行stop
    if (player.value.state == FijkState.completed) {
      await player.stop();
    }
    await player.reset().then((_) async {
      player.setDataSource(nextDecVideoUrl, autoPlay: true);
    });
  }
}