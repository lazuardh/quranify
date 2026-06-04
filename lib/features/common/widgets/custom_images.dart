import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgWrapper extends StatelessWidget {
  final String _svgPath;
  final double? _height;
  final double? _width;
  final BoxFit _fit;
  final double _borderRadius;
  final bool _isNetwork;

  const CustomSvgWrapper({
    super.key,
    required String svgPath,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
    double borderRadius = 0.0,
    required bool isNetwork,
  }) : _svgPath = svgPath,
       _height = height,
       _width = width,
       _fit = fit,
       _borderRadius = borderRadius,
       _isNetwork = isNetwork;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: _isNetwork
          ? Visibility(
              visible: _svgPath.isNotEmpty,
              replacement: SvgPicture.asset(
                'assets/placeholder.svg', // Provide a placeholder SVG path or change it accordingly
                width: _width,
                height: _height,
                fit: _fit,
              ),
              child: Image.network(
                _svgPath,
                width: _width,
                height: _height,
                fit: _fit,
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        width: _width,
                        height: _height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    'assets/error_placeholder.svg', // Provide an error placeholder SVG path or change it accordingly
                    width: _width,
                    height: _height,
                    fit: _fit,
                  );
                },
              ),
            )
          : SvgPicture.asset(
              _svgPath,
              fit: _fit,
              width: _width,
              height: _height,
            ),
    );
  }
}
