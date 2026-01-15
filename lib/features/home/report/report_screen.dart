import 'package:cogo/common/enums/report_reason.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatelessWidget {
  final int reporterId;
  final int reportedUserId;

  const ReportScreen({
    super.key,
    required this.reporterId,
    required this.reportedUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CogoColor.white50,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: CogoColor.white50,
        title: const Text(
          "신고하기",
          style: CogoTextStyle.body20,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: ReportReason.values.length,
          itemBuilder: (context, index) {
            final reason = ReportReason.values[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                reason.getString,
                style: CogoTextStyle.body16,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push(
                  Paths.reportDetail,
                  extra: {
                    'reason': reason,
                    'reporterId': reporterId,
                    'reportedUserId': reportedUserId,
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            color: CogoColor.systemGray02,
          ),
        ),
      ),
    );
  }
}