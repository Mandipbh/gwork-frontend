import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/custom_progress_bar.dart';
import 'package:g_worker_app/jobs/provider/get_professional_job_list_provider.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';
import '../common/common_input_fields.dart';
import '../common/common_widgets.dart';
import '../my_profile/my_profile_widgets/my_profile_screen.dart';
import '../my_profile/provider/my_profile_provider.dart';
import '../sign_up/provider/sign_up_provider.dart';
import 'job_detail_screen.dart';

class ProfessionalJobListScreen extends StatefulWidget {
  int role;

  ProfessionalJobListScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<ProfessionalJobListScreen> createState() =>
      _ProfessionalJobListScreenState();
}

class _ProfessionalJobListScreenState extends State<ProfessionalJobListScreen> {
  final ScrollController scrollController = ScrollController();
  var isPinned = false;
  bool isSelf = false;
  String selectedProvince = "All";
  String selectedState = JobsFilters.all;
  String selectedCategory = JobsType.all;

  getProfessionalJobs() {
    Provider.of<GetProfessionalJobListProvider>(context, listen: false)
        .getDataProfessional(
            jobState: isSelf ? 'All' : 'Published',
            state: !isSelf ? "All" : selectedState,
            isSelf: isSelf,
            province: selectedProvince,
            category: isSelf ? "All" : selectedCategory,
            context: context);
  }

