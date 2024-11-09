import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';

// todo tablayout으로 추후 바꾸고 삭제
class HorizontalButtonList extends StatefulWidget {
  final List<String> buttonTitles;
  final ValueChanged<String> onButtonPressed;

  const HorizontalButtonList(
      {super.key, required this.buttonTitles, required this.onButtonPressed});

  @override
  _HorizontalButtonListState createState() => _HorizontalButtonListState();
}

class _HorizontalButtonListState extends State<HorizontalButtonList> {
  String? selectedButton;

  @override
  Widget build(BuildContext context) {
    double totalPadding = 40;
    double buttonPadding = 5;
    double buttonWidth = (MediaQuery.of(context).size.width -
            totalPadding -
            (buttonPadding * (widget.buttonTitles.length - 1))) /
        widget.buttonTitles.length;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: widget.buttonTitles
              .map((title) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: buttonPadding / 2),
                    child: _buildFieldButton(context, title, buttonWidth),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFieldButton(BuildContext context, String title, double width) {
    final bool isSelected = title == selectedButton;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedButton = title;
          });
          widget.onButtonPressed(title);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? CogoColor.systemGray05 : CogoColor.white50,
          foregroundColor:
              isSelected ? CogoColor.white50 : CogoColor.systemGray05,
          textStyle: CogoTextStyle.body12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: CogoColor.systemGray03),
          ),
          elevation: 0,
        ),
        child: Text(title),
      ),
    );
  }
}
