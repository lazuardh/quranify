import 'package:flutter/material.dart';

import '../../../lib.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key, required this.onChanged});

  final void Function(String)? onChanged;

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
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomSearchWithoutSuffixIcon extends StatelessWidget {
  const CustomSearchWithoutSuffixIcon({super.key, required this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: ResponsiveUtils(context).getMediaQueryHeight() * 0.1,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hint: Text(TextConstant.search, softWrap: true),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
