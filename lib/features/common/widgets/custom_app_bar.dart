import 'package:flutter/material.dart';

import '../../../lib.dart';

class CustomAppBarSurah extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarSurah({
    super.key,
    required String name,
    int? numberOfAyah,
    required String relevationType,
    Widget? bottom,
  }) : _name = name,
       _numberOfAyah = numberOfAyah,
       _relevationType = relevationType,
       _bottom = bottom;

  final String _name;
  final int? _numberOfAyah;
  final String _relevationType;
  final Widget? _bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios),
      ),
      title: Column(
        children: [
          Text(_name, style: AppTextStyle.medium.copyWith(fontSize: 18)),
          Text(
            '$_numberOfAyah ayah - $_relevationType',
            style: AppTextStyle.medium.copyWith(fontSize: 10),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          ),
          icon: Padding(
            padding: EdgeInsetsGeometry.only(right: 20),
            child: Icon(Icons.settings, size: 20),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: _bottom ?? SizedBox.shrink(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
