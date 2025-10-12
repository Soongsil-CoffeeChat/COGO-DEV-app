import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/domain/entity/cogo_detail_entity.dart';
import 'package:cogo/features/cogo/matched_cogo/matched_cogo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MatchedCogoDetailScreen extends StatelessWidget {
  const MatchedCogoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extra == null || !extra.containsKey('applicationId')) {
      return const Center(
        child: Text(
          '코고 신청 정보를 불러올 수 없습니다.',
          style: CogoTextStyle.body14,
        ),
      );
    }
    final applicationId = extra['applicationId'] as int;
    final otherPartyName = extra['otherPartyName'] as String;

    return ChangeNotifierProvider(
      create: (_) =>
          MatchedCogoDetailViewModel()..fetchCogoDetail(applicationId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildContent(context, otherPartyName)), // ✅ 전달
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, String otherPartyName) {
    return Consumer<MatchedCogoDetailViewModel>(
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

        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, viewModel.role, item, otherPartyName),
              const SizedBox(height: 20),
              _buildMessageContainer(item),
              const SizedBox(height: 20),
              _placeTimeContainer(context, item),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String? role,
    CogoDetailEntity item,
    String otherPartyName,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Header(
        title: role == Role.ROLE_MENTOR.name
            ? '$otherPartyName님이 코고신청을 보냈어요'
            : '$otherPartyName님께 보낸 코고입니다',
        subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildMessageContainer(CogoDetailEntity item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 200.0,
        ),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: CogoColor.systemGray01,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          item.applicationMemo,
          style: CogoTextStyle.body12,
        ),
      ),
    );
  }

  Widget _placeTimeContainer(BuildContext context, CogoDetailEntity item) {
    final dateStr = DateFormat('yyyy-MM-dd').format(item.applicationDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 90.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: CogoColor.systemGray01,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '일정',
              style: CogoTextStyle.body14,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  dateStr,
                  style: CogoTextStyle.bodyR12
                      .copyWith(color: CogoColor.systemGray04),
                ),
                const SizedBox(width: 3),
                Text(
                  "/",
                  style: CogoTextStyle.bodyR12
                      .copyWith(color: CogoColor.systemGray04),
                ),
                const SizedBox(width: 3),
                Text(
                  item.applicationStartTime,
                  style: CogoTextStyle.bodyR12
                      .copyWith(color: CogoColor.systemGray04),
                ),
                const SizedBox(width: 3),
                Text(
                  "~",
                  style: CogoTextStyle.bodyR12
                      .copyWith(color: CogoColor.systemGray04),
                ),
                const SizedBox(width: 3),
                Text(
                  item.applicationEndTime,
                  style: CogoTextStyle.bodyR12
                      .copyWith(color: CogoColor.systemGray04),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '장소',
              style: CogoTextStyle.body14,
            ),
            const SizedBox(height: 4),
            Text(
              '커피나무 숭실대점 / 서울 동작구 상도로 61길 65 1층',
              style:
                  CogoTextStyle.bodyR12.copyWith(color: CogoColor.systemGray04),
            ),
          ],
        ),
      ),
    );
  }
}
