import 'package:flutter/cupertino.dart';

class NetworkImageWithFallback extends StatelessWidget {
  const NetworkImageWithFallback({
    super.key,
    required this.url,
    this.fallbackAsset = 'assets/icons/3d_img/empty.png',
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.isCircle = false,
  });

  final String? url;
  final String fallbackAsset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    final image = (url != null && url!.isNotEmpty)
        ? Image.network(
            url!,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (_, __, ___) => Image.asset(fallbackAsset,
                width: width, height: height, fit: fit),
          )
        : Image.asset(fallbackAsset, width: width, height: height, fit: fit);

    if (isCircle) {
      return ClipOval(
          child: SizedBox(width: width, height: height, child: image));
    }
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}
