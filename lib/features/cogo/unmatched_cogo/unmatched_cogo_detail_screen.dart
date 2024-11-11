import 'package:cogo/common/enums/user_role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/cogo/unmatched_cogo/unmatched_cogo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoDetailScreen extends StatelessWidget {
  final UserRole role;

  const UnMatchedCogoDetailScreen({super.key, this.role = UserRole.MENTOR});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UnMatchedCogoDetailViewModel(),
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
                            title: '김지은님이 코고신청을 보냈어요',
                            subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                            onBackButtonPressed: () =>
                                Navigator.of(context).pop(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              maxWidth: double.infinity,
                            ),
                            child: IntrinsicWidth(
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '안녕하세요, 저는 코고 개발자 김지은입니다. 다름이 아니라, 어쩌구저쩌구',
                                  style: CogoTextStyle.body12
                                      .copyWith(color: CogoColor.systemGray05),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Consumer<UnMatchedCogoDetailViewModel>(
                          builder: (context, viewModel, child) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SizedBox(
                                height: 100,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    DatePicker(
                                      date: DateTime.now(),
                                      day: DateTime.now(),
                                    ),
                                    const SizedBox(width: 5),
                                    SingleSelectionTimePicker(
                                      selectedTimeSlot: role == UserRole.MENTOR
                                          ? viewModel.selectedTimeSlotIndex
                                          : null,
                                      onTimeSlotSelected:
                                          role == UserRole.MENTOR
                                              ? viewModel.selectTimeSlot
                                              : null,
                                      timeSlots: ['09:00 ~ 10:00'],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
                              isClickable: viewModel.isAcceptSelected,
                              onPressed: viewModel.isAcceptSelected
                                  ? () {
                                      viewModel.accept(context);
                                    }
                                  : null, // null 전달로 버튼 비활성화
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
