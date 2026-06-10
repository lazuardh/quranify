import 'package:flutter/material.dart';

import '../../../lib.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: ResponsiveUtils(context).getMediaQueryHeight() * 0.1,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          decoration: InputDecoration(
            hint: Text(TextConstant.search, softWrap: true),
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
          ),
        ),
      ),
    );
  }
}
