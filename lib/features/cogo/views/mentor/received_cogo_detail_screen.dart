import 'package:flutter/material.dart';
import 'package:cogo/common/widgets/header.dart';
import 'package:cogo/common/widgets/custom_button.dart';

class ReceivedCogoDetailScreen extends StatelessWidget {
  const ReceivedCogoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  title: '김지은님이 코고신청을 보냈어요',
                  subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '안녕하세요, 저는 코고 개발자 김지은입니다. 다름이 아니라, 어쩌구저쩌구',
                    style: TextStyle(
                      fontFamily: 'PretendardMedium',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateButton(context, '7/31', '월', true),
                    _buildDateButton(context, '8/3', '목', false),
                    _buildDateButton(context, '9/9', '토', false),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeSlotButton(context, '09:00 ~ 10:00', true),
                    _buildTimeSlotButton(context, '09:00 ~ 10:00', false),
                    _buildTimeSlotButton(context, '09:00 ~ 10:00', false),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: '거절',
                      isSelected: false,
                      onPressed: () {
                        // 거절 버튼 로직
                      },
                    ),
                    CustomButton(
                      text: '수락',
                      isSelected: true,
                      onPressed: () {
                        // 수락 버튼 로직
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateButton(BuildContext context, String date, String day, bool isSelected) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              // 날짜 버튼 클릭 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.black : Colors.grey[300],
              foregroundColor: isSelected ? Colors.white : Colors.black,
              textStyle: const TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day, // 요일
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date, // 날짜
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlotButton(BuildContext context, String text, bool isSelected) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              // 시간대 버튼 클릭 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.black : Colors.grey[300],
              foregroundColor: isSelected ? Colors.white : Colors.black,
              textStyle: const TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
