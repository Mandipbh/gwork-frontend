import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_input_fields.dart';

class SetPasswordView extends StatelessWidget {
  const SetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              tr('admin.set_password'),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(tr('admin.choose_password'),
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 40),
          passwordTextField(
              label: tr('admin.new_password'),
              controller: TextEditingController()),
          const SizedBox(height: 20),
          passwordTextField(
              label: tr('admin.confirm_new_password'),
              controller: TextEditingController()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
