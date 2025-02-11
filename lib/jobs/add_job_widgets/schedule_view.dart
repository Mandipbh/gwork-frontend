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
              'Schedule',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Text('Choose when do you want your job to be done.',
              style: Theme.of(context).textTheme.bodyMedium),
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
                    icon: Image.asset('assets/icons/calendar.png',height: 30,width: 30),
                    labelText: 'Birth date'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          nameTextField(label: 'Time', asset: 'clock.png'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
