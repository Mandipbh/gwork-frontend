import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';

import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
import 'package:provider/provider.dart';

class JobReasonView extends StatefulWidget {
  const JobReasonView({super.key});

  @override
  State<JobReasonView> createState() => _JobReasonViewState();
}

class _JobReasonViewState extends State<JobReasonView> {
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateClientJobProvider>(
      builder: (context, createClientJobProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  tr('client.type_picker.need'),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(tr('client.type_picker.select_options'),
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 24),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.44,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          createClientJobProvider
                              .setCategory(JobsType.cleaning);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: createClientJobProvider.category ==
                                          JobsType.cleaning
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  tr('client.type_picker.Cleaning'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                          color: createClientJobProvider
                                                      .category ==
                                                  JobsType.cleaning
                                              ? Colors.white
                                              : primaryColor),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      createClientJobProvider.category ==
                                              JobsType.cleaning
                                          ? const Color(0xff343734)
                                          : const Color(0xfff2f2f2),
                                  child: Image.asset(
                                      'assets/icons/cleaning.png',
                                      height: 30,
                                      width: 30,
                                      color: createClientJobProvider.category ==
                                              JobsType.cleaning
                                          ? Colors.white
                                          : primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          createClientJobProvider
                              .setCategory(JobsType.babySitting);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: createClientJobProvider.category ==
                                          JobsType.babySitting
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(tr('client.chat.Babysitting'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .apply(
                                            color: createClientJobProvider
                                                        .category ==
                                                    JobsType.babySitting
                                                ? Colors.white
                                                : primaryColor)),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      createClientJobProvider.category ==
                                              JobsType.babySitting
                                          ? const Color(0xff343734)
                                          : const Color(0xfff2f2f2),
                                  child: Image.asset(
                                      'assets/icons/babysitting.png',
                                      height: 30,
                                      width: 30,
                                      color: createClientJobProvider.category ==
                                              JobsType.babySitting
                                          ? Colors.white
                                          : primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          createClientJobProvider
                              .setCategory(JobsType.tutoring);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: createClientJobProvider.category ==
                                          JobsType.tutoring
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  tr('client.type_picker.Tutoring'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                          color: createClientJobProvider
                                                      .category ==
                                                  JobsType.tutoring
                                              ? Colors.white
                                              : primaryColor),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      createClientJobProvider.category ==
                                              JobsType.tutoring
                                          ? const Color(0xff343734)
                                          : const Color(0xfff2f2f2),
                                  child: Image.asset('assets/icons/tutor.png',
                                      height: 30,
                                      width: 30,
                                      color: createClientJobProvider.category ==
                                              JobsType.tutoring
                                          ? Colors.white
                                          : primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          createClientJobProvider
                              .setCategory(JobsType.handyman);
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: createClientJobProvider.category ==
                                          JobsType.handyman
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(tr('client.type_picker.Handyman'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .apply(
                                            color: createClientJobProvider
                                                        .category ==
                                                    JobsType.handyman
                                                ? Colors.white
                                                : primaryColor)),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      createClientJobProvider.category ==
                                              JobsType.handyman
                                          ? const Color(0xff343734)
                                          : const Color(0xfff2f2f2),
                                  child: Image.asset(
                                      'assets/icons/handyman.png',
                                      height: 30,
                                      width: 30,
                                      color: createClientJobProvider.category ==
                                              JobsType.handyman
                                          ? Colors.white
                                          : primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
