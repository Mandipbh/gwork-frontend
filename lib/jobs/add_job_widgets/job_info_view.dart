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
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Job info',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
            ),
          ),
          Text('Please fill all the fields',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2),
          const SizedBox(height: 40),
          nameTextField(
              label: 'title', asset: 'assets/icons/ic_title.png'),
          const SizedBox(height: 20),
          nameTextField(label: 'street', asset: 'assets/icons/ic_location.png'),
          const SizedBox(height: 20),
          dropdownField(
              label: 'Province',
              asset: 'assets/icons/ic_location.png',items: ['Province']),
          const SizedBox(height: 20),
          dropdownField(label: 'Comune',
            items: ['Comune'],
            asset: 'assets/icons/ic_location.png',),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
