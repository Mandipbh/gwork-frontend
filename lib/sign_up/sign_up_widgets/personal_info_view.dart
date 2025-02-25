import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_input_fields.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              tr('client.log_in.sign_up.Personal_info'),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Text(tr('client.log_in.sign_up.Please_fill_all_the_fields'),
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          nameTextField(
              label: tr('client.log_in.sign_up.Name'),
              asset: 'user_first_name.png'),
          const SizedBox(height: 20),
          nameTextField(
              label: tr('client.log_in.sign_up.Last_name'), asset: 'user.png'),
          const SizedBox(height: 20),
          nameTextField(
              label: tr('client.log_in.sign_up.Email_id'),
              asset: 'mail.png',
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
                    icon: Image.asset('assets/icons/hash.png',
                        height: 24, width: 24),
                    labelText:
                        tr('client.log_in.sign_up.Text_Code').toUpperCase())),
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
                decoration: InputDecoration(
                    hintText: 'dd/mm/yyyy',
                    hintStyle:
                        const TextStyle(fontSize: 18, color: Colors.black12),
                    icon: Image.asset('assets/icons/calendar_birthday.png',
                        height: 24, width: 24),
                    labelText:
                        tr('client.log_in.sign_up.Birth_date').toUpperCase())),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
