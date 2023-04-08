import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

ProgressLoader(BuildContext context, data) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
    messageText: ErrorWidget(context, data, false),
  ).show(context);
}

ErrorWidget(BuildContext context, String data, bool isError) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: isError ? const Color(0xffE45E5E) : const Color(0xff545855),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16.0),
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
                backgroundColor: Colors.white.withOpacity(0.2)),
          ),
        ],
      ),
    ),
  );
}

ErrorLoader(BuildContext context, String data) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
    messageText: ErrorWidget(context, data, true),
  ).show(context);
}

void openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DefaultTextStyle(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              child: Text(
                'Loading...',
              )),
          Container(
            height: 10,
          ),
          Container(
            height: 25,
            width: 25,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        ],
      );
    },
  );
}
