import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/coupon_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key, required this.applicationId});

  final int applicationId;

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  final CouponService _couponService = CouponService();
  bool _hasScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    _hasScanned = true;
    _verifyAndNavigate(barcode!.rawValue!);
  }

  Future<void> _verifyAndNavigate(String qrToken) async {
    try {
      await _couponService.verifyQrToken(qrToken);

      if (!mounted) return;
      context.pushReplacement(Paths.coupon, extra: widget.applicationId);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('유효하지 않은 QR 코드입니다.')),
      );
      // 재스캔 가능하도록 플래그 초기화
      setState(() => _hasScanned = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── 카메라 뷰 ──────────────────────────────────────
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // ── 어두운 오버레이 + 스캔 영역 뚫기 ───────────────
          _ScanOverlay(),

          // ── 상단 뒤로가기 ───────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // ── 스캔 안내 문구 (스캔 영역 내부 하단) ────────────
          Center(
            child: SizedBox(
              width: _ScanOverlay.scanSize,
              height: _ScanOverlay.scanSize,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    '상대방의 QR code를\n스캔해주세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 오버레이 (중앙 스캔 영역만 투명하게) ─────────────────────────

class _ScanOverlay extends StatelessWidget {
  static const double scanSize = 260.0;
  static const double cornerRadius = 20.0;
  static const double cornerLength = 28.0;
  static const double cornerWidth = 3.5;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OverlayPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const scanSize = _ScanOverlay.scanSize;
    const cornerRadius = _ScanOverlay.cornerRadius;

    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2;
    final scanRect = Rect.fromLTWH(left, top, scanSize, scanSize);

    // 어두운 배경
    final dimPaint = Paint()..color = Colors.black.withOpacity(0.55);
    final fullPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath = Path()
      ..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(cornerRadius)));
    final overlayPath = Path.combine(PathOperation.difference, fullPath, holePath);
    canvas.drawPath(overlayPath, dimPaint);

    // 모서리 라인
    final cornerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = _ScanOverlay.cornerWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const cl = _ScanOverlay.cornerLength;
    const cr = cornerRadius;

    canvas.drawPath(_cornerPath(scanRect.topLeft, cr, cl, _Corner.topLeft), cornerPaint);
    canvas.drawPath(_cornerPath(scanRect.topRight, cr, cl, _Corner.topRight), cornerPaint);
    canvas.drawPath(_cornerPath(scanRect.bottomLeft, cr, cl, _Corner.bottomLeft), cornerPaint);
    canvas.drawPath(_cornerPath(scanRect.bottomRight, cr, cl, _Corner.bottomRight), cornerPaint);
  }

  Path _cornerPath(Offset corner, double cr, double cl, _Corner pos) {
    final path = Path();
    switch (pos) {
      case _Corner.topLeft:
        path.moveTo(corner.dx, corner.dy + cr + cl);
        path.lineTo(corner.dx, corner.dy + cr);
        path.arcToPoint(Offset(corner.dx + cr, corner.dy),
            radius: Radius.circular(cr));
        path.lineTo(corner.dx + cr + cl, corner.dy);
      case _Corner.topRight:
        path.moveTo(corner.dx - cr - cl, corner.dy);
        path.lineTo(corner.dx - cr, corner.dy);
        path.arcToPoint(Offset(corner.dx, corner.dy + cr),
            radius: Radius.circular(cr));
        path.lineTo(corner.dx, corner.dy + cr + cl);
      case _Corner.bottomLeft:
        path.moveTo(corner.dx, corner.dy - cr - cl);
        path.lineTo(corner.dx, corner.dy - cr);
        path.arcToPoint(Offset(corner.dx + cr, corner.dy),
            radius: Radius.circular(cr), clockwise: false);
        path.lineTo(corner.dx + cr + cl, corner.dy);
      case _Corner.bottomRight:
        path.moveTo(corner.dx - cr - cl, corner.dy);
        path.lineTo(corner.dx - cr, corner.dy);
        path.arcToPoint(Offset(corner.dx, corner.dy - cr),
            radius: Radius.circular(cr), clockwise: false);
        path.lineTo(corner.dx, corner.dy - cr - cl);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum _Corner { topLeft, topRight, bottomLeft, bottomRight }
