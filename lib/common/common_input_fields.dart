import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';

Widget phoneNumberTextField() {
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            icon: Image.asset('assets/icons/phone.png', height: 30, width: 30),
            labelText: 'Phone Number'.toUpperCase(),
            prefixText: '+39')),
  );
}

Widget passwordTextField({required String label}) {
  bool isPasswordVisible = false;
  return StatefulBuilder(
    builder: (context, newState) {
      return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: !isPasswordVisible,
            obscuringCharacter: '*',
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    newState((){
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 30,
                    color: primaryColor,
                  ),
                ),
                icon: Image.asset('assets/icons/password.png', height: 30, width: 30),
                labelText: label.toUpperCase())),
      );
    }
  );
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
            icon: Image.asset('assets/icons/$asset', height: 30, width: 30),
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
