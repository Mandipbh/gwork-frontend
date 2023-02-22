import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/common/common_input_fields.dart';

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
              'Payment Method',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text('Add payment method for your account',
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 40),
          nameTextField(
              label: 'card holder',
              asset: 'user_first_name.png'),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    icon: Image.asset('assets/icons/credit_card_shield.png',height: 30,width: 30),
                    labelText: 'Card Number'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'dd/mm',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.black12),
                          icon: Image.asset('assets/icons/calendar_expiry_date.png',height: 30,width: 30),
                          labelText: 'Expire Date'.toUpperCase())),
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
                      style: const TextStyle(fontSize: 18),
                      obscureText: true,
                      obscuringCharacter: '*',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          icon: Image.asset('assets/icons/lock_unlocked.png',height: 30,width: 30),
                          labelText: 'CVV'.toUpperCase())),
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
