import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/fijkplayer_skin.dart';
import 'package:waijudi/pages/detail/widgets/fijkplayer_skin/schema.dart' show VideoSourceFormat;

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
  Map<String, List<Map<String, dynamic>>> videoList = {};

  VideoSourceFormat? _videoSourceTabs;
  late TabController _tabController;

  int _curTabIdx = 0;
  int _curActiveIdx = 0;
  int _tabLength = 0;

  ShowConfigAbs vCfg = PlayerShowConfig();

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
    videoList = controller.videoList;
    // 格式化json转对象
    _videoSourceTabs = VideoSourceFormat.fromJson(videoList);
    _tabLength = _videoSourceTabs!.video!.length;
    // tabbar初始化
    _tabController = TabController(
      length: _tabLength,
      vsync: this,
    );
    // 这句不能省，必须有
    speed = 1.0;
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
        child: TabBarView(
          controller: _tabController,
          children: createTabConList(),
        ),
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
                      ? Colors.red
                      : Colors.blue),
            ),
            onPressed: () async {
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
            },
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
    return Column(
      children: [
        FijkView(
          height: 260,
          color: Colors.black,
          fit: FijkFit.cover,
          player: player,
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
              playerTitle: controller.appController.video.name,
              // 当前视频改变钩子
              onChangeVideo: onChangeVideo,
              // 当前视频源tabIndex
              curTabIdx: _curTabIdx,
              // 当前视频源activeIndex
              curActiveIdx: _curActiveIdx,
              // 显示的配置
              showConfig: vCfg,
              // json格式化后的视频数据
              videoFormat: _videoSourceTabs,
            );
          },
        ),
        SizedBox(
          height: 300,
          child: buildPlayDrawer(),
        ),
      ],
    );
  }
}