import 'package:cogo/common/enums/user_role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/cogo/matched_cogo/matched_cogo_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchedCogoDetailScreen extends StatelessWidget {
  final dynamic role;

  const MatchedCogoDetailScreen({super.key, this.role = UserRole.MENTOR});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchedCogoDetailViewModel(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildContent(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildMessageContainer(),
          _buildDateAndTimePicker(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Header(
        title: role == UserRole.MENTOR ? '멘티님이 코고신청을 보냈어요' : '멘토님께 보낸 코고입니다 ',
        subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildMessageContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '안녕하세요, 저는 코고 개발자 김지은입니다. 다름이 아니라, 어쩌구저쩌구...',
            style: CogoTextStyle.body12,
          ),
        ),
      ),
    );
  }

  Widget _buildDateAndTimePicker() {
    return Consumer<MatchedCogoDetailViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DatePicker(date: DateTime.now(), day: DateTime.now()),
                const SizedBox(width: 5),
                SingleSelectionTimePicker(
                  timeSlots: ['09:00 ~ 10:00'],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}