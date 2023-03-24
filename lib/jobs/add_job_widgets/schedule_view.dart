import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
import 'package:provider/provider.dart';

import '../../common/common_input_fields.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

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
                  tr('client.date_time.Schedule'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(tr('client.date_time.Choose_job'),
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      builder: (context, picker) {
                        return Theme(
                          //TODO: change colors
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
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(Duration(days: 355000)),
                      lastDate: DateTime.now());
                  value.dateController.text =
                      '${date!.day}/${date.month}/${date.year}';
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                      enabled: false,
                      controller: value.dateController,
                      style: const TextStyle(fontSize: 18),
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.black12),
                          icon: Image.asset('assets/icons/calendar.png',
                              height: 24, width: 24),
                          labelText:
                              tr('client.date_time.Date').toUpperCase())),
                ),
              ),
              const SizedBox(height: 20),
              timeTextField(
                  label: tr('client.date_time.Time'),
                  asset: 'clock.png',
                  context: context,
                  controller: value.timeController),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
