import 'package:flutter/material.dart';
import 'package:non_cognitive/ui/components/card/family_card.dart';
import 'package:non_cognitive/ui/components/card/psychology_card.dart';
import 'package:non_cognitive/ui/components/card/statistics_card.dart';
import 'package:non_cognitive/ui/components/core/button.dart';
import 'package:non_cognitive/ui/components/core/color.dart';
import 'package:non_cognitive/ui/components/core/typography.dart';
import 'package:non_cognitive/ui/components/navigation/appbar.dart';
import 'package:non_cognitive/ui/screen/questionnaire/questionnaire.dart';
import 'package:non_cognitive/utils/question_list.dart';
import 'package:non_cognitive/utils/user_type.dart';

class StudentHome extends StatefulWidget {
  final UserType type;
  final bool expandedContents;

  const StudentHome({super.key, required this.type, required this.expandedContents});

  @override
  _StudentHome createState() => _StudentHome();

}

class _StudentHome extends State<StudentHome> {
  bool needConfirmation = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == UserType.GURU) {
      return Scaffold(
        appBar: AppBarCustom(
          title: "Statistik Siswa",
          useBackButton: true,
          onBackPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: _renderExtendedPage(widget.type),
        floatingActionButton: ButtonWidget(
          background: orange,
          tint: black,
          type: ButtonType.FLOAT,
          icon: Icons.arrow_upward,
          onPressed: () {},
        ),
      );
    } else if (widget.expandedContents) {
      return _renderExtendedPage(widget.type);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextTypography(
              type: TextType.DESCRIPTION,
              text: "Anda belum pernah melakukan tes sebelumnya\nSilahkan ikuti tes terlebih dahulu",
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ButtonWidget(
            background: green,
            tint: white,
            type: ButtonType.LARGE,
            content: "Mulai Tes",
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Questionnaire(),
                  ));
            },
          )
        ],
      ),
    );
  }

  ListView _renderExtendedPage(UserType type) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 25),
      children: [
        if (type == UserType.SISWA) Visibility(
            visible: needConfirmation,
            child: Container(
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTypography(
                              type: TextType.TITLE,
                              text: "Perhatian!",
                            ),
                            TextTypography(
                              type: TextType.DESCRIPTION,
                              text: "Anda dinyatakan naik kelas menuju tingkat berikutnya.",
                            ),
                          ],
                        )
                    ),
                    const SizedBox(width: 10),
                    ButtonWidget(
                      background: orange,
                      tint: white,
                      type: ButtonType.MEDIUM,
                      content: "Baik",
                      onPressed: () {
                        setState(() {
                          needConfirmation = false;
                        });
                      },
                    )
                  ],
                )
            )
        ),
        const StatisticsCard(),
        const PsychologyCard(
            title: "Kesejahteraan Psikologi",
            chartTitle: "Diagram Kesejahteraan Psikologi"
        ),
        const PsychologyCard(
            title: "Aktivitas Belajar",
            chartTitle: "Diagram Aktivitas Belajar"
        ),
        FamilyCard(items: family_questions_dummy)
      ],
    );
  }
}