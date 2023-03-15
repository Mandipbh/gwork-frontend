import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// close snakbar
//  ScaffoldMessenger.of(context).hideCurrentSnackBar();

ProgressLoader(BuildContext context, data) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
                color: const Color(0xff343734),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Row(
                children: [
                  Flexible(
                    flex: 9,
                    child: Text(
                      data,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 23,
                      width: 23,
                      child: const CircularProgressIndicator(
                          strokeWidth: 3, backgroundColor: Color(0xff545855)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )));
}

ErrorLoader(BuildContext context, String data) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
                color: Color(0xffE45E5E),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Row(
                children: [
                  Flexible(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Text(
                        data,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 23,
                      width: 23,
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Color.fromARGB(255, 230, 118, 118)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )));
}
