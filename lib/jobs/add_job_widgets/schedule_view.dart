import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../common/common_input_fields.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              tr('client.date_time.Schedule'),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(tr('client.date_time.Choose_job'),
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 24),
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
                    icon: Image.asset('assets/icons/calendar.png',
                        height: 30, width: 30),
                    labelText: tr('client.date_time.Date').toUpperCase())),
          ),
          const SizedBox(height: 20),
          nameTextField(label: tr('client.date_time.Time'), asset: 'clock.png'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
