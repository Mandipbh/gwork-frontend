import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/provider/get_client_job_list_provider.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

Widget submitButton(
    {required BuildContext context,
    required Function onButtonTap,
    required Color backgroundColor,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    required String buttonName,
    required String iconAsset}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => onButtonTap(),
    child: Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: backgroundColor),
      child: Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonName.toUpperCase(),
            style: Theme.of(context).textTheme.button!.apply(color: textColor),
          ),
          const SizedBox(
            width: 8,
          ),
          Image.asset('assets/icons/$iconAsset',
              height: 30, width: 30, color: iconColor)
        ],
      )),
    ),
  );
}

Widget previousAndNextButtons(
    {required BuildContext context,
    required Function onPreviousTap,
    required Function onNextTap,
    required String nextButtonName,
    bool showPrevious = true,
    required Widget nextButtonIcon}) {
  return showPrevious
      ? Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onPreviousTap(),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.transparent),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, color: primaryColor),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        tr('Professional.logIn.onBoardingSetPassword.Previous')
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .apply(color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onNextTap(),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor),
                  child: Center(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        nextButtonName.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .apply(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      nextButtonIcon
                    ],
                  )),
                ),
              ),
            ),
          ],
        )
      : GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onNextTap(),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: primaryColor),
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  nextButtonName.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .apply(color: Colors.white),
                ),
                const SizedBox(
                  width: 8,
                ),
                nextButtonIcon
              ],
            )),
          ),
        );
}

Widget singleSelectionButtons(
    {required BuildContext context,
    required List<String> buttons,
    required int selected,
    double padding = 4,
    required Function onSelectionChange}) {
  return Container(
    height: AppBar().preferredSize.height,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(16), color: white),
    padding: EdgeInsets.all(padding),
    child: Row(
        children: buttons.map((buttonName) {
      int index = buttons.indexOf(buttonName);
      return Expanded(
          child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onSelectionChange(index + 1);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: selected == index + 1 ? primaryColor : white),
              child: Center(
                  child: Text(
                buttonName == "Applications"
                    ? Provider.of<GetClientJobListProvider>(context)
                                .applicationsModel ==
                            null
                        ? buttonName
                        : '$buttonName (${Provider.of<GetClientJobListProvider>(context).applicationsModel!.applications!.length})'
                    : buttonName,
                style: TextStyle(
                    fontSize: 14,
                    color: selected == index + 1 ? white : primaryColor),
              ))),
        ),
      ));
    }).toList()),
  );
}
