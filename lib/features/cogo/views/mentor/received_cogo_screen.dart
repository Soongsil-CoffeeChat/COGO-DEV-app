import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/widgets/header.dart';

class ReceivedCogoScreen extends StatelessWidget {
  const ReceivedCogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'title': '나는지은님의 코고신청', 'date': '2024/07/24'},
      {'title': '나는지은님의 코고신청', 'date': '2024/07/24'},
    ];

    return Scaffold(
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      // 클릭 시 수행할 작업 추가
                      context.push('/receivedCogoDetail');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontFamily: 'PretendardMedium',
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            item['date']!,
                            style: const TextStyle(
                              fontFamily: 'PretendardMedium',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
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
