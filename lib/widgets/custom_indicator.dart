import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'dart:math' as math;
import './logo.dart';

const double _kDefaultCustomIndicatorRadius = 20.0;
const double _kDefaultProgressIndicatorStrokeWidth = 3.0;

double kCustomFrictionFactor(double overscrollFraction) =>
    0.25 * math.pow(1 - overscrollFraction, 2);

double kCustomHorizontalFrictionFactor(double overscrollFraction) =>
    0.52 * math.pow(1 - overscrollFraction, 2);

/// Custom indicator.
class CustomIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  /// True for up and left.
  /// False for down and right.
  final bool reverse;

  /// Indicator foreground color.
  final Color? foregroundColor;

  /// WaterDrop background color.
  final Color? backgroundColor;

  /// Empty widget.
  /// When result is [IndicatorResult.noMore].
  final Widget? emptyWidget;

  const CustomIndicator({
    Key? key,
    required this.state,
    required this.reverse,
    this.foregroundColor,
    this.backgroundColor,
    this.emptyWidget,
  }) : super(key: key);

  @override
  State<CustomIndicator> createState() => CustomIndicatorState();
}

class CustomIndicatorState extends State<CustomIndicator>
    with SingleTickerProviderStateMixin {
  Axis get _axis => widget.state.axis;
  IndicatorMode get _mode => widget.state.mode;
  double get _offset => widget.state.offset;
  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  double get _radius => _kDefaultCustomIndicatorRadius;

  late AnimationController _waterDropHiddenController;

  @override
  void initState() {
    super.initState();
    _waterDropHiddenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    widget.state.notifier.addModeChangeListener(_onModeChange);
  }

  @override
  void dispose() {
    widget.state.notifier.removeModeChangeListener(_onModeChange);
    _waterDropHiddenController.dispose();
    super.dispose();
  }

  /// Mode change listener.
  void _onModeChange(IndicatorMode mode, double offset) {
    if (mode == IndicatorMode.ready) {
      if (!_waterDropHiddenController.isAnimating) {
        _waterDropHiddenController.forward(from: 0);
      }
    }
  }

  Widget _buildIndicator() {
    Widget indicator;
    switch (_mode) {
      case IndicatorMode.ready:
      case IndicatorMode.processing:
      case IndicatorMode.processed:
        indicator = CircularProgressIndicator(
          key: const ValueKey('indicator'),
          color: widget.backgroundColor ?? Theme.of(context).splashColor,
          strokeWidth: _kDefaultProgressIndicatorStrokeWidth,
        );
        break;
      case IndicatorMode.done:
        indicator = CircularProgressIndicator(
          key: const ValueKey('indicator'),
          value: 1.0,
          color: widget.backgroundColor ?? Theme.of(context).splashColor,
          strokeWidth: _kDefaultProgressIndicatorStrokeWidth,
        );
        break;
      default:
        indicator = const SizedBox(
          key: ValueKey('indicator'),
        );
        break;
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 100),
      child: widget.state.result == IndicatorResult.noMore
          ? widget.emptyWidget != null
              ? SizedBox(
                  key: const ValueKey('noMore'),
                  child: widget.emptyWidget!,
                )
              : Icon(
                  Icons.archive,
                  key: const ValueKey('noMore'),
                  color: widget.foregroundColor,
                )
          : SizedBox(width: _radius, height: _radius, child: indicator),
    );
  }

  Widget _buildWaterDrop() {
    Widget waterDropWidget = CustomPaint(
      painter: MyLogo(
        axis: _axis,
        offset: _offset,
        actualTriggerOffset: _actualTriggerOffset,
        color: widget.backgroundColor ?? Theme.of(context).splashColor,
      ),
    );
    return AnimatedBuilder(
      animation: _waterDropHiddenController,
      builder: (context, _) {
        double opacity = 1;
        if (_mode == IndicatorMode.drag) {
          final scale = (_offset / _actualTriggerOffset).clamp(0.0, 1.0);
          const Curve opacityCurve = Interval(
            0.0,
            0.8,
            curve: Curves.easeInOut,
          );
          opacity = opacityCurve.transform(scale);
        } else if (_mode == IndicatorMode.armed) {
          opacity = 1;
        } else if (_mode == IndicatorMode.ready ||
            _mode == IndicatorMode.processing ||
            _mode == IndicatorMode.processed ||
            _mode == IndicatorMode.done) {
          opacity = 1 - _waterDropHiddenController.value;
        } else {
          opacity = 0;
        }
        return Opacity(
          opacity: opacity,
          child: waterDropWidget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: _axis == Axis.vertical ? _offset : double.infinity,
          width: _axis == Axis.vertical ? double.infinity : _offset,
        ),
        // WaterDrop.
        Positioned(
          top: 0,
          left: 0,
          right: _axis == Axis.vertical ? 0 : null,
          bottom: _axis == Axis.vertical ? null : 0,
          child: SizedBox(
            height: _axis == Axis.vertical ? _offset : double.infinity,
            width: 300,
            child: _buildWaterDrop(),
          ),
        ),
        // Indicator.
        Positioned(
          top: 0,
          left: 0,
          right: _axis == Axis.vertical ? 0 : null,
          bottom: _axis == Axis.vertical ? null : 0,
          child: Container(
            alignment: Alignment.center,
            height:
                _axis == Axis.vertical ? _actualTriggerOffset : double.infinity,
            width:
                _axis == Axis.vertical ? double.infinity : _actualTriggerOffset,
            child: _buildIndicator(),
          ),
        ),
      ],
    );
  }
}