import 'package:flutter/material.dart';

import '../../common/common_input_fields.dart';

class MoreInfoView extends StatelessWidget {
  const MoreInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Personal info',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text('Please fill all the fields',
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 40),
          nameTextField(
              label: 'name', asset: 'assets/icons/ic_user_firstname.png'),
          const SizedBox(height: 20),
          nameTextField(label: 'last name', asset: 'assets/icons/ic_user.png'),
          const SizedBox(height: 20),
          nameTextField(
              label: 'email',
              asset: 'assets/icons/ic_email.png',
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    icon: Image.asset('assets/icons/ic_hash.png'),
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
                    hintText: 'dd/mm/yyyy',
                    hintStyle:
                        const TextStyle(fontSize: 18, color: Colors.black12),
                    icon: Image.asset('assets/icons/ic_calender_heart.png'),
                    labelText: 'Birth date'.toUpperCase())),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
