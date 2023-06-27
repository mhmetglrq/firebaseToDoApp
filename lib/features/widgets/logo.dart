import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/paths.dart';
import '../../common/sizes.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(signInPath),
        const Padding(
          padding: horizontal10,
          child: Text(
            "on.Time",
            style: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
