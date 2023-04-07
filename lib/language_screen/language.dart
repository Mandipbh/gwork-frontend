import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';


class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selectedRadioTile = 0;

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     setState(() {
       _selectedRadioTile = context.locale.languageCode == 'en' ? 0 : 1;
     });
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> languageList = [
      {
        "image": "assets/images/english_language.png",
        "title": tr('admin.language.english'),
        "value": "en"
      },
      {
        "image": "assets/images/italian_language.png",
        "title": tr('admin.language.italian'),
        "value": "it"
      },
    ];

    return Scaffold(
        backgroundColor: whiteF2F,
        appBar: AppBar(
          title: Text(
            tr('admin.language.language'),
          ),
        ),
        body: StatefulBuilder(builder: (context, newState) {
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
                      Image.asset(languageList[index]["image"]!,
                          height: 24, width: 24),
                      const SizedBox(width: 12),
                      Text(
                        languageList[index]["title"]!,
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
                  groupValue: _selectedRadioTile,
                  onChanged: (int? index) {
                    translate(languageList[index!]['value']!, context);
                  },
                ),
                const Divider(color: greyD3D, thickness: 1),
              ],
            ),
          );
        }));
  }

  translate(String key, BuildContext context) async {
    Locale locale = Locale(key);
    context.setLocale(locale).then((value) {
      setState(() {
        _selectedRadioTile = context.locale.languageCode == 'en' ? 0 : 1;
      });
    });
  }
}
