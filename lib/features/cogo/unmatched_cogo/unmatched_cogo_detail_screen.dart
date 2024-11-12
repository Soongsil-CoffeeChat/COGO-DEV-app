import 'package:cogo/common/enums/user_role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/cogo/unmatched_cogo/unmatched_cogo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoDetailScreen extends StatelessWidget {
  final UserRole role;

  const UnMatchedCogoDetailScreen({super.key, this.role = UserRole.MENTOR});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

    if (extra == null || !extra.containsKey('applicationId')) {
      throw Exception('필요한 데이터가 전달되지 않았습니다: $extra');
    }

    final applicationId = extra['applicationId'] as int;

    return ChangeNotifierProvider(
      create: (_) =>
          UnMatchedCogoDetailViewModel()..fetchCogoDetail(applicationId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Header(
                            title: '코고 신청 상세 정보',
                            subtitle: 'COGO를 통해 많은 성장을 기원합니다!',
                            onBackButtonPressed: () =>
                                Navigator.of(context).pop(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Consumer<UnMatchedCogoDetailViewModel>(
                            builder: (context, viewModel, child) {
                              if (viewModel.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              final item = viewModel.item;

                              if (item == null) {
                                return const Center(
                                  child: Text(
                                    '코고 신청 정보를 불러올 수 없습니다.',
                                    style: CogoTextStyle.body14,
                                  ),
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 0,
                                      maxWidth: double.infinity,
                                    ),
                                    child: IntrinsicWidth(
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF7F7F7),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          item.applicationMemo,
                                          style: CogoTextStyle.body12.copyWith(
                                            color: CogoColor.systemGray05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Text(
                                        '신청 시간:',
                                        style: CogoTextStyle.body12,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        item.formattedTimeSlot,
                                        style: CogoTextStyle.body12.copyWith(
                                          color: CogoColor.systemGray03,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Text(
                                        '신청 날짜:',
                                        style: CogoTextStyle.body12,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        item.applicationDate
                                            .toIso8601String()
                                            .split('T')[0], // 날짜만 표시
                                        style: CogoTextStyle.body12.copyWith(
                                          color: CogoColor.systemGray03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (role == UserRole.MENTOR)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<UnMatchedCogoDetailViewModel>(
                    builder: (context, viewModel, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: BasicButton(
                              text: '거절',
                              isClickable: true,
                              onPressed: () {
                                viewModel.reject(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BasicButton(
                              text: '수락',
                              isClickable: true,
                              onPressed: () {
                                viewModel.accept(context);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
