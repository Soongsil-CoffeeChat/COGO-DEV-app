import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkImageWithFallback extends StatelessWidget {
  const NetworkImageWithFallback({
    super.key,
    required this.url,
    this.fallbackAsset = 'assets/image/empty_profile_img.svg',
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
    Widget buildFallback() {
      if (fallbackAsset.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(fallbackAsset, width: width, height: height, fit: fit);
      }
      return Image.asset(fallbackAsset, width: width, height: height, fit: fit);
    }

    final image = (url != null && url!.isNotEmpty)
        ? CachedNetworkImage(
            imageUrl: url!,
            width: width,
            height: height,
            fit: fit,
            placeholder: (_, __) => SizedBox(width: width, height: height),
            errorWidget: (_, __, ___) => buildFallback(),
          )
        : buildFallback();

    if (isCircle) {
      return ClipOval(child: SizedBox(width: width, height: height, child: image));
    }
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}
