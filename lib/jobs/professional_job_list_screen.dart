import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/custom_progress_bar.dart';
import 'package:g_worker_app/invoice_view_screen/invoice_view_screen.dart';
import 'package:g_worker_app/jobs/provider/get_professional_job_list_provider.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';
import '../my_profile/my_profile_widgets/my_profile_screen.dart';
import '../my_profile/provider/my_profile_provider.dart';
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
  int selectedFilter = 1;
  int selectedJobType = 1;
  int selectedType = 1;
  var isPinned = false;

  getProfessionalJobs() {
    Provider.of<GetProfessionalJobListProvider>(context, listen: false)
        .getDataProfessional("Babysitting", "Avellino", false, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    getProfessionalJobs();
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
                        return myProfileProvider.getIsLoggingProfile()
                            ? const Center(child: CircularProgressIndicator())
                            : InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyProfileScreen(),
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
                                            : Text(
                                                "${(myProfileProvider.model!.user!.name![0])}${(myProfileProvider.model!.user!.surname![0])}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1)
                                        : Text(
                                            "${(myProfileProvider.model!.user!.name![0])}${(myProfileProvider.model!.user!.surname![0])}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1),
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
              child: selectedType == SelectionType.myJobs
                  ? myJobsView()
                  : searchJobsView(),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() {
    return Container(
        color: const Color(0xff1B1F1C),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.end,
            spacing: 8,
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
              FilterChip(
                label: Text(
                  "Expired",
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.expired
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.expired,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.expired;
                  });
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
                      selected: selectedType,
                      onSelectionChange: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      }),
                ),
                const SizedBox(height: 12),
                selectedType == SelectionType.myJobs
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              tr('Professional.logIn.Jobs.earning_limit')
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Expanded(
                              child: CustomProgressBar(
                                max: 5,
                                current: 2,
                                color: primaryColor,
                                bgColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              '2500€/5000€',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListTile(
                          horizontalTitleGap: 1,
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(Icons.location_on_outlined,
                                color: Colors.black, size: 28),
                          ),
                          title: Text(
                            tr('Professional.logIn.Jobs.PRovince')
                                .toUpperCase(),
                            style: const TextStyle(
                              color: black343,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: const Text(
                            'Milano',
                            style: TextStyle(
                              color: splashColor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_down,
                            color: splashColor1,
                          ),
                        ),
                      ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ]));
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
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const InvoiceViewScreen()),
                                                (Route<dynamic> route) => true);
                                          },
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
                                        size: 20, color: yellowF4D),
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
            : ListView.builder(
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 4),
                itemCount: value.model!.jobs!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // if (index == 5) {
                  //   return Column(
                  //     children: [
                  //       Container(
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //             color: Colors.white),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 12, top: 12, bottom: 12, right: 16),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Text(
                  //                         'Babysitting'.toUpperCase(),
                  //                         style: const TextStyle(
                  //                           color: black343,
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.w700,
                  //                         ),
                  //                       ),
                  //                       const SizedBox(width: 8),
                  //                       const Icon(Icons.location_on_outlined,
                  //                           color: Colors.black, size: 22),
                  //                       const SizedBox(width: 3),
                  //                       const Text(
                  //                         'Help me with my child',
                  //                         style: TextStyle(
                  //                           color: splashColor1,
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.w400,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   const Text(
                  //                     '2 rooms, max 60\$',
                  //                     style: TextStyle(
                  //                       color: black343,
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.w700,
                  //                     ),
                  //                   ),
                  //                   const SizedBox(height: 4),
                  //                   const Text(
                  //                     '06/07/2022 — 12:30',
                  //                     style: TextStyle(
                  //                       color: black343,
                  //                       fontSize: 12,
                  //                       fontWeight: FontWeight.w700,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const Icon(Icons.arrow_forward_ios,
                  //                   color: Colors.black, size: 20),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(height: 90)
                  //     ],
                  //   );
                  // }
                  return Container(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '${value.model!.jobs![index].street.toString()},${value.model!.jobs![index].province.toString()}}',
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
                          const Icon(Icons.arrow_forward_ios,
                              color: Colors.black, size: 20),
                        ],
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
