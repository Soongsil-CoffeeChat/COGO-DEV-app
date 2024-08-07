import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/features/home/apply/view_models/memo_view_model.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoViewModel(),
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
                    title: '멘토님께 드릴 메모를 적어보세요',
                    subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Consumer<MemoViewModel>(
                    builder: (context, viewModel, child) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: viewModel.controller,
                          maxLength: 200,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: '내용을 입력해주세요',
                            hintStyle: const TextStyle(
                              fontFamily: 'PretendardMedium',
                              fontSize: 14,
                              color: Color(0xFFB4B4B4),
                            ),
                            border: InputBorder.none,
                            counterText: '${viewModel.charCount}/200',
                            counterStyle: const TextStyle(
                              fontFamily: 'PretendardMedium',
                              fontSize: 12,
                              color: Color(0xFFB4B4B4),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<MemoViewModel>(
                        builder: (context, viewModel, child) {
                          return ElevatedButton(
                            onPressed: viewModel.charCount > 0
                                ? () => viewModel.saveMemo(context)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: viewModel.charCount > 0
                                  ? Colors.black
                                  : Colors.grey[300],
                              foregroundColor: viewModel.charCount > 0
                                  ? Colors.white
                                  : Colors.black,
                              textStyle: const TextStyle(
                                fontFamily: 'PretendardMedium',
                                fontSize: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('다음'),
                          );
                        },
                      ),
                    ),
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
