import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ProgressLoader(BuildContext context, data) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.85),
        decoration: BoxDecoration(
            color: const Color(0xff343734),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  data,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 23,
                width: 23,
                child: CircularProgressIndicator(
                    strokeWidth: 3, backgroundColor: Color(0xff545855)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
ErrorLoader(BuildContext context, String data) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.85),
        decoration: BoxDecoration(
            color: const Color(0xffE45E5E),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 23,
                width: 23,
                child: CircularProgressIndicator(
                    strokeWidth: 3, backgroundColor: Color(0xff545855)),
              ),
            ],
          ),
        ),
      )));
}
