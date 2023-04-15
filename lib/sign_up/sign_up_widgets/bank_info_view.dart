import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_input_fields.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class BankInfoView extends StatelessWidget {
  const BankInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              tr('client.log_in.sign_up.bank_detail'),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(tr('client.log_in.sign_up.to_receive'),
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 30),
          nameTextField(
              controller:
                  Provider.of<SignUpProvider>(context).bankAccountController,
              maxLength: 25,
              context: context,
              label: tr('client.log_in.sign_up.bank'),
              asset: 'credit_card_shield.png'),
          const SizedBox(height: 15),
          Text(tr('client.log_in.sign_up.alpha_numeric'),
              style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }
}
