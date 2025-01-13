import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/animation_loading_drawer/animation_loading_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/blocs/drawer/scroll_drawer/scroll_drawer_bloc.dart';
import 'package:flutter_application_alon2/presentation/widgets/widgets.dart';
import 'package:flutter_application_alon2/utils/transform_color_with_opacity.dart';
import 'package:flutter_application_alon2/utils/transform_to_range.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLoadSymbol extends StatelessWidget {
  const MyLoadSymbol({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollDrawerBloc, ScrollDrawerState>(
      builder: (context, stateScroll) {
        final double opacity =
            (-((stateScroll.position + kToolbarHeight / 2) / kToolbarHeight))
                .clamp(0.0, 1.0);

        return BlocBuilder<AnimationLoadingDrawerBloc,
            AnimationLoadingDrawerState>(
          builder: (context, stateAnimation) {
            return  Opacity(
              opacity: !stateAnimation.isScrollingDown ? 1 : 0,
              child: Padding(
                padding: EdgeInsets.only(
                  top: stateScroll.sizeRangeExpanded +
                      (kToolbarHeight / 2) -
                      ((kToolbarHeight - kToolbarHeight * 0.65) / 4),
                ),
                child: stateAnimation.showLoadingSymbol
                    ? MyLoadSymbolLoading(
                        size: size, animationDrawerLoadingState: stateAnimation)
                    : MyLoadSymbolPreLoading(opacity: opacity, size: size),
              ),
            );
          },
        );
      },
    );
  }
}

class MyLoadSymbolLoading extends StatefulWidget {
  const MyLoadSymbolLoading(
      {super.key,
      required this.size,
      required this.animationDrawerLoadingState});
  final double size;
  final AnimationLoadingDrawerState animationDrawerLoadingState;

  @override
  State<MyLoadSymbolLoading> createState() => _MyLoadSymbolLoadingState();
}

class _MyLoadSymbolLoadingState extends State<MyLoadSymbolLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationFirstRotation;
  late final Animation<double> _animationSecondRotation;

  static late double _firstInterval;
  static const double _secondInterval = 0.89;
  static const double _scaleThresholdOffset = 0.05;
  static const double _opacityFadeDuration = 0.4;
  static const double _rotationTolerance = 0.0099;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.animationDrawerLoadingState.timeAnimation,
      ),
    );

    _firstInterval = widget.animationDrawerLoadingState.initIntervalRotation;

    _animationFirstRotation = Tween<double>(begin: 0, end: 0.9 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, _firstInterval, curve: Curves.linearToEaseOut),
      ),
    );

    _animationSecondRotation = Tween<double>(begin: 0, end: 0.5 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(_secondInterval, 1, curve: Curves.decelerate),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAnimationState(AnimationLoadingDrawerBloc animationDrawerBloc,
      ScrollDrawerBloc scrollBloc) {
    final animationValue = _animationController.value;

    if (animationValue >= _firstInterval &&
        animationValue <= _firstInterval + _rotationTolerance &&
        widget.animationDrawerLoadingState.inLoading) {
      // Primera animación de rotación terminada
      _animationController.value = _firstInterval;
    } else if (animationValue == _firstInterval) {
      // Reanudar la animación tras terminar el request a la API
      _animationController.forward(
          from: _secondInterval - _scaleThresholdOffset);
    } else if (animationValue >= _secondInterval && animationValue != 1) {
      // Efecto de expansión del chat antes de finalizar la rotación
      scrollBloc
          .add(const ScrollDrawerHandle(position: 0.0001, loadChat: false));
    } else if (animationValue == 1) {
      // Terminar y desaparecer el símbolo de carga
      animationDrawerBloc.add(AnimationDrawerLoadingEvt(
          timeAnimation: widget.animationDrawerLoadingState.timeAnimation,
          showLoadingSymbol: false,
          initIntervalRotation:
              widget.animationDrawerLoadingState.initIntervalRotation));
    }

  }

  @override
  Widget build(BuildContext context) {
    final animationDrawerBloc = context.read<AnimationLoadingDrawerBloc>();
    final scrollBloc = context.read<ScrollDrawerBloc>();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        _handleAnimationState(animationDrawerBloc, scrollBloc);

        final animation = _animationController.value <= _secondInterval
            ? _animationFirstRotation
            : _animationSecondRotation;

        final scale = _animationController.value <= _secondInterval
            ? 1.0
            : 1 -
                transformToRange(
                  _animationController.value,
                  _secondInterval - _scaleThresholdOffset,
                  1,
                  0,
                  1,
                );

        final double opacity =
            (1 - _animationController.value / _opacityFadeDuration).clamp(0, 1);

        final Color colorFullEffect = transformWithOpacity(
            Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.primary,
            0.575);

        final Color colorAnimation = transformWithOpacity(
            Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.primary,
            0.45);

        return Stack(
          children: [
            Transform.rotate(
              angle: animation.value,
              child: Transform.scale(
                scale: scale,
                child: CustomLoader(
                  size: widget.size,
                  color: colorAnimation,
                ),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: Transform.rotate(
                angle: animation.value,
                child: CustomLoader(
                  size: widget.size,
                  effectProgress: false,
                  color: colorFullEffect,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyLoadSymbolPreLoading extends StatelessWidget {
  const MyLoadSymbolPreLoading({
    super.key,
    required this.opacity,
    required this.size,
  });

  final double opacity;
  final double size;

  @override
  Widget build(BuildContext context) {
    final Color color = transformWithOpacity(
        Theme.of(context).colorScheme.onPrimary,
        Theme.of(context).colorScheme.primary,
        0.45);

    return CustomPaint(
      painter: PreLoadingPainter(
        progress: opacity,
        color: color,
      ),
      child: SizedBox(
        width: size,
      ),
    );
  }
}
