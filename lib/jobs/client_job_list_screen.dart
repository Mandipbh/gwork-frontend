import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/add_new_job_screen.dart';
import 'package:g_worker_app/jobs/job_details_screen_client.dart';
import 'package:g_worker_app/jobs/provider/get_client_job_list_provider.dart';
import 'package:g_worker_app/my_profile/my_profile_widgets/my_profile_screen.dart';
import 'package:g_worker_app/my_profile/provider/my_profile_provider.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../common/common_buttons.dart';
import '../common/common_widgets.dart';

class ClientJobListScreen extends StatefulWidget {
  const ClientJobListScreen({Key? key}) : super(key: key);

  @override
  State<ClientJobListScreen> createState() => _ClientJobListScreenState();
}

class _ClientJobListScreenState extends State<ClientJobListScreen> {
  final ScrollController scrollController = ScrollController();
  var isPinned = false;

  getClientJobs() {
    var provider =
        Provider.of<GetClientJobListProvider>(context, listen: false);
    provider.getClientJobList(
        provider.getSelectedFilter(), provider.getSelectedJobType(), context);
  }

  @override
  void initState() {
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
    getClientJobs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<GetClientJobListProvider>(
      builder: (context, clientJobProvider, child) {
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
                        tr('client.jobs'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Visibility(
                        visible: isPinned,
                        child: Chip(
                          label: Text(
                            tr('client.filter'),
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
                                                  const MyProfileScreen(),
                                            )).then((value) => setState(() {}));
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
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return const CircleAvatar(
                                                            radius: 75,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 22,
                                                                color: grey9EA,
                                                              ),
                                                            ));
                                                      },
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
                SliverToBoxAdapter(child: appBarView(clientJobProvider)),
              ];
            },
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
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
                    child: myJobsView(clientJobProvider),
                  ),
                ),
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
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
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
        );
      },
    ));
  }

  Widget appBarView(GetClientJobListProvider clientJobProvider) {
    return Container(
      color: const Color(0xff1B1F1C),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.end,
            spacing: 16,
            children: [
              FilterChip(
                label: Text(
                  tr('client.job_status.all'),
                ),
                labelStyle: TextStyle(
                  color:
                      clientJobProvider.getSelectedFilter() != JobsFilters.all
                          ? Colors.white
                          : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected:
                    clientJobProvider.getSelectedFilter() == JobsFilters.all,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.all);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.published'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedFilter() !=
                          JobsFilters.published
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedFilter() ==
                    JobsFilters.published,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.published);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.doing'),
                ),
                labelStyle: TextStyle(
                  color:
                      clientJobProvider.getSelectedFilter() != JobsFilters.doing
                          ? Colors.white
                          : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected:
                    clientJobProvider.getSelectedFilter() == JobsFilters.doing,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.doing);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.pending'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedFilter() !=
                          JobsFilters.pending
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedFilter() ==
                    JobsFilters.pending,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.pending);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.rejected'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedFilter() !=
                          JobsFilters.rejected
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedFilter() ==
                    JobsFilters.rejected,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.rejected);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.accepted'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedFilter() !=
                          JobsFilters.accepted
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedFilter() ==
                    JobsFilters.accepted,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.accepted);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.completed'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedFilter() !=
                          JobsFilters.completed
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedFilter() ==
                    JobsFilters.completed,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.completed);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_status.reported'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedFilter() !=
                          JobsFilters.reported
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedFilter() ==
                    JobsFilters.reported,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedFilter(JobsFilters.reported);
                  getClientJobs();
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
                  tr('client.job_category.all'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedJobType() != JobsType.all
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected:
                    clientJobProvider.getSelectedJobType() == JobsType.all,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedJobType(JobsType.all);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_category.cleaning'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedJobType() !=
                          JobsType.cleaning
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected:
                    clientJobProvider.getSelectedJobType() == JobsType.cleaning,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedJobType(JobsType.cleaning);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_category.babysitting'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedJobType() !=
                          JobsType.babySitting
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: clientJobProvider.getSelectedJobType() ==
                    JobsType.babySitting,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedJobType(JobsType.babySitting);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_category.handyman'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedJobType() !=
                          JobsType.handyman
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected:
                    clientJobProvider.getSelectedJobType() == JobsType.handyman,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedJobType(JobsType.handyman);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: Text(
                  tr('client.job_category.tutoring'),
                ),
                labelStyle: TextStyle(
                  color: clientJobProvider.getSelectedJobType() !=
                          JobsType.tutoring
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected:
                    clientJobProvider.getSelectedJobType() == JobsType.tutoring,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  clientJobProvider.setSelectedJobType(JobsType.tutoring);
                  getClientJobs();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ],
      ),
    ); //Images.network
  }

  Widget myJobsView(GetClientJobListProvider clientJobProvider) {
    return RefreshIndicator(
      onRefresh: () async {
        getClientJobs();
      },
      child: clientJobProvider.getIsListLoading()
          ? const Center(child: CircularProgressIndicator())
          : clientJobProvider.model!.jobs.isEmpty
              ? noMyJobsView()
              : ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 100),
                  itemCount: clientJobProvider.model!.jobs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobDetailsClientScreen(
                                    jobId:
                                        clientJobProvider.model!.jobs[index].id,
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
                                            tr('client.job_category.${clientJobProvider.model!.jobs[index].category.toLowerCase()}')
                                                .toUpperCase(),
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
                                          Flexible(
                                            child: Text(
                                              '${clientJobProvider.model!.jobs[index].street}, ${clientJobProvider.model!.jobs[index].province}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: splashColor1,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        clientJobProvider
                                            .model!.jobs[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: black343,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          statusChip(
                                              clientJobProvider
                                                  .model!.jobs[index].state,
                                              context),
                                          const SizedBox(width: 4),
                                          Text(
                                            clientJobProvider
                                                .model!.jobs[index].jobDate,
                                            style: const TextStyle(
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
                    );
                  },
                ),
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
