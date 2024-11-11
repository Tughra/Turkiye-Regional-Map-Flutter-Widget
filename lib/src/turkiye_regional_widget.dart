import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'custom_region_paint.dart';
import 'tr_region_model.dart';

class TurkeyRegionalMap extends StatefulWidget {
  final TurkeyRegionModel? turkeyRegionModel;
  final void Function(Offset)? selectedRegionCenter;
  final OnSelectRegionCallBack? selectedRegionCallback;
  final double width;
  final double pulseWidth;
  final bool showPulse;
  final bool selectable;
  final Color? pulseColor;

  const TurkeyRegionalMap._(
      {Key? key,
        required this.width,
        required this.showPulse,
        this.selectedRegionCenter,
        this.selectedRegionCallback,
        this.pulseWidth = 32,
        this.turkeyRegionModel,
        this.selectable = true,
        this.pulseColor})
      : super(key: key);

  ///askdasdklaslkşdklşasklşdaslşkdlkşsadlsa
  factory TurkeyRegionalMap.withPulseAnimation(
      {Key? key,
        TurkeyRegionModel? turkeyRegionModel,
        void Function(Offset)? selectedRegionCenter,
        OnSelectRegionCallBack? selectedRegionCallback,
        required double mapWidth,
        required bool selectable,
        Color? pulseColor,
        double pulseMaxRadius = 32}) {
    return TurkeyRegionalMap._(
      key: key,
      showPulse: true,
      width: mapWidth,
      turkeyRegionModel: turkeyRegionModel,
      selectedRegionCenter: selectedRegionCenter,
      selectedRegionCallback: selectedRegionCallback,
      selectable: selectable,
      pulseColor: pulseColor,
      pulseWidth: pulseMaxRadius,
    );
  }
  factory TurkeyRegionalMap.onlyMap(
      {Key? key,
        TurkeyRegionModel? turkeyRegionModel,
        void Function(Offset)? selectedRegionCenter,
        OnSelectRegionCallBack? selectedRegionCallback,
        required double mapWidth,
        required bool selectable,
        Color? pulseColor,
        double pulseMaxRadius = 32}) {
    return TurkeyRegionalMap._(
      key: key,
      showPulse: false,
      width: mapWidth,
      turkeyRegionModel: turkeyRegionModel,
      selectedRegionCenter: selectedRegionCenter,
      selectedRegionCallback: selectedRegionCallback,
      selectable: selectable,
      pulseColor: pulseColor,
      pulseWidth: pulseMaxRadius,
    );
  }

  @override
  State<TurkeyRegionalMap> createState() => _TurkeyRegionalMapState();
}

class _TurkeyRegionalMapState extends State<TurkeyRegionalMap> {
  late TurkeyRegionModel data = widget.turkeyRegionModel ??
      TurkeyRegionModel(selectedRegionColor: Colors.red.shade900, unSelectedRegionColor: Colors.grey.shade600);
  Offset? hitPosition;
  late final double pulseSize = widget.pulseWidth;

  @override
  void didUpdateWidget(covariant TurkeyRegionalMap oldWidget) {
    if (widget.turkeyRegionModel != null) {
      data = widget.turkeyRegionModel!;
      if (data.selectedRegion == null) hitPosition = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showPulse) {
      return Center(
        child: Stack(
          fit: StackFit.loose,
          children: [
            IgnorePointer(
              ignoring: !widget.selectable,
              child: RepaintBoundary(
                child: CustomPaint(
                  isComplex: true,
                  size: Size(widget.width, (widget.width/1.5).toDouble()),
                  painter: TurkiyeRegionPainter(
                      regionModel: data,
                      selectedRegionCenter: (val) {
                        widget.selectedRegionCenter?.call(val);
                        if(hitPosition==null){
                          SchedulerBinding.instance.addPostFrameCallback((_){
                            hitPosition = val;
                            setState(() {});
                          });
                        }
                      },
                      regionSelectCallback: (TurkeyRegionType type, Offset hitOffset, Offset centerRegion) {
                        data.selectedRegion = type;
                        hitPosition = centerRegion;
                        widget.selectedRegionCallback?.call(type,hitOffset,centerRegion);
                        setState(() {});
                      }),
                ),
              ),
            ),
            Positioned(
                left: (hitPosition?.dx ?? 0) - pulseSize / 2,
                top: (hitPosition?.dy ?? 0) - pulseSize / 2,
                child: IgnorePointer(
                  child: PulseAnimation(
                    color: widget.pulseColor,
                    showAnimation: hitPosition != null,
                    size: pulseSize,
                  ),
                )),
          ],
        ),
      );
    } else {
      return IgnorePointer(
        ignoring: !widget.selectable,
        child: RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            size: Size(widget.width, (widget.width/1.5).toDouble()),
            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: TurkiyeRegionPainter(
                regionModel: data,
                selectedRegionCenter: (val) {
                  widget.selectedRegionCenter?.call(val);
                },
                regionSelectCallback: (TurkeyRegionType type, Offset offset, Offset centerRegion) {
                  data.selectedRegion = type;
                  setState(() {});
                  widget.selectedRegionCallback?.call(type, offset, centerRegion);
                }),
          ),
        ),
      );
    }
  }
}
class PulseAnimation extends StatefulWidget {
  const PulseAnimation({super.key, required this.size,this.color,this.showAnimation=false});
  final double size;
  final Color? color;
  final bool showAnimation;

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(_controller);


    if(widget.showAnimation)_controller.repeat();
  }
  @override
  void didUpdateWidget(covariant PulseAnimation oldWidget) {
    if(widget.showAnimation) {
      _controller.repeat();
    } else {
      _controller.value=0;
      _controller.stop(canceled: true);
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(alignment: Alignment.center,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(shape: BoxShape.circle, color:widget.color??const Color.fromRGBO(162, 255, 107, 1)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
