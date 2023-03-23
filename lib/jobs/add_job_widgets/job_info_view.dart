import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

import '../../common/common_input_fields.dart';

class JobInfoView extends StatelessWidget {
  const JobInfoView({super.key});

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
                  tr('client.Job_info.Job_info'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(tr('client.Job_info.fill_the_fields'),
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 24),
              nameTextField(
                  label: tr('client.Job_info.Title'),
                  asset: 'text_input.png',
                  controller: value.titleController),
              const SizedBox(height: 20),
              nameTextField(
                  label: tr('client.Job_info.Enter_street'),
                  asset: 'marker_location.png',
                  controller: value.streetController),
              const SizedBox(height: 20),
              Consumer<SignUpProvider>(
                builder: (context, value, child) {
                  return dropdownField(
                    context,
                    label: tr('client.Job_info.Province'),
                    asset: 'marker_location.png',
                    items: value.proviceModel!.provice,
                    value: value.selectedProvince!,
                    onChange: (val) {
                      value.updateProvinceValue(val);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              nameTextField(
                label: tr('client.Job_info.Comune'),
                controller: value.comuneController,
                asset: 'marker_location.png',
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
