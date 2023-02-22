
import 'package:flutter/material.dart';

import '../colors.dart';

Widget submitButton(
    {required BuildContext context,
      required Function onButtonTap,
      required Color backgroundColor,
      Color textColor = Colors.white,
      Color iconColor = Colors.white,
      required String buttonName,
      required String iconAsset}) {
  return InkWell(
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
              Image.asset('assets/icons/$iconAsset',height: 30,width: 30,color: iconColor)
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
        child: InkWell(
          onTap: () => onPreviousTap(),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.transparent),
            child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back, color: primaryColor),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Previous Step'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .apply(color: primaryColor),
                    ),
                  ],
                )),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: InkWell(
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
      : InkWell(
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
      );
}