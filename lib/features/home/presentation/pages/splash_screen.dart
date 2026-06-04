import 'package:flutter/material.dart';
import 'package:quranify/lib.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          CustomSvgWrapper(svgPath: AppIcons.logos, isNetwork: false),
          Spacer(),
          Padding(
            padding: EdgeInsetsGeometry.only(
              bottom:
                  ResponsiveUtils(context).getMediaQueryPaddingBottom() + 20,
            ),
            child: Text(
              TextConstant.createdBy,
              style: AppTextStyle.bold.copyWith(
                fontSize: 15,
                color: AppColors.brandTint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
