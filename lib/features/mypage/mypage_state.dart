import 'package:cogo/domain/entity/my_page_info.dart';

class MypageUiState {
  final bool isLoading;
  final bool hasError;
  final MyPageInfo? myPageInfo;
  final String? role;

  const MypageUiState({
    this.isLoading = false,
    this.hasError = false,
    this.myPageInfo,
    this.role,
  });

  MypageUiState copyWith({
    bool? isLoading,
    bool? hasError,
    MyPageInfo? myPageInfo,
    String? role,
  }) {
    return MypageUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      myPageInfo: myPageInfo ?? this.myPageInfo,
      role: role ?? this.role,
    );
  }
}
