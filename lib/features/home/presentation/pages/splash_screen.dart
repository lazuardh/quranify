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
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const CustomSvgWrapper(
            svgPath: AppIcons.logos,
            isNetwork: false,
            width: 300,
            height: 300,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsetsGeometry.only(
              bottom: MediaQuery.paddingOf(context).bottom + 20,
            ),
            child: Text(
              TextConstant.version,
              style: AppTextStyle.bold.copyWith(
                fontSize: 12,
                color: AppColors.brandTint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
