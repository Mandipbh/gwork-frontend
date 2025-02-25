import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';

Widget phoneNumberTextField({required TextEditingController controller}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white)),
    child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            prefixIcon: Image.asset('assets/icons/phone.png', scale: 2),
            labelText: tr('admin.sign_in.phone_number').toUpperCase(),
            counterText: "",
            prefixText: '+39')),
  );
}

Widget passwordTextField(
    {required String label, required TextEditingController controller}) {
  bool isPasswordVisible = false;
  return StatefulBuilder(builder: (context, newState) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        obscuringCharacter: '*',
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                newState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              child: Icon(
                isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 24,
                color: primaryColor,
              ),
            ),
            prefixIcon: Image.asset('assets/icons/password.png', scale: 2),
            labelText: label.toUpperCase()),
      ),
    );
  });
}

Widget nameTextField(
    {required String label,
    required String asset,
    TextEditingController? controller,
    keyboardType = TextInputType.name}) {
  controller ??= TextEditingController();
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 18),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            icon: Image.asset('assets/icons/$asset', height: 24, width: 24),
            labelText: label.toUpperCase())),
  );
}

Widget multilineTextField(
    {required String label,
    required String asset,
    TextEditingController? controller}) {
  controller ??= TextEditingController();
  return Container(
    height: 120,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 18),
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Image.asset('assets/icons/$asset', height: 30, width: 30),
            ),
            labelText: label.toUpperCase())),
  );
}

Widget dropdownField(
    {required String label,
    required String asset,
    required List<String> items}) {
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Center(
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: Icon(
            Icons.expand_more,
            color: Colors.black,
            size: 26,
          ),
          prefixIcon: Row(
            children: [
              Image.asset(
                "assets/icons/marker_location.png",
                scale: 2,
              ),
            ],
          ),
        ),
        hint: Text('Please choose account type'), // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {},
      ),
    ),
  );
}
