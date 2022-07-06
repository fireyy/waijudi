import 'dart:math';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart'
    as refresh;
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:waijudi/util/colors.dart';

class RefreshHeader extends refresh.PullToRefreshContainer {
  RefreshHeader() : super(_customerBuilder());
}

refresh.PullToRefreshContainerBuilder _customerBuilder() {
  return (refresh.PullToRefreshScrollNotificationInfo? info) {
    var offset = info?.dragOffset ?? 0.0;
    var mode = info?.mode;
    Widget refreshWidget = Container();
    //it should more than 18, so that RefreshProgressIndicator can be shown fully
    if (info?.refreshWidget != null &&
        offset > 18.0 &&
        mode != RefreshIndicatorMode.error) {
      refreshWidget = _animationIconBulder()(mode, 80.0, offset);
    }

    Widget child;
    if (mode == RefreshIndicatorMode.error) {
      child = GestureDetector(
          onTap: () {
            // refreshNotification;
            info?.pullToRefreshNotificationState.show();
          },
          child: Container(
            color: AppColors.LIGHT,
            alignment: Alignment.bottomCenter,
            height: offset,
            width: double.infinity,
            //padding: EdgeInsets.only(top: offset),
            child: Container(
              padding: const EdgeInsets.only(left: 5.0),
              alignment: Alignment.center,
              child: Text(
                _lableBuilder()(mode),
                style: const TextStyle(
                    fontSize: 14.0, inherit: false, color: Colors.grey),
              ),
            ),
          ));
    } else {
      child = Container(
        color: AppColors.LIGHT,
        alignment: Alignment.bottomCenter,
        height: offset,
        width: double.infinity,
        //padding: EdgeInsets.only(top: offset),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            refreshWidget,
            Container(
              padding: const EdgeInsets.only(left: 5.0),
              alignment: Alignment.center,
              child: Text(
                _lableBuilder()(mode),
                style: const TextStyle(
                    fontSize: 14.0, inherit: false, color: Colors.grey),
              ),
            )
          ],
        ),
      );
    }

    return SliverToBoxAdapter(
      child: child,
    );
  };
}

LableBuilder _lableBuilder() {
  return (refresh.RefreshIndicatorMode? mode) {
    if (mode == null) return "";
    switch (mode) {
      case refresh.RefreshIndicatorMode.drag:
        return "上拉加载";
      case refresh.RefreshIndicatorMode.armed:
        return "松开更新";
      case refresh.RefreshIndicatorMode.refresh:
        return "正在更新...";
      case refresh.RefreshIndicatorMode.done:
        return "加载完成";
      case refresh.RefreshIndicatorMode.canceled:
        return "上拉更新";
      case refresh.RefreshIndicatorMode.error:
        return "更新失败";
      default:
        return "";
    }
  };
}

AnimationIconBulder _animationIconBulder() {
  return (refresh.RefreshIndicatorMode? mode, double max, double offset) {
    Widget child;
    switch (mode) {
      case refresh.RefreshIndicatorMode.drag:
      case refresh.RefreshIndicatorMode.armed:
        var angle = 0.0;
        if (offset >= 40.0) {
          angle = (offset - 40) * pi / (max - 40);
        }
        child = Transform.rotate(
          angle: angle,
          child: const Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
        );
        break;
      case refresh.RefreshIndicatorMode.refresh:
        child = const SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(),
        );
        break;
      default:
        child = Container();
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: child,
    );
  };
}

typedef LableBuilder = String Function(refresh.RefreshIndicatorMode? mode);

typedef AnimationIconBulder = Widget Function(
    refresh.RefreshIndicatorMode? mode, double max, double offset);