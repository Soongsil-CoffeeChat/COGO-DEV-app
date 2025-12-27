import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart'; // 패키지 임포트 필요

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
    // Fallback 이미지를 생성하는 로직을 분리 (SVG 체크)
    Widget buildFallback() {
      if (fallbackAsset.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          fallbackAsset,
          width: width,
          height: height,
          fit: fit,
        );
      }
      return Image.asset(
        fallbackAsset,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // URL 유효성 체크 및 위젯 구성
    final image = (url != null && url!.isNotEmpty)
        ? Image.network(
            url!,
            width: width,
            height: height,
            fit: fit,
            // 네트워크 에러 시 SVG/PNG 구분된 fallback 호출
            errorBuilder: (_, __, ___) => buildFallback(),
          )
        : buildFallback(); // URL 없을 때도 동일한 로직 호출

    // 모양(Shape) 적용
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
