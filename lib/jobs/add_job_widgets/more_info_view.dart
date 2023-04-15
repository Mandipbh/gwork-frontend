import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
import 'package:provider/provider.dart';

import '../../common/common_input_fields.dart';

class MoreInfoView extends StatelessWidget {
  const MoreInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<CreateClientJobProvider>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  tr('client.case_descrive.More_info'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(tr('client.case_descrive.following_fields'),
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 24),
              multilineTextField(
                  label: tr('client.case_descrive.Describe_job'),
                  asset: 'message_text.png',
                  controller: value.describeController),
              const SizedBox(height: 20),
              budgetTextField(
                  label: tr('client.case_descrive.Budget'),
                  asset: 'coins_stacked.png',
                  context: context,
                  controller: value.budgetController),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
