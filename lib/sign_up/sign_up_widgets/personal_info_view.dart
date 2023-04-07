import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_input_fields.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

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
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(tr('client.log_in.sign_up.Please_fill_all_the_fields'),
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 24),
          nameTextField(
              controller: Provider.of<SignUpProvider>(context, listen: false)
                  .nameController,
              label: tr('client.log_in.sign_up.Name'),
              asset: 'user_first_name.png'),
          const SizedBox(height: 20),
          nameTextField(
              controller: Provider.of<SignUpProvider>(context, listen: false)
                  .lastNameController,
              label: tr('client.log_in.sign_up.Last_name'),
              asset: 'user.png'),
          const SizedBox(height: 20),
          nameTextField(
              controller: Provider.of<SignUpProvider>(context, listen: false)
                  .emailController,
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
                maxLength: 16,
                controller: Provider.of<SignUpProvider>(context, listen: false)
                    .textCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Image.asset('assets/icons/hash.png',
                        height: 24, width: 24),
                    counterText: "",
                    labelText:
                        tr('client.log_in.sign_up.Tax_Code').toUpperCase())),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              DateTime? date = await showDatePicker(
                builder: (context, picker) {
                  return Theme(
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
                context: context,
                initialDate: DateTime.now().subtract(
                  Duration(days: 6570),
                ),
                firstDate: DateTime.now().subtract(
                  Duration(days: 355000),
                ),
                lastDate: DateTime.now().subtract(
                  Duration(days: 6570),
                ),
              );
              // ignore: use_build_context_synchronously

              Provider.of<SignUpProvider>(context, listen: false)
                  .birthDateController
                  .text = '${date!.day}/${date.month}/${date.year}';
            },
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextField(
                  enabled: false,
                  controller:
                      Provider.of<SignUpProvider>(context, listen: false)
                          .birthDateController,
                  style: const TextStyle(fontSize: 18),
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'dd/mm/yyyy',
                      hintStyle:
                          const TextStyle(fontSize: 18, color: Colors.black12),
                      icon: Image.asset('assets/icons/calendar_birthday.png',
                          height: 24, width: 24),
                      labelText: tr('client.log_in.sign_up.Birth_date')
                          .toUpperCase())),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
