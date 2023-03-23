import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

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

Widget vatNumberTextField({required TextEditingController controller}) {
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
        prefixIcon: Image.asset('assets/icons/hash.png', scale: 2),
        labelText: tr('admin.VAT_Number').toUpperCase(),
        counterText: "",
      ),
    ),
  );
}

Widget birthDateTextField({required TextEditingController controller}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white)),
    child: TextField(
      keyboardType: TextInputType.datetime,
      controller: controller,
      maxLength: 10,
      decoration: InputDecoration(
        prefixIcon: Image.asset('assets/icons/calendar_birthday.png', scale: 2),
        labelText: tr('admin.Birth_Date').toUpperCase(),
        counterText: "",
      ),
    ),
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
        keyboardType: TextInputType.name,
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

Widget dropdownField(BuildContext context,
    {required String label,
    required String value,
    required Function(String? val) onChange,
    required String asset,
    required List<String> items}) {
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Center(
      child: DropdownButtonFormField(
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            "assets/icons/marker_location.png",
            scale: 2,
          ),
        ),
        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: onChange,
      ),
    ),
  );
}
