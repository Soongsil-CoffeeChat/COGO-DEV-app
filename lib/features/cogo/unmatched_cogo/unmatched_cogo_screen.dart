import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/cogo/unmatched_cogo/unmatched_cogo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UnMatchedCogoScreen extends StatelessWidget {
  const UnMatchedCogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UnMatchedCogoViewModel()..fetchReceivedCogos(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Header(
                    title: '받은 코고',
                    subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<UnMatchedCogoViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (viewModel.items.isEmpty) {
                        return Center(
                          child: Text(
                            viewModel.role == Role.ROLE_MENTOR.name
                                ? '멘티에게 받은 코고 신청이 없습니다.'
                                : '멘토에게 보낸 코고 신청이 없습니다.',
                            style: CogoTextStyle.body14,
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: viewModel.items.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.items[index];
                          final formattedDate = DateFormat('yyyy/MM/dd')
                              .format(item.applicationDate);

                          return GestureDetector(
                            onTap: () {
                              viewModel.onCogoItemTapped(context, item);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    viewModel.role == Role.ROLE_MENTOR.name
                                        ? '${item.menteeName}님의 코고신청'
                                        : '${item.mentorName}님께 보낸 코고',
                                    style: CogoTextStyle.body16,
                                  ),
                                  Text(formattedDate,
                                      style: CogoTextStyle.body12.copyWith(
                                          color: CogoColor.systemGray03)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