  @override
  void initState() {
    super.initState();
    getProfessionalJobs();
    scrollController.addListener(() {
      if (!isPinned && scrollController.offset > 60) {
        setState(() {
          isPinned = true;
        });
      }
      if (isPinned && scrollController.offset < 60) {
        setState(() {
          isPinned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1F1C),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height + 10),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tr('Professional.logIn.Jobs.Jobs'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Visibility(
                      visible: isPinned,
                      child: Chip(
                        label: const Text(
                          "Filters(2)",
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Consumer<MyProfileProvider>(
                      builder: (context, myProfileProvider, child) {
                        return myProfileProvider.model == null
                            ? Container()
                            : myProfileProvider.getIsLoggingProfile()
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MyProfileScreen(),
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 42,
                                        width: 42,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: myProfileProvider.model != null
                                            ? myProfileProvider
                                                        .model!.user!.image !=
                                                    null
                                                ? Image.network(
                                                    myProfileProvider
                                                        .model!.user!.image!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "${(myProfileProvider.model!.user!.name![0])}${(myProfileProvider.model!.user!.surname![0])}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline3),
                                                  )
                                            : Center(
                                                child: Text(
                                                    "${(myProfileProvider.model!.user!.name![0])}${(myProfileProvider.model!.user!.surname![0])}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3),
                                              ),
                                      ),
                                    ),
                                  );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(child: appBarView()),
            ];
          },
          body: Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                top: isPinned ? AppBar().preferredSize.height - 40 : 0),
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
              child: Consumer<GetProfessionalJobListProvider>(
                builder: (context, value, child) => value.model == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : isSelf
                        ? myJobsView()
                        : searchJobsView(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() {
    return Container(
        color: const Color(0xff1B1F1C),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 24),
          !isSelf
              ? Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.end,
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: Text(
                        tr('client.type_picker.All'),
                      ),
                      labelStyle: TextStyle(
                        color: selectedCategory != JobsType.all
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedCategory == JobsType.all,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedCategory = JobsType.all;
                        });
                        getProfessionalJobs();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    FilterChip(
                      label: Text(
                        tr('client.type_picker.Cleaning'),
                      ),
                      labelStyle: TextStyle(
                        color: selectedCategory != JobsType.cleaning
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedCategory == JobsType.cleaning,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedCategory = JobsType.cleaning;
                        });
                        getProfessionalJobs();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    FilterChip(
                      label: Text(
                        tr('client.type_picker.baby_sitting'),
                      ),
                      labelStyle: TextStyle(
                        color: selectedCategory != JobsType.babySitting
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedCategory == JobsType.babySitting,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedCategory = JobsType.babySitting;
                        });
                        getProfessionalJobs();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    FilterChip(
                      label: Text(
                        tr('client.type_picker.Tutoring'),
                      ),
                      labelStyle: TextStyle(
                        color: selectedCategory != JobsType.tutoring
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedCategory == JobsType.tutoring,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedCategory = JobsType.tutoring;
                        });
                        getProfessionalJobs();
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
                        color: selectedCategory != JobsType.handyman
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedCategory == JobsType.handyman,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedCategory = JobsType.handyman;
                        });
                        getProfessionalJobs();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                )
              : Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.end,
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: Text(
                        tr('Professional.logIn.Jobs.All_Jobs'),
                      ),
                      labelStyle: TextStyle(
                        color: selectedState != JobsFilters.all
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.all,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.all;
                        });
                        getProfessionalJobs();
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
                        color: selectedState != JobsFilters.applied
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.applied,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.applied;
                        });
                        getProfessionalJobs();
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
                        color: selectedState != JobsFilters.accepted
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.accepted,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.accepted;
                        });
                        getProfessionalJobs();
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
                        color: selectedState != JobsFilters.doing
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.doing,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.doing;
                        });
                        getProfessionalJobs();
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
                        color: selectedState != JobsFilters.rejected
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.rejected,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.rejected;
                        });
                        getProfessionalJobs();
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
                        color: selectedState != JobsFilters.completed
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.completed,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.completed;
                        });
                        getProfessionalJobs();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    FilterChip(
                      label: Text(
                        "Expired",
                      ),
                      labelStyle: TextStyle(
                        color: selectedState != JobsFilters.expired
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: selectedState == JobsFilters.expired,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        setState(() {
                          selectedState = JobsFilters.expired;
                        });
                        getProfessionalJobs();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteF2F,
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: singleSelectionButtons(
                      context: context,
                      buttons: [
                        tr('Professional.logIn.Jobs.Search_Jobs'),
                        tr('Professional.logIn.Jobs.My_Jobs')
                      ],
                      padding: 8,
                      selected: !isSelf
                          ? SelectionType.searchJobs
                          : SelectionType.myJobs,
                      onSelectionChange: (value) {
                        log(value.toString());
                        setState(() {
                          isSelf = value == SelectionType.myJobs;
                        });
                        getProfessionalJobs();
                      }),
                ),
                const SizedBox(height: 12),
                isSelf
                    ? earningView()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Consumer<SignUpProvider>(
                          builder: (context, value, child) {
                            return value.proviceModel == null
                                ? Container()
                                : dropdownField(
                                    context,
                                    label: tr('client.Job_info.Province'),
                                    asset: 'marker_location.png',
                                    items: value.proviceModel!.provice,
                                    value: value.selectedProvince!,
                                    onChange: (val) {
                                      value.updateProvinceValue(val);
                                      setState(() {
                                        selectedProvince = val.toString();
                                      });
                                      getProfessionalJobs();
                                    },
                                  );
                          },
                        ),
                      ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ]));
  }

  Widget earningView() {
    int earning = context.read<GetProfessionalJobListProvider>().model != null
        ? int.parse(
            context.read<GetProfessionalJobListProvider>().model!.earning!)
        : 0;
    double progress = (earning / 5000) * 100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            tr('Professional.logIn.Jobs.earning_limit').toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomProgressBar(
              max: 100,
              current: progress,
              color: primaryColor,
              bgColor: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            '$earning€/5000€',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget myJobsView() {
    return Consumer<GetProfessionalJobListProvider>(
      builder: (context, value, child) {
        return value.getIsLogging()
            ? noMyJobsView()
            : value.model!.jobs!.isEmpty
                ? noMyJobsView()
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 4),
                    itemCount: value.model!.jobs!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobDetailsScreen(
                                          jobId: value.model!.jobs![index].id!,
                                        )),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${value.model!.jobs![index].category}'
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: black343,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.black,
                                                  size: 22),
                                              const SizedBox(width: 3),
                                              Text(
                                                '${value.model!.jobs![index].street},${value.model!.jobs![index].province},',
                                                style: TextStyle(
                                                  color: splashColor1,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${value.model!.jobs![index].description}, max ${value.model!.jobs![index].budget}\$',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: black343,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              statusChip(
                                                  value.model!.jobs![index]
                                                      .applicationState!,
                                                  context),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${value.model!.jobs![index].creationDate}',
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
                                              size: 12, color: yellowF4D),
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
                          // const SizedBox(height: 90)
                        ],
                      );

                      // return InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const JobDetailsScreen()),
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 12),
                      //     child: Container(
                      //       width: double.infinity,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(12),
                      //           color: Colors.white),
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(
                      //             left: 12, top: 12, bottom: 12, right: 16),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     Text(
                      //                       'Cleaning'.toUpperCase(),
                      //                       style: const TextStyle(
                      //                         color: black343,
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w700,
                      //                       ),
                      //                     ),
                      //                     const SizedBox(width: 8),
                      //                     const Icon(Icons.location_on_outlined,
                      //                         color: Colors.black, size: 22),
                      //                     const SizedBox(width: 3),
                      //                     const Text(
                      //                       'Via Zolo, 11, Milan',
                      //                       style: TextStyle(
                      //                         color: splashColor1,
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w400,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 const Text(
                      //                   '2 rooms, max 60\$',
                      //                   style: TextStyle(
                      //                     color: black343,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w700,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(height: 4),
                      //                 Row(
                      //                   children: [
                      //                     MaterialButton(
                      //                       onPressed: () {},
                      //                       height: 30,
                      //                       color: redE45,
                      //                       elevation: 0,
                      //                       shape: RoundedRectangleBorder(
                      //                           borderRadius:
                      //                               BorderRadius.circular(13)),
                      //                       child: const Text(
                      //                         'Rejected',
                      //                         style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 12,
                      //                           fontWeight: FontWeight.w700,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(width: 4),
                      //                     const Text(
                      //                       '06/07/2022 — 12:30',
                      //                       style: TextStyle(
                      //                         color: black343,
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w700,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: const [
                      //                 Icon(Icons.circle,
                      //                     size: 20, color: yellowF4D),
                      //                 SizedBox(width: 8),
                      //                 Icon(Icons.arrow_forward_ios,
                      //                     color: Colors.black, size: 20),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
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
            children: [
              Text(tr('Professional.logIn.Jobs.You_didn’t_took_any_job'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(tr('Professional.logIn.Jobs.Search_for_a_job'),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  Widget searchJobsView() {
    return Consumer<GetProfessionalJobListProvider>(
      builder: (context, value, child) {
        return value.model == null
            ? const Center(child: CircularProgressIndicator())
            : value.model!.jobs!.isEmpty
                ? noSearchJobsView()
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 4),
                    itemCount: value.model!.jobs!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobDetailsScreen(
                                      jobId: value.model!.jobs![index].id!,
                                    )),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 18.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, bottom: 12, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            value.model!.jobs![index].category
                                                .toString(),
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
                                          Text(
                                            '${value.model!.jobs![index].street.toString()},${value.model!.jobs![index].province.toString()}',
                                            style: const TextStyle(
                                              color: splashColor1,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${value.model!.jobs![index].description.toString()}, max ${value.model!.jobs![index].budget.toString()}\$',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: black343,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${value.model!.jobs![index].creationDate.toString()}',
                                        style: TextStyle(
                                          color: black343,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios,
                                    color: Colors.black, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
      },
    );
  }

  Widget noSearchJobsView() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Image.asset('assets/images/empty_job.png', height: 200),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      tr('Professional.logIn.Jobs.There_are_no_jobs_for_now'),
                      style: const TextStyle(
                        color: splashColor1,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr('Professional.logIn.Jobs.Check_it_bit_later_or_set_another_filters'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: black343,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
