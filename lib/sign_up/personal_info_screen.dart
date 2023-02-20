import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Personal info',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Text('Please fill all the fields',
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
                    labelText: 'Name'.toUpperCase())),
          ),
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
                    labelText: 'Last Name'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.email_outlined),
                    labelText: 'Email'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.numbers_outlined),
                    labelText: 'VAT Number'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'dd/mm/yyyy',
                    hintStyle:
                    const TextStyle(fontSize: 18, color: Colors.black12),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.calendar_month_outlined),
                    labelText: 'Birth date'.toUpperCase())),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
