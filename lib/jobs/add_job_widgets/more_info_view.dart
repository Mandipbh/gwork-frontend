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
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'More info',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text('The following fields are optional.',
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 24),
          multilineTextField(
              label: 'Describe the job', asset: 'message_text.png'),
          const SizedBox(height: 20),
          nameTextField(label: 'Budget', asset: 'coins_stacked.png'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
