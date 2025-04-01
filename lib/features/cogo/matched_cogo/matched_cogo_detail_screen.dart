import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/domain/entity/cogo_info_entity.dart';
import 'package:cogo/features/cogo/matched_cogo/matched_cogo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

    return ChangeNotifierProvider(
      create: (_) =>
          MatchedCogoDetailViewModel()..fetchCogoDetail(applicationId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
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
              _buildHeader(context, viewModel.role, item),
              const SizedBox(height: 20),
              _buildMessageContainer(item),
              _buildDateAndTimePicker(context, item),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, String? role, CogoInfoEntity item) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Header(
        title: role == Role.ROLE_MENTOR.name
            ? '${item.menteeName}님이 코고신청을 보냈어요'
            : '${item.mentorName}님께 보낸 코고입니다',
        subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildMessageContainer(CogoInfoEntity item) {
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

  Widget _buildDateAndTimePicker(BuildContext context, CogoInfoEntity item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DatePicker(
              date: item.applicationDate,
              day: item.applicationDate,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: Consumer<MatchedCogoDetailViewModel>(
                  builder: (context, viewModel, child) {
                    return SingleSelectionTimePicker(
                      timeSlots: [item.formattedTimeSlot],
                      isSelectedTimePicker: false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
