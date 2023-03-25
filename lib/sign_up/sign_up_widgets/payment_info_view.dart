import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/common/common_input_fields.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class PaymentInfoView extends StatelessWidget {
  const PaymentInfoView({super.key});

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
                  builder: (context, value, child) => Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: TextField(
                        controller: value.expireDateController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CardExpirationFormatter()],
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
                            labelText: tr('client.log_in.sign_up.Expire_date')
                                .toUpperCase())),
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
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
