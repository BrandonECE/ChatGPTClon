import 'package:flutter/material.dart';
import 'package:flutter_application_alon2/utils/transform_to_range.dart';

class MyMessageChatGptResponseLoading extends StatefulWidget {
  const MyMessageChatGptResponseLoading({super.key});

  @override
  State<MyMessageChatGptResponseLoading> createState() =>
      _MyMessageChatGptResponseLoadingState();
}

class _MyMessageChatGptResponseLoadingState
    extends State<MyMessageChatGptResponseLoading>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..repeat(reverse: true);

    // Aplicamos una curva a la animación
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut, // Cambia esto a la curva que desees
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation, // Usamos la animación con curva
      builder: (context, child) {
          super.build(context);

        return Opacity(
          opacity: _curvedAnimation.value <= 0.75
              ? transformToRange(_curvedAnimation.value, 0, 0.725, 0.79, 1)
              : 1,
          child: Transform.scale(
            alignment: Alignment.center,
            scale: transformToRange(_curvedAnimation.value, 0, 1, 0.7, 1),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              width: 17,
              height: 17,
            ),
          ),
        );
      },
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
