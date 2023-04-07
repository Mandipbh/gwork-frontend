import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
ProgressLoader(BuildContext context, data) {
  fToast = FToast();
  fToast!.init(context).showToast(
        child: ErrorWidget(context, data, false),
        gravity: ToastGravity.TOP,
        toastDuration: Duration(seconds: 5),
      );
}

FToast? fToast;

ErrorWidget(BuildContext context, String data, bool isError) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: isError ? Color(0xffE45E5E) : Color(0xff343734),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0),
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
  fToast = FToast();
  fToast!.init(context).showToast(
        child: ErrorWidget(context, data, true),
        gravity: ToastGravity.TOP,
        toastDuration: Duration(seconds: 5),
      );
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
