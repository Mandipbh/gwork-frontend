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
import 'job_detail_screen_professional.dart';

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

  getProfessionalJobs() {
    var provider =
        Provider.of<GetProfessionalJobListProvider>(context, listen: false);
    provider.getProfessionalJobList(
        jobState: provider.getIsSelf() ? 'All' : 'Published',
        state: !provider.getIsSelf() ? "All" : provider.getSelectedState(),
        isSelf: provider.getIsSelf(),
        province: provider.getSelectedProvince(),
        category: provider.getIsSelf() ? "All" : provider.getSelectedCategory(),
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
      child: Consumer<GetProfessionalJobListProvider>(
          builder: (context, provider, child) {
        return Scaffold(
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
                              : myProfileProvider.getIsLoadingProfile()
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
                                                          style:
                                                              Theme.of(context)
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
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: appBarView(provider)),
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
                      : provider.getIsSelf()
                          ? myJobsView(provider)
                          : searchJobsView(provider),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget appBarView(GetProfessionalJobListProvider provider) {
    return Container(
        color: const Color(0xff1B1F1C),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 24),
          !provider.getIsSelf()
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
                        color: provider.getSelectedCategory() != JobsType.all
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: provider.getSelectedCategory() == JobsType.all,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedCategory(JobsType.all);
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
                        color:
                            provider.getSelectedCategory() != JobsType.cleaning
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedCategory() == JobsType.cleaning,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedCategory(JobsType.cleaning);
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
                        color: provider.getSelectedCategory() !=
                                JobsType.babySitting
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: provider.getSelectedCategory() ==
                          JobsType.babySitting,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedCategory(JobsType.babySitting);
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
                        color:
                            provider.getSelectedCategory() != JobsType.tutoring
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedCategory() == JobsType.tutoring,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedCategory(JobsType.tutoring);
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
                        color:
                            provider.getSelectedCategory() != JobsType.handyman
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedCategory() == JobsType.handyman,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedCategory(JobsType.handyman);
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
                        color: provider.getSelectedState() != JobsFilters.all
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected: provider.getSelectedState() == JobsFilters.all,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.all);
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
                        color:
                            provider.getSelectedState() != JobsFilters.applied
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedState() == JobsFilters.applied,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.applied);
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
                        color:
                            provider.getSelectedState() != JobsFilters.accepted
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedState() == JobsFilters.accepted,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.accepted);
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
                        color: provider.getSelectedState() != JobsFilters.doing
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedState() == JobsFilters.doing,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.doing);
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
                        color:
                            provider.getSelectedState() != JobsFilters.rejected
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedState() == JobsFilters.rejected,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.rejected);
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
                        color:
                            provider.getSelectedState() != JobsFilters.completed
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedState() == JobsFilters.completed,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.completed);
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
                        color:
                            provider.getSelectedState() != JobsFilters.expired
                                ? Colors.white
                                : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selected:
                          provider.getSelectedState() == JobsFilters.expired,
                      backgroundColor: black343,
                      selectedColor: Colors.white,
                      showCheckmark: false,
                      onSelected: (bool value) {
                        provider.setSelectedState(JobsFilters.expired);
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
                      selected: !provider.getIsSelf()
                          ? SelectionType.searchJobs
                          : SelectionType.myJobs,
                      onSelectionChange: (value) {
                        provider.setIsSelf(value == SelectionType.myJobs);
                        getProfessionalJobs();
                      }),
                ),
                const SizedBox(height: 12),
                provider.getIsSelf()
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
                                    value: provider.getSelectedProvince(),
                                    onChange: (val) {
                                      value.updateProvinceValue(val);
                                      provider
                                          .setSelectedProvince(val.toString());
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

  Widget myJobsView(GetProfessionalJobListProvider provider) {
    return provider.getIsListLoading()
        ? noMyJobsView()
        : provider.model!.jobs!.isEmpty
            ? noMyJobsView()
            : ListView.builder(
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 4),
                itemCount: provider.model!.jobs!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JobDetailsScreenProfessional(
                                      jobId: provider.model!.jobs![index].id!,
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${provider.model!.jobs![index].category}'
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
                                              '${provider.model!.jobs![index].street},${provider.model!.jobs![index].province},',
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
                                          '${provider.model!.jobs![index].description}, max ${provider.model!.jobs![index].budget}\$',
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
                                                provider.model!.jobs![index]
                                                    .applicationState!,
                                                context),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${provider.model!.jobs![index].creationDate}',
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

  Widget searchJobsView(GetProfessionalJobListProvider provider) {
    return provider.model == null
        ? const Center(child: CircularProgressIndicator())
        : provider.model!.jobs!.isEmpty
            ? noSearchJobsView()
            : ListView.builder(
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 4),
                itemCount: provider.model!.jobs!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobDetailsScreenProfessional(
                                  jobId: provider.model!.jobs![index].id!,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        provider.model!.jobs![index].category
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
                                        '${provider.model!.jobs![index].street.toString()},${provider.model!.jobs![index].province.toString()}',
                                        style: const TextStyle(
                                          color: splashColor1,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${provider.model!.jobs![index].description.toString()}, max ${provider.model!.jobs![index].budget.toString()}\$',
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
                                    '${provider.model!.jobs![index].creationDate.toString()}',
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
