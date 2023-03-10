import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../common/common_input_fields.dart';

class JobInfoView extends StatelessWidget {
  const JobInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              label: tr('client.Job_info.Title'), asset: 'text_input.png'),
          const SizedBox(height: 20),
          nameTextField(
              label: tr('client.Job_info.Enter_street'),
              asset: 'marker_location.png'),
          const SizedBox(height: 20),
          dropdownField(
              label: tr('client.Job_info.Province'),
              asset: 'marker_location.png',
              items: ['Province']),
          const SizedBox(height: 20),
          dropdownField(
            label: tr('client.Job_info.Comune'),
            items: ['Comune'],
            asset: 'marker_location.png',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
