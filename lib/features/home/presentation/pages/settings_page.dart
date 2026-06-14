import 'package:flutter/material.dart';
import 'package:quranify/lib.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Settings',
          style: AppTextStyle.medium.copyWith(fontSize: 18),
        ),
      ),
      body: ColumnPadding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Changed Artists",
              style: AppTextStyle.regular.copyWith(fontSize: 14),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangedArtistPage()),
            ),
          ),
        ],
      ),
    );
  }
}
