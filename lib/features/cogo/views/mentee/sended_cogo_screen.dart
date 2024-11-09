import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/cogo/view_models/mentee/sended_cogo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendedCogoScreen extends StatelessWidget {
  const SendedCogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SendedCogoViewModel(),
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
                    title: '보낸 코고',
                    subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer<SendedCogoViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: viewModel.items.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.items[index];
                          return GestureDetector(
                            onTap: () => viewModel.onItemTapped(context, index),
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
                                  Text(item['title']!,
                                      style: CogoTextStyle.body16),
                                  Text(item['date']!,
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
