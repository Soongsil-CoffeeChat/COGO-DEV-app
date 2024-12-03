// sealed class ButtonSize {
//   const ButtonSize();
//
//   static const double smallWidth = 150;
//   static const double largeWidth = double.infinity;
//
//   factory ButtonSize.small() = SmallButtonSize;
//   factory ButtonSize.large() = LargeButtonSize;
//
//   double get width;
// }
//
// /// small 버튼 크기
// class SmallButtonSize extends ButtonSize {
//   const SmallButtonSize();
//
//   @override
//   double get width => ButtonSize.smallWidth; // 클래스 상수 사용
// }
//
// /// large 버튼 크기
// class LargeButtonSize extends ButtonSize {
//   const LargeButtonSize();
//
//   @override
//   double get width => ButtonSize.largeWidth; // 클래스 상수 사용
// }
