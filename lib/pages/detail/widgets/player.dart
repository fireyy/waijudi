import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/config.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/schema.dart' show VideoSourceFormat;
import 'package:waijudi/models/video_detail.dart';
import 'package:waijudi/util/time.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/ui/episode_list.dart';

// 定制UI配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;
  @override
  bool nextBtn = true;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = false;
}

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

  VideoSourceFormat? _videoSourceTabs;
  late TabController _tabController;

  int _curTabIdx = 0;
  int _curActiveIdx = 0;
  int _seekPos = 0;
  int _tabLength = 0;
  late VideoDetail videoDetail;
  String _dramaId = '';

  ShowConfigAbs vCfg = PlayerShowConfig();

  @override
  void dispose() {
    player.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // 钩子函数，用于更新状态
  void onChangeVideo (int tabIdx, int activeIdx, {int startPosition = 0, void Function(int, int)? onChange}) async {
    setState(() {
      _curTabIdx = tabIdx;
      _curActiveIdx = activeIdx;
      _dramaId = _videoSourceTabs!.video![tabIdx]!.list![activeIdx]!.name ?? '';
    });

    String nextVideoUrl =
        _videoSourceTabs!.video![tabIdx]!.list![activeIdx]!.url!;
    String nextDecVideoUrl = nextVideoUrl.contains('wsSecret') ? nextVideoUrl : await controller.getVodDecrypt(nextVideoUrl);
    // 切换播放源
    await player.reset().then((_) async {
      await player.setDataSource(nextDecVideoUrl);
      FijkOption fijkOption = FijkOption();
      // fijkOption.setHostOption("request-screen-on", 1);
      fijkOption.setPlayerOption("start-on-prepared", 1);
      if (startPosition > 0) fijkOption.setPlayerOption("seek-at-start", startPosition * 1000);
      await player.applyOptions(fijkOption);
      await player.prepareAsync();

      // 回调
      if (onChange is Function) {
        onChange!(tabIdx, activeIdx);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    vCfg.isAutoPlay = Get.parameters['autoPlay'] == '1' ? true : false;
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
    // 这句不能省，必须有
    speed = 1.0;
    // 如果是续播，则尝试回到上次的状态
    if (videoDetail.vodTimed > 0 && videoDetail.dramaId != '' && videoDetail.dramaId != controller.videoList['video']![0]['list'][0]['name']) {
      _curTabIdx = controller.lineList.indexWhere((line) => line.vodLineId == videoDetail.vodLineId);
      _curTabIdx = _curTabIdx == -1 ? 0 : _curTabIdx;
      _curActiveIdx = controller.videoList['video']![_curTabIdx]['list']!.indexWhere((item) => item['name'] == videoDetail.dramaId);
      _curActiveIdx = _curActiveIdx == -1 ? 0 : _curActiveIdx;
    }
    _seekPos = videoDetail.vodTimed;
    if (controller.videoList['video']!.isNotEmpty) {
      _dramaId = controller.videoList['video']![_curTabIdx]['list'][_curActiveIdx]['name'];
    }
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
            GestureDetector(
              onTap: () {
                showDetail(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  '${videoDetail.name}(${videoDetail.vodDoubanScore})',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.DARK,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
            videoDetail.vodSub != '' ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                videoDetail.vodSub,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.DARK,
                ),
              ),
            ) : Container(),
            videoDetail.vodActor != '' ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                videoDetail.vodActor,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.DARK,
                ),
              ),
            ) : Container(),
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

  void showDetail(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Director: ${videoDetail.vodDirector}'),
              Text('Actor: ${videoDetail.vodActor}'),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Text(videoDetail.vodContent),
                )
              ),
            ],
          ),
        );
      },
    );
  }

  // 剧集 tabCon
  List<Widget> createTabConList() {
    return buildEpisodeList(_videoSourceTabs, _curTabIdx, _curActiveIdx, (tabIdx, activeIdx) {
      onChangeVideo(tabIdx, activeIdx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          FijkView(
            height: 220,
            color: Colors.black,
            fit: FijkFit.contain,
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
              return CustomFijkPanel(
                player: player,
                viewSize: viewSize,
                texturePos: texturePos,
                pageContent: context,
                // 标题 当前页面顶部的标题部分
                playerTitle: '${videoDetail.name} $_dramaId',
                // 当前视频改变钩子
                onChangeVideo: onChangeVideo,
                // 当前视频源tabIndex
                curTabIdx: _curTabIdx,
                // 当前视频源activeIndex
                curActiveIdx: _curActiveIdx,
                // 历史视频播放进度
                startPosition: _seekPos,
                // 显示的配置
                showConfig: vCfg,
                // json格式化后的视频数据
                videoFormat: _videoSourceTabs,
              );
            },
          ),
          Expanded(
            child: buildPlayDrawer(),
          ),
        ],
      )
    );
  }
}