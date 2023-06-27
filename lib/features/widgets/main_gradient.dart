import 'package:flutter/material.dart';

import '../../common/colors.dart';

class MainGradient extends StatelessWidget {
  const MainGradient({
    Key? key,
    this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            linearStart,
            linearCenter,
            linearEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          transform: GradientRotation(0.5),
        ),
      ),
      child: child,
    );
  }
}
