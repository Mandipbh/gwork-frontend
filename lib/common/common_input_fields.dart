import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';

Widget phoneNumberTextField() {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white)),
    child: TextField(
        keyboardType: TextInputType.number,
        controller: TextEditingController(text: ' '),
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            prefixIcon: Image.asset('assets/icons/phone.png', scale: 2),
            labelText: 'Phone Number'.toUpperCase(),
            counterText: "",
            prefixText: '+39')),
  );
}

Widget passwordTextField({required String label}) {
  bool isPasswordVisible = false;
  return StatefulBuilder(builder: (context, newState) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white)),
      child: TextField(
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
        onChanged: (value) {
          bool isValid = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
              .hasMatch(value);
          print('password => $value :: isValid => $isValid');
        },
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
    child: DropdownButton(
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {},
    ),
  );
}
