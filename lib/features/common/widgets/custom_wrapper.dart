import 'package:flutter/material.dart';

/// Custom Widget for make a `Column` with `Padding` inside a `non-Sliver widget`
class ColumnPadding extends StatelessWidget {
  const ColumnPadding({
    super.key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Color background = Colors.transparent,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) : _padding = padding,
       _children = children,
       _background = background,
       _mainAxisSize = mainAxisSize,
       _mainAxisAlignment = mainAxisAlignment,
       _crossAxisAlignment = crossAxisAlignment;

  final EdgeInsetsGeometry _padding;
  final List<Widget> _children;
  final Color _background;
  final MainAxisSize _mainAxisSize;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(color: _background),
      child: Column(
        mainAxisSize: _mainAxisSize,
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _children,
      ),
    );
  }
}

/// Custom Widget for make a `Row` with `Padding` inside a `non-Sliver Widget`
class RowPadding extends StatelessWidget {
  const RowPadding({
    super.key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    required List<Widget> children,
    Color background = Colors.transparent,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) : _padding = padding,
       _children = children,
       _background = background,
       _mainAxisAlignment = mainAxisAlignment,
       _crossAxisAlignment = crossAxisAlignment;

  final EdgeInsetsGeometry _padding;
  final List<Widget> _children;
  final Color _background;
  final MainAxisAlignment _mainAxisAlignment;
  final CrossAxisAlignment _crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      color: _background,
      child: Row(
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _children,
      ),
    );
  }
}
