import 'package:flutter/material.dart';

class MeasureSize extends StatelessWidget {
  const MeasureSize({
    super.key,
    required this.child,
    required this.onSizeChange,
    this.globalKey,
  });

  final Widget child;
  final void Function(Size size) onSizeChange;
  final GlobalKey? globalKey;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox? renderBox;

      if (globalKey != null) {
        // Utiliza la llave global si está disponible
        renderBox = globalKey!.currentContext?.findRenderObject() as RenderBox?;
      } else {
        // Utiliza el contexto del widget
        renderBox = context.findRenderObject() as RenderBox?;
      }

      if (renderBox != null && renderBox.hasSize) {
        // Verifica que el RenderObject tenga un tamaño válido
        onSizeChange(renderBox.size);
      }
    });

    return child;
  }
}




// class MeasureSize extends StatelessWidget {
//   final Widget child;
//   final void Function(Size size) onSizeChange;

//   const MeasureSize(
//       {super.key, required this.child, required this.onSizeChange});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final RenderBox renderBox = context.findRenderObject() as RenderBox;
//       onSizeChange(renderBox.size); // Llama al callback con el tamaño actual
//     });

//     return child;
//   }
// }