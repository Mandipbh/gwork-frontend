import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/common/common_input_fields.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class PaymentInfoView extends StatelessWidget {
  PaymentInfoView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              tr('client.log_in.sign_up.Paymen_method'),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(tr('client.log_in.sign_up.add_payment_method'),
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 40),
          nameTextField(
              controller:
                  Provider.of<SignUpProvider>(context).cardHolderController,
              maxLength: 25,
              label: tr('client.log_in.sign_up.card_holder'),
              asset: 'user_first_name.png'),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                controller:
                    Provider.of<SignUpProvider>(context).cardNumberController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                maxLength: 16,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    counterText: "",
                    icon: Image.asset('assets/icons/credit_card_shield.png',
                        height: 24, width: 24),
                    labelText:
                        tr('client.log_in.sign_up.Card_number').toUpperCase())),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Consumer<SignUpProvider>(
                  builder: (context, value, child) => GestureDetector(
                    // onTap: () async {
                    //   final selected = await showMonthYearPicker(
                    //     context: context,
                    //     builder: (context, picker) {
                    //       return Theme(
                    //         data: ThemeData.dark().copyWith(
                    //           splashColor: Colors.white,
                    //           colorScheme: const ColorScheme.dark(
                    //             primary: Color(0xfff8f8f8),
                    //           ),
                    //           dialogBackgroundColor: Colors.grey.shade900,
                    //         ),
                    //         child: picker!,
                    //       );
                    //     },
                    //     initialDate: DateTime.now(),
                    //     firstDate: DateTime(2019),
                    //     lastDate: DateTime(4000),
                    //   );
                    //
                    //   log("${value.expireDateController.text}");
                    //   value.expireDateController.text =
                    //       '${selected!.month}/${selected.year}';
                    //   var newDate =
                    //       DateFormat("mm/yy").parse(selected.toString());
                    // },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                            // enabled: false,
                            controller: value.expireDateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMonthInputFormatter(),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              int year;
                              int month;
                              if (value.contains(RegExp(r'(/)'))) {
                                var split = value.split(RegExp(r'(/)'));

                                month = int.parse(split[0]);
                                year = int.parse(split[1]);
                              } else {
                                month = int.parse(
                                    value.substring(0, (value.length)));
                                year =
                                    -1; // Lets use an invalid year intentionally
                              }
                              if ((month < 1) || (month > 12)) {
                                // A valid month is between 1 (January) and 12 (December)
                                return 'Expiry month is invalid';
                              }
                              var fourDigitsYear = convertYearTo4Digits(year);
                              if ((fourDigitsYear < 1) ||
                                  (fourDigitsYear > 2099)) {
                                // We are assuming a valid should be between 1 and 2099.
                                // Note that, it's valid doesn't mean that it has not expired.
                                return 'Expiry year is invalid';
                              }
                              if (!hasDateExpired(month, year)) {
                                return "Card has expired";
                              }
                              return null;
                            },
                            style: const TextStyle(fontSize: 18),
                            maxLength: 5,
                            decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: 'mm/yy',
                                hintStyle: const TextStyle(
                                    fontSize: 18, color: Colors.black12),
                                icon: Image.asset(
                                    'assets/icons/calendar_expiry_date.png',
                                    height: 24,
                                    width: 24),
                                labelText:
                                    tr('client.log_in.sign_up.Expire_date')
                                        .toUpperCase())),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                      controller:
                          Provider.of<SignUpProvider>(context).cvvController,
                      style: const TextStyle(fontSize: 18),
                      obscureText: true,
                      obscuringCharacter: '*',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          icon: Image.asset('assets/icons/lock_unlocked.png',
                              height: 24, width: 24),
                          labelText:
                              tr('client.log_in.sign_up.CVV').toUpperCase())),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }

    return newValue.copyWith(
      text: '',
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
