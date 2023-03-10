import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/language_screen/language_provider/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> languageList = [
      {
        "image": "assets/images/english_language.png",
        "title": "English",
      },
      {
        "image": "assets/images/italian_language.png",
        "title": "Italian",
      },
    ];

    return Scaffold(
        backgroundColor: whiteF2F,
        appBar: AppBar(
          title: const Text(
            'Language',
          ),
        ),
        body: Consumer<LanguageProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemCount: languageList.length,
              itemBuilder: (context, index) => Column(
                children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Row(
                      children: [
                        Image.asset(languageList[index]["image"],
                            height: 24, width: 24),
                        const SizedBox(width: 12),
                        Text(
                          languageList[index]["title"],
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // autofocus: true,
                    activeColor: primaryColor,
                    //selected: true,
                    value: index,
                    groupValue: value.selectedRadioTile,
                    onChanged: (Object? val) {
                      value.onGroupChange(val);
                    },
                    // onChanged: (bool value) {
                    //   setState(() {
                    //     _value = value;
                    //   });
                    // },
                  ),
                  const Divider(color: greyD3D, thickness: 1),
                ],
              ),
            );
          },
        ));
  }
}
