import 'package:cogo/common/enums/user_role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/domain/entity/requested_cogo_entity.dart';
import 'package:cogo/features/cogo/unmatched_cogo/unmatched_cogo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoDetailScreen extends StatelessWidget {
  final dynamic role;

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
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildContent(context)),
                if (role == UserRole.MENTOR) _buildMentorButtons(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<UnMatchedCogoDetailViewModel>(
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
              _buildHeader(context, item),
              const SizedBox(height: 20),
              _buildMessageContainer(item),
              const SizedBox(height: 20),
              _buildDateAndTimePicker(context, item),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, RequestedCogoEntity item) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Header(
        title: role == UserRole.MENTOR
            ? '${item.menteeName}님이 코고신청을 보냈어요'
            : '${item.mentorName}님께 보낸 코고입니다',
        subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildMessageContainer(RequestedCogoEntity item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 200.0,
        ),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          item.applicationMemo,
          style: CogoTextStyle.body12,
        ),
      ),
    );
  }

  Widget _buildDateAndTimePicker(
      BuildContext context, RequestedCogoEntity item) {
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
                child: Consumer<UnMatchedCogoDetailViewModel>(
                  builder: (context, viewModel, child) {
                    return SingleSelectionTimePicker(
                      selectedTimeSlot: role == UserRole.MENTOR
                          ? viewModel.selectedTimeSlotIndex
                          : null,
                      onTimeSlotSelected: role == UserRole.MENTOR
                          ? (index) {
                              viewModel.selectTimeSlot(index);
                            }
                          : null,
                      timeSlots: [item.formattedTimeSlot],
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

  Widget _buildMentorButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<UnMatchedCogoDetailViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            children: [
              Expanded(
                child: BasicButton(
                  text: '거절',
                  isClickable: true,
                  onPressed: () => viewModel.reject(context),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BasicButton(
                  text: '수락',
                  isClickable: viewModel.selectedTimeSlotIndex != null,
                  onPressed: viewModel.selectedTimeSlotIndex != null
                      ? () => viewModel.accept(context)
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
