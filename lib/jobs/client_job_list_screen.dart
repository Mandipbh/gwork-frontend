import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/add_new_job_screen.dart';
import 'package:g_worker_app/my_profile/my_profile_screen.dart';

import '../Constants.dart';
import '../common/common_buttons.dart';
import 'job_detail_screen.dart';

class ClientJobListScreen extends StatefulWidget {
  const ClientJobListScreen({Key? key}) : super(key: key);

  @override
  State<ClientJobListScreen> createState() => _ClientJobListScreenState();
}

class _ClientJobListScreenState extends State<ClientJobListScreen> {
  final ScrollController _sliverScrollController = ScrollController();
  int selectedFilter = 1;
  int selectedJobType = 1;
  var isPinned = false;

  void scrollListen(newState) {
    _sliverScrollController.addListener(() {
      if (!isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset == 300) {
        newState(() {
          isPinned = true;
        });
      } else if (isPinned &&
          _sliverScrollController.hasClients &&
          _sliverScrollController.offset == 0) {
        newState(() {
          isPinned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: NestedScrollView(
          controller: _sliverScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: primaryColor,
                centerTitle: false,
                flexibleSpace: appBarView(innerBoxIsScrolled),
                floating: true,
                pinned: true,
                expandedHeight: 300,
                snap: true,
              ),
            ];
          },
          body: Stack(
            children: [
              StatefulBuilder(builder: (context, newState) {
                scrollListen(newState);
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      top: isPinned ? AppBar().preferredSize.height + 20 : 0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: whiteF2F,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    child: myJobsView(),
                  ),
                );
              }),
              Positioned(
                bottom: 1,
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 25.0,
                    ),
                  ]),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Expanded(
                          child: submitButton(
                              context: context,
                              onButtonTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddNewJobScreen()),
                                );
                              },
                              backgroundColor: primaryColor,
                              buttonName: tr('client.type_picker.New_job'),
                              iconAsset: 'add.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView(bool innerBoxIsScrolled) {
    return FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //Text
        title: Text(innerBoxIsScrolled ? 'Jobs' : '',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .apply(color: Colors.white)),
        background: Container(
          color: const Color(0xff1B1F1C),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr('Professional.logIn.Jobs.Jobs'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyProfileScreen(),
                          ));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24,
                      child: Text("ST",
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.end,
                spacing: 16,
                children: [
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.All_Jobs'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedFilter != JobsFilters.all
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedFilter == JobsFilters.all,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = JobsFilters.all;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.Applied'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedFilter != JobsFilters.applied
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedFilter == JobsFilters.applied,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = JobsFilters.applied;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.Accepted'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedFilter != JobsFilters.accepted
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedFilter == JobsFilters.accepted,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = JobsFilters.accepted;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.Doing'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedFilter != JobsFilters.doing
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedFilter == JobsFilters.doing,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = JobsFilters.doing;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.Rejected'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedFilter != JobsFilters.rejected
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedFilter == JobsFilters.rejected,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = JobsFilters.rejected;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.Completed'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedFilter != JobsFilters.completed
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedFilter == JobsFilters.completed,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = JobsFilters.completed;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.end,
                spacing: 16,
                children: [
                  FilterChip(
                    label: Text(
                      tr('Professional.logIn.Jobs.All_types'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedJobType != JobsType.all
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedJobType == JobsType.all,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedJobType = JobsType.all;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('admin.dashboard.Cleaning'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedJobType != JobsType.cleaning
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedJobType == JobsType.cleaning,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedJobType = JobsType.cleaning;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('admin.job_detail.Babysitting'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedJobType != JobsType.babySitting
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedJobType == JobsType.babySitting,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedJobType = JobsType.babySitting;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('client.type_picker.Handyman'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedJobType != JobsType.handyman
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedJobType == JobsType.handyman,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedJobType = JobsType.handyman;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  FilterChip(
                    label: Text(
                      tr('admin.dashboard.tutoring'),
                    ),
                    labelStyle: TextStyle(
                      color: selectedJobType != JobsType.tutoring
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    selected: selectedJobType == JobsType.tutoring,
                    backgroundColor: black343,
                    selectedColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (bool value) {
                      setState(() {
                        selectedJobType = JobsType.tutoring;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) //Images.network
        );
    return Container(
      color: const Color(0xff1B1F1C),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Jobs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(Icons.person, color: Colors.grey, size: 25),
              )
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.end,
            spacing: 16,
            children: [
              FilterChip(
                label: const Text(
                  'All Jobs',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.all
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.all,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.all;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Applied',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.applied
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.applied,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.applied;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Accepted',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.accepted
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.accepted,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.accepted;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Doing',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.doing
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.doing,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.doing;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Rejected',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.rejected
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.rejected,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.rejected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Completed',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.completed
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.completed,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.completed;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 8),
          // Wrap(
          //   alignment: WrapAlignment.start,
          //   runAlignment: WrapAlignment.end,
          //   spacing: 16,
          //   children: [
          //     FilterChip(
          //       label: const Text(
          //         'All Type',
          //       ),
          //       labelStyle: TextStyle(
          //         color: selectedJobType != JobsType.all
          //             ? Colors.white
          //             : Colors.black,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //       selected: selectedJobType == JobsType.all,
          //       backgroundColor: black343,
          //       selectedColor: Colors.white,
          //       showCheckmark: false,
          //       onSelected: (bool value) {
          //         setState(() {
          //           selectedJobType = JobsType.all;
          //         });
          //       },
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     FilterChip(
          //       label: const Text(
          //         'Cleaning',
          //       ),
          //       labelStyle: TextStyle(
          //         color: selectedJobType != JobsType.cleaning
          //             ? Colors.white
          //             : Colors.black,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //       selected: selectedJobType == JobsType.cleaning,
          //       backgroundColor: black343,
          //       selectedColor: Colors.white,
          //       showCheckmark: false,
          //       onSelected: (bool value) {
          //         setState(() {
          //           selectedJobType = JobsType.cleaning;
          //         });
          //       },
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     FilterChip(
          //       label: const Text(
          //         'Babysitting',
          //       ),
          //       labelStyle: TextStyle(
          //         color: selectedJobType != JobsType.babySitting
          //             ? Colors.white
          //             : Colors.black,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //       selected: selectedJobType == JobsType.babySitting,
          //       backgroundColor: black343,
          //       selectedColor: Colors.white,
          //       showCheckmark: false,
          //       onSelected: (bool value) {
          //         setState(() {
          //           selectedJobType = JobsType.babySitting;
          //         });
          //       },
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     FilterChip(
          //       label: const Text(
          //         'Handyman',
          //       ),
          //       labelStyle: TextStyle(
          //         color: selectedJobType != JobsType.handyman
          //             ? Colors.white
          //             : Colors.black,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //       selected: selectedJobType == JobsType.handyman,
          //       backgroundColor: black343,
          //       selectedColor: Colors.white,
          //       showCheckmark: false,
          //       onSelected: (bool value) {
          //         setState(() {
          //           selectedJobType = JobsType.handyman;
          //         });
          //       },
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     FilterChip(
          //       label: const Text(
          //         'Tutoring',
          //       ),
          //       labelStyle: TextStyle(
          //         color: selectedJobType != JobsType.tutoring
          //             ? Colors.white
          //             : Colors.black,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //       selected: selectedJobType == JobsType.tutoring,
          //       backgroundColor: black343,
          //       selectedColor: Colors.white,
          //       showCheckmark: false,
          //       onSelected: (bool value) {
          //         setState(() {
          //           selectedJobType = JobsType.tutoring;
          //         });
          //       },
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget myJobsView() {
    return selectedFilter == JobsFilters.doing
        ? noMyJobsView()
        : ListView.builder(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
            itemCount: 6,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 5) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JobDetailsScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, bottom: 12, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Cleaning'.toUpperCase(),
                                          style: const TextStyle(
                                            color: black343,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.location_on_outlined,
                                            color: Colors.black, size: 22),
                                        const SizedBox(width: 3),
                                        const Text(
                                          'Via Zolo, 11, Milan',
                                          style: TextStyle(
                                            color: splashColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      '2 rooms, max 60\$',
                                      style: TextStyle(
                                        color: black343,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {},
                                          height: 30,
                                          color: redE45,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: const Text(
                                            'Rejected',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '06/07/2022 — 12:30',
                                          style: TextStyle(
                                            color: black343,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.circle,
                                        size: 18, color: yellowF4D),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 90)
                  ],
                );
              }
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JobDetailsScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, top: 12, bottom: 12, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Cleaning'.toUpperCase(),
                                    style: const TextStyle(
                                      color: black343,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.location_on_outlined,
                                      color: Colors.black, size: 22),
                                  const SizedBox(width: 3),
                                  const Text(
                                    'Via Zolo, 11, Milan',
                                    style: TextStyle(
                                      color: splashColor1,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                '2 rooms, max 60\$',
                                style: TextStyle(
                                  color: black343,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    height: 30,
                                    color: redE45,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: const Text(
                                      'Rejected',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '06/07/2022 — 12:30',
                                    style: TextStyle(
                                      color: black343,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.circle, size: 20, color: yellowF4D),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.black, size: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget noMyJobsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty_job.png',
          height: 180,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: const [
              Text("There is no jobs for you",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text("Please create one",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
