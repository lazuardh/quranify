import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as context;

import '../../../../lib.dart';

extension CustomDialog on context.BuildContext {
  void successDialog({
    required String message,
    Function()? onPressed,
    bool isShowButton = false,
    TextStyle? style,
  }) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        bool isClose = false;

        void close(bool close) {
          if (close) {
            Navigator.pop(ctx);
            if (onPressed != null) onPressed();
          }
        }

        Timer.periodic(const Duration(seconds: 2), (timer) {
          timer.cancel();
          isClose = !isClose;
          close(isClose);
        });

        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils(ctx).getMediaQueryWidth() > 430
                ? ((ResponsiveUtils(ctx).getMediaQueryWidth() - 430) / 2) +
                      AppGap.extraLarge * 2
                : AppGap.extraLarge * 2,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          isClose = !isClose;
                          close(isClose);
                        },
                        child: Icon(Icons.close_sharp),
                      ),
                    ),
                    Center(child: Icon(Icons.done)),
                  ],
                ),
              ),
              const Gap(height: AppGap.medium),
              Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
                style: style ?? AppTextStyle.semiBold,
              ),
              Visibility(
                visible: isShowButton,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppGap.large),
                  child: ButtonPrimary(
                    "OK",
                    width: 150,
                    borderRadius: AppBorderRadius.normal,
                    fontWeight: AppFontWeight.regular,
                    onPressed: () {
                      isClose = !isClose;
                      close(isClose);
                    },
                  ),
                ),
              ),
              const Gap(height: AppGap.normal),
            ],
          ),
        );
      },
    );
  }

  void loadingDialog({Key? key, bool isDownload = false}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        final responsive = ResponsiveUtils(context);
        return Dialog(
          backgroundColor: AppColors.secondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.large),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: (responsive.getMediaQueryWidth() - 200) / 2,
          ),
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Visibility(
                  visible: isDownload,
                  child: const Padding(
                    padding: EdgeInsets.only(top: AppGap.normal),
                    child: Text("Downloading..."),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void confirmationDialog({
    required String message,
    required Function() onPressed,
  }) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils(this).getMediaQueryWidth() > 430
                ? ((ResponsiveUtils(this).getMediaQueryWidth() - 430) / 2) +
                      AppGap.medium * 2
                : AppGap.medium * 2,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Confirmation",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.semiBold.copyWith(
                  fontSize: AppFontSize.medium,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Gap(height: AppGap.medium),
              Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.regular.copyWith(
                  fontSize: AppFontSize.small,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Gap(height: AppGap.large),
              Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(
                      "Cancel",
                      borderColor: AppColors.ink,
                      buttonColor: AppColors.n400,
                      labelColor: AppColors.ink,
                      fontWeight: AppFontWeight.regular,
                      borderRadius: AppBorderRadius.normal,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Gap(),
                  Expanded(
                    child: ButtonPrimary(
                      "OK",
                      borderRadius: AppBorderRadius.normal,
                      fontWeight: AppFontWeight.regular,
                      buttonColor: AppColors.success,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void attentionDialog({
    required String message,
    required Function() onPressed,
  }) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils(this).getMediaQueryWidth() > 430
                ? ((ResponsiveUtils(this).getMediaQueryWidth() - 430) / 2) +
                      AppGap.medium * 2
                : AppGap.medium * 2,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Attention!",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.semiBold.copyWith(
                  fontSize: AppFontSize.medium,
                ),
              ),
              const Gap(height: AppGap.large),
              Icon(Icons.error),
              const Gap(height: AppGap.medium),
              Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.regular.copyWith(
                  fontSize: AppFontSize.small,
                ),
              ),
              const Gap(height: AppGap.large),
              Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(
                      "Cancel",
                      borderColor: AppColors.ink,
                      buttonColor: AppColors.secondary,
                      labelColor: AppColors.ink,
                      fontWeight: AppFontWeight.regular,
                      borderRadius: AppBorderRadius.normal,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Gap(),
                  Expanded(
                    child: ButtonPrimary(
                      "OK",
                      borderRadius: AppBorderRadius.normal,
                      fontWeight: AppFontWeight.regular,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
