import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CogoScreen extends StatelessWidget {
  const CogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                '내 코고함',
                style: TextStyle(
                  fontFamily: 'PretendardMedium',
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'COGO를 하면서 많은 성장을 기원해요!',
                style: TextStyle(
                  fontFamily: 'PretendardMedium',
                  fontSize: 12,
                  color: Color(0xFFAEAEB2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text(
                  '받은 코고',
                style: TextStyle(
                  fontFamily: 'PretendardMedium',
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push('/receivedCogo');
              },
            ),
            const SizedBox(height: 5),
            const Divider(height: 0.2, color: Color(0xFFEDEDED)),
            const SizedBox(height: 5),
            ListTile(
              title: const Text(
                  '성사된 코고',
                  style: TextStyle(
                    fontFamily: 'PretendardMedium',
                    fontSize: 18,
                  )
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push('/completed');
              },
            ),
          ],
        ),
        ),
      ),
    );
  }
}
