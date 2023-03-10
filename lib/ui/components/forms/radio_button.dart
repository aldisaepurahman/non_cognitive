import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:non_cognitive/ui/components/core/color.dart';
import 'package:non_cognitive/ui/components/core/typography.dart';

enum RadioType { VERTICAL, HORIZONTAL }

class RadioButton extends StatefulWidget {
  final RadioType type;
  final List<String> choiceList;
  String selectedChoice;
  final ValueChanged<String?> onSelectedChoice;

  RadioButton(
      {super.key,
      required this.type,
      required this.choiceList,
      required this.selectedChoice,
      required this.onSelectedChoice});

  @override
  RadioButtonState createState() => RadioButtonState();
}

class RadioButtonState extends State<RadioButton> {

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];
    widget.choiceList.forEach((item) {
      choices.add(
          widget.type == RadioType.VERTICAL
              ? RadioListTile(
            title:
            TextTypography(type: TextType.DESCRIPTION, text: item),
            selected: widget.selectedChoice == item,
            value: item,
            groupValue: widget.selectedChoice,
            onChanged: (value) {
              setState(() {
                widget.selectedChoice = value!;
                widget.onSelectedChoice(widget.selectedChoice);
                // if (question[index].groupValue != "") {
                //   validateBtn[index] = true;
                // }
              });
            },
            activeColor: green,
          )
              : Row(
            children: [
              Radio(
                value: item,
                groupValue: widget.selectedChoice,
                activeColor: green,
                onChanged: (value) {
                  setState(() {
                    widget.selectedChoice = value!;
                    widget.onSelectedChoice(widget.selectedChoice);
                  });
                },
              ),
              TextTypography(type: TextType.DESCRIPTION, text: item)
            ],
          )
      );
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == RadioType.HORIZONTAL) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildChoiceList(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _buildChoiceList(),
    );
  }
}
