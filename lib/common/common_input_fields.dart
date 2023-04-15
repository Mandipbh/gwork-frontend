import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

Widget phoneNumberTextField(
    {required TextEditingController controller,
    required BuildContext context}) {
  return Container(
    height: 65,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white)),
    child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            prefixIcon: Image.asset('assets/icons/phone.png', scale: 2),
            labelText: tr('admin.sign_in.phone_number').toUpperCase(),
            counterText: "",
            prefixText: '+39')),
  );
}

Widget vatNumberTextField(
    {required TextEditingController controller,
    required BuildContext context}) {
  return Container(
    height: 65,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white)),
    child: TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
      controller: controller,
      maxLength: 16,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        prefixIcon: Image.asset('assets/icons/hash.png', scale: 2),
        labelText: tr('client.log_in.sign_up.Tax_Code').toUpperCase(),
        counterText: "",
      ),
    ),
  );
}

Widget birthDateTextField(
    TextEditingController controller, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      DateTime? date = await showDatePicker(
          context: context,
          builder: (context, picker) {
            return Theme(
              //TODO: change colors
              data: ThemeData.dark().copyWith(
                splashColor: Colors.white,
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xfff8f8f8),
                ),
                dialogBackgroundColor: Colors.grey.shade900,
              ),
              child: picker!,
            );
          },
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 355000)),
          lastDate: DateTime.now());
      controller.text = '${date!.day}/${date.month}/${date.year}';
    },
    child: Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: TextField(
          enabled: false,
          controller: controller,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontSize: 18, color: Colors.black12),
            icon: Image.asset('assets/icons/calendar_birthday.png',
                height: 24, width: 24),
            labelText: tr('admin.Birth_Date').toUpperCase(),
          )),
    ),
  );
  Container(
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
      height: 65,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        obscuringCharacter: '*',
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
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

Widget timeTextField({
  required String label,
  required String asset,
  required BuildContext context,
  TextEditingController? controller,
}) {
  controller ??= TextEditingController();
  return Container(
    height: 65,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: TextField(
      controller: controller,
      readOnly: true,
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
      decoration: InputDecoration(
        icon: Image.asset('assets/icons/$asset', height: 24, width: 24),
        labelText: label.toUpperCase(),
      ),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          builder: (context, picker) {
            return Theme(
              //TODO: change colors
              data: ThemeData.dark().copyWith(
                splashColor: Colors.white,
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xfff8f8f8),
                ),
                dialogBackgroundColor: Colors.grey.shade900,
              ),
              child: picker!,
            );
          },
          context: context!,
        );

        if (pickedTime != null) {
          print(pickedTime.format(context)); //output 10:51 PM

          print(pickedTime
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", "")
              .split("y")
              .last);

          // print(formattedTime); //output 14:59:00
          controller!.text = pickedTime
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", "")
              .split("y")
              .last;
        } else {
          print("Time is not selected");
        }
      },
    ),
  );
}

Widget budgetTextField(
    {required String label,
    required String asset,
    required BuildContext context,
    TextEditingController? controller,
    keyboardType = TextInputType.number}) {
  controller ??= TextEditingController();
  return Container(
    height: 65,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: TextField(
        maxLength: 25,
        controller: controller,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            counterText: '',
            icon: Image.asset('assets/icons/$asset', height: 24, width: 24),
            labelText: label.toUpperCase())),
  );
}

Widget nameTextField(
    {required String label,
    required String asset,
    required BuildContext context,
    int? maxLength,
    TextEditingController? controller,
    keyboardType = TextInputType.name}) {
  controller ??= TextEditingController();
  return Container(
    height: 65,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            counterText: '',
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
