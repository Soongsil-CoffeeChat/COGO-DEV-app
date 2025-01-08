import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/report/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportViewModel(),
      child: Scaffold(
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<ReportViewModel>(
                  builder: (context, viewModel, child) {
                return Column(
                  children: [
                    ListTile(
                      title: const Text(
                        '멘토링의 목적을 가지고 멘토가 만난것 같지 않아요',
                        style: CogoTextStyle.body16,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.push(Paths.reportDetail);
                      },
                    ),
                    const Divider(height: 1, color: CogoColor.systemGray02),
                    ListTile(
                      title: const Text(
                        '멘토링 중에 분쟁 발생했어요',
                        style: CogoTextStyle.body16,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.push(Paths.reportDetail);
                      },
                    ),
                    const Divider(height: 1, color: CogoColor.systemGray02),
                    ListTile(
                      title: const Text(
                        '멘토의 소속이나, 인적사항이 거짓인것 같아요',
                        style: CogoTextStyle.body16,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.push(Paths.reportDetail);
                      },
                    ),
                    const Divider(height: 1, color: CogoColor.systemGray02),
                    ListTile(
                        title: const Text('기타 부적절한 행위가 있었어요',
                            style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          context.push(Paths.reportDetail);
                        }),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
