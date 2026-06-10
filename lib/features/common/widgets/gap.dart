import 'package:flutter/material.dart';

import '../../../../lib.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    double height = AppGap.small,
    double width = AppGap.small,
  }) : _height = height,
       _width = width;

  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: _height, width: _width);
  }
}

class BottomSafeArea extends StatelessWidget {
  const BottomSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).viewPadding.bottom);
  }
}

class TopSafeArea extends StatelessWidget {
  const TopSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).viewPadding.top);
  }
}
