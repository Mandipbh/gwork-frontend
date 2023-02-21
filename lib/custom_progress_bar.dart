import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final Color color;
  final Color bgColor;

  const CustomProgressBar(
      {Key? key,
      required this.max,
      required this.current,
      required this.color,
      required this.bgColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 7,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 7,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
