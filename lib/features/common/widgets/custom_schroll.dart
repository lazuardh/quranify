import 'package:flutter/material.dart';
import 'package:quranify/features/features.dart';

class CustomSchrollWrapper extends StatefulWidget {
  const CustomSchrollWrapper({super.key});

  @override
  State<CustomSchrollWrapper> createState() => _CustomSchrollWrapperState();
}

class _CustomSchrollWrapperState extends State<CustomSchrollWrapper> {
  final List<String> _category = ['Surah', 'Juz', 'Bookmark'];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
      constraints: BoxConstraints(minHeight: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(_category.length, (index) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _index = index;
              });
            },
            child: _index == index
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      child: Text(
                        _category[index],
                        style: AppTextStyle.black.copyWith(fontSize: 14),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: MediaQuery.sizeOf(context).width * 0.05,
                    ),
                    child: Text(
                      _category[index],
                      style: AppTextStyle.black.copyWith(fontSize: 14),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
