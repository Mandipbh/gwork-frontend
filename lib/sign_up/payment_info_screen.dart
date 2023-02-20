import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentInfoScreen extends StatelessWidget {
  const PaymentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Payment Method',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Text('Add payment method for your account',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.person_outline_outlined),
                    labelText: 'Card Holder'.toUpperCase())),
          ),
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
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.credit_card),
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          icon: const Icon(Icons.calendar_today_outlined),
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
                          icon: const Icon(Icons.lock_open_outlined),
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
