import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// 약관 데이터 모델
class _Term {
  final String title;
  final bool isRequired;
  bool agreed;
  final String? route;

  _Term({
    required this.title,
    required this.isRequired,
    this.agreed = false,
    this.route,
  });
}

class TermsBottomSheet extends StatefulWidget {
  const TermsBottomSheet({Key? key}) : super(key: key);

  @override
  _TermsBottomSheetState createState() => _TermsBottomSheetState();
}

class _TermsBottomSheetState extends State<TermsBottomSheet> {
  bool _allAgree = false;

  /// 약관 목록
  final List<_Term> _terms = [
    _Term(
      title: "서비스 이용약관 (필수)",
      isRequired: true,
      route: '${Paths.agreement}/${Paths.termsOfService}',
    ),
    _Term(
      title: "개인정보 수집 및 이용 동의 (필수)",
      isRequired: true,
      route: '${Paths.agreement}/${Paths.privacyPolicy}',
    ),
    _Term(title: "만 14세 이상 (필수)", isRequired: true),
    _Term(title: "서비스 알림 수신  (필수)", isRequired: true),
    _Term(title: "서비스 혜택 정보 수신 (선택)", isRequired: false),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sheetHeight = screenHeight * 0.45;

    bool isAllRequiredAgreed =
        _terms.where((t) => t.isRequired).every((term) => term.agreed);

    return Material(
      color: CogoColor.white50,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: sheetHeight,
        child: Column(
          children: [
            /// 상단 드래그 인디케이터
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: CogoColor.systemGray03,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // 모두 동의
            _buildAllAgreeTile(),

            const Divider(color: CogoColor.systemGray02, thickness: 1),

            /// 약관 목록
            Expanded(
              child: ListView.builder(
                itemCount: _terms.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: _buildTermTile(_terms[index]),
                  );
                },
              ),
            ),

            /// 시작하기 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BasicButton(
                size: BasicButtonSize.LARGE,
                text: '시작하기',
                isClickable: isAllRequiredAgreed,
                onPressed: _onStartPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// "모두 동의" 영역
  Widget _buildAllAgreeTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListTile(
        horizontalTitleGap: 10,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              _allAgree = !_allAgree;
              for (final term in _terms) {
                term.agreed = _allAgree;
              }
            });
          },
          child: SvgPicture.asset(
            _allAgree
                ? 'assets/icons/button/check.svg'
                : 'assets/icons/button/uncheck.svg',
          ),
        ),
        title: const Text(
          "전체동의 (선택항목포함)",
          style: CogoTextStyle.bodySB16,
        ),
        onTap: () {
          setState(() {
            _allAgree = !_allAgree;
            for (final term in _terms) {
              term.agreed = _allAgree;
            }
          });
        },
      ),
    );
  }

  /// 개별 약관 타일
  Widget _buildTermTile(_Term term) {
    return InkWell(
      onTap: () {
        if (term.route != null) {
          context.push(term.route!);
        } else {
          setState(() {
            term.agreed = !term.agreed;
            _checkAllAgreeStatus();
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 체크 아이콘
            GestureDetector(
              onTap: () {
                setState(() {
                  term.agreed = !term.agreed;
                  _checkAllAgreeStatus();
                });
              },
              child: SvgPicture.asset(
                term.agreed
                    ? 'assets/icons/button/check.svg'
                    : 'assets/icons/button/uncheck.svg',
              ),
            ),
            const SizedBox(width: 10),
            // 텍스트
            Expanded(
              child: Text(
                term.title,
                style: CogoTextStyle.bodyL12,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 전체 동의 여부 재확인
  void _checkAllAgreeStatus() {
    final areAllChecked = _terms.every((term) => term.agreed == true);
    _allAgree = areAllChecked;
  }

  /// "시작하기" 버튼 눌렀을 때 (필수 약관 체크 여부 확인)
  void _onStartPressed() {
    context.push('${Paths.agreement}/${Paths.phone}');
  }
}
