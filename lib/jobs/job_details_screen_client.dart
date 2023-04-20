import 'dart:developer';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/chat/chat_widget_view/chat_screen.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_widgets.dart';
import 'package:g_worker_app/jobs/model/get_job_details_client_model.dart';
import 'package:g_worker_app/jobs/provider/get_client_job_list_provider.dart';
import 'package:g_worker_app/jobs/provider/get_professional_job_list_provider.dart';

import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';
import '../common/common_buttons.dart';

class JobDetailsClientScreen extends StatefulWidget {
  const JobDetailsClientScreen({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  final String? jobId;

  @override
  State<JobDetailsClientScreen> createState() => _JobDetailsClientScreenState();
}

class _JobDetailsClientScreenState extends State<JobDetailsClientScreen> {
  int selectedType = 1;

  NumberFormat format = NumberFormat('#.00');

  getJobDetails() {
    Provider.of<GetClientJobListProvider>(context, listen: false)
        .getDetailsClient(context, widget.jobId);
    Provider.of<GetProfessionalJobListProvider>(context, listen: false)
        .getGallery(context, widget.jobId);
    Provider.of<GetClientJobListProvider>(context, listen: false)
        .getApplicantsForClient(context, widget.jobId);
  }

  @override
  void initState() {
    super.initState();
    getJobDetails();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetClientJobListProvider, GetProfessionalJobListProvider>(
        builder: (context, jobProvider, getProfessionalJobListProvider, child) {
      return WillPopScope(
        onWillPop: () async {
          getProfessionalJobListProvider.clearDataModel();
          jobProvider.clearDataModel(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: whiteF2F,
          body: jobProvider.getIsOverviewLoading()
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 70),
                          appBarView(jobProvider.detailsModel!.jobDetails!),
                          statusView(
                              jobProvider.detailsModel!.jobDetails!.state!),
                          const SizedBox(height: 12),
                          textView(jobProvider),
                          const SizedBox(height: 12),
                          tabViewClient(
                              jobProvider.detailsModel!.jobDetails!.state!,
                              jobProvider.detailsModel!.jobDetails!
                                      .applicationCount ??
                                  0),
                          const SizedBox(height: 12),
                          selectedType == 1
                              ? Expanded(
                                  child: SingleChildScrollView(
                                    child: description(jobProvider),
                                  ),
                                )
                              : selectedType == 2
                                  ? Expanded(
                                      child: galleryView(
                                          getProfessionalJobListProvider),
                                    )
                                  : Expanded(
                                      child: applicationWidgetView(),
                                    ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      left: 1,
                      right: 1,
                      child: jobProvider.detailsModel!.jobDetails!.state! ==
                              JobStatus.completed
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              width: MediaQuery.of(context).size.width - 20,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              child: submitButton(
                                onButtonTap: () {},
                                context: context,
                                backgroundColor: primaryColor,
                                buttonName: tr('admin.job_detail.View_invoice'),
                                iconAsset: 'file.png',
                              ),
                            )
                          : jobProvider.detailsModel!.jobDetails!.state! ==
                                  JobStatus.pending
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  width: MediaQuery.of(context).size.width - 20,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: submitButton(
                                          onButtonTap: () {
                                            showJobRejectConfirmation(
                                                context,
                                                jobProvider.detailsModel!
                                                    .jobDetails!.id!);
                                          },
                                          context: context,
                                          backgroundColor: redE45,
                                          buttonName: tr(
                                              'client.reject_job.Reject_job'),
                                          iconAsset: 'close_square.png',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: submitButton(
                                          onButtonTap: () {
                                            showJobApproveConfirmation(
                                                context,
                                                jobProvider.detailsModel!
                                                    .jobDetails!.id!);
                                          },
                                          context: context,
                                          backgroundColor: primaryColor,
                                          buttonName: tr(
                                              'client.Accept_job.accept_job'),
                                          iconAsset: 'check_circle.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                    )
                  ],
                ),
        ),
      );
    });
  }

  Widget description(GetClientJobListProvider jobProvider) {
    return Column(
      children: [
        jobDetailView("assets/icons/marker_location.png",
            "${jobProvider.detailsModel!.jobDetails!.street!}, ${jobProvider.detailsModel!.jobDetails!.province!}"),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 12),
          child: Row(
            children: [
              jobProvider.detailsModel!.jobDetails!.state! ==
                      JobStatus.published
                  ? Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          horizontalTitleGap: 1,
                          leading: Image.asset('assets/icons/file.png',
                              color: primaryColor, height: 24, width: 24),
                          title: Text(
                            tr('admin.job_detail.created_at'),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(jobProvider
                              .detailsModel!.jobDetails!.creationDate!),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          horizontalTitleGap: 1,
                          title: Text(
                            tr('admin.job_detail.created_at'),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(jobProvider
                              .detailsModel!.jobDetails!.creationDate!),
                        ),
                      ),
                    ),
              const SizedBox(width: 8),
              jobProvider.detailsModel!.jobDetails!.state! ==
                      JobStatus.published
                  ? Container()
                  : Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          horizontalTitleGap: 1,
                          title: Text(
                            tr('admin.job_detail.accepted_at'),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(jobProvider
                              .detailsModel!.jobDetails!.applicationAccepted!),
                        ),
                      ),
                    )
            ],
          ),
        ),
        const SizedBox(height: 12),
        jobProvider.detailsModel!.jobDetails!.state != JobStatus.published
            ? Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ListTile(
                    horizontalTitleGap: 10,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      radius: 20,
                      child: jobProvider.detailsModel!.jobDetails!
                                  .professionalImage !=
                              null
                          ? Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  60.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  60.0,
                                ),
                                child: Image.network(
                                  jobProvider.detailsModel!.jobDetails!
                                      .professionalImage!,
                                  fit: BoxFit.fitWidth,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
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
                                  errorBuilder: (context, error, stackTrace) {
                                    return const CircleAvatar(
                                        radius: 75,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 22,
                                            color: grey9EA,
                                          ),
                                        ));
                                  },
                                ),
                              ),
                            )
                          : Text(
                              "${jobProvider.detailsModel!.jobDetails!.professionalName!.split(' ')[0][0]}${jobProvider.detailsModel!.jobDetails!.professionalName!.split(' ')[1][0]}",
                              style: const TextStyle(color: black343),
                            ),
                    ),
                    title: Text(
                      jobProvider.detailsModel!.jobDetails!.professionalName!,
                      style: const TextStyle(
                        color: black343,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      tr('admin.dashboard.Professional'),
                      style: const TextStyle(
                        color: grey807,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                jobId:
                                    jobProvider.detailsModel!.jobDetails!.id!,
                                userId: jobProvider
                                    .detailsModel!.jobDetails!.professionalId!,
                                userName: jobProvider.detailsModel!.jobDetails!
                                        .professionalName ??
                                    '',
                                userImage: jobProvider.detailsModel!.jobDetails!
                                        .professionalImage ??
                                    '',
                                jobCategory: jobProvider
                                    .detailsModel!.jobDetails!.category!,
                                state: jobProvider
                                    .detailsModel!.jobDetails!.state!,
                                acceptedBudget: jobProvider
                                    .detailsModel!.jobDetails!.acceptedBudget!,
                                description: jobProvider
                                    .detailsModel!.jobDetails!.description,
                              ),
                            ),
                            (Route<dynamic> route) => true);
                        getJobDetails();
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            "assets/icons/message_chat.png",
                            height: 30,
                            width: 45,
                          ),
                          Positioned(
                            top: 3,
                            right: -2,
                            child: Container(
                              height: 18,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: yellowF4D,
                              ),
                              child: Center(
                                child: Text(
                                  "${jobProvider.detailsModel!.jobDetails!.chatCount!}",
                                  style: const TextStyle(
                                    color: splashColor1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            : Container(),
        jobDetailView("assets/icons/calendar.png",
            "${jobProvider.detailsModel!.jobDetails!.jobDate}"),
        const SizedBox(height: 12),
        jobDetailView(
          "assets/images/briefcase.png",
          tr('client.job_category.${jobProvider.detailsModel!.jobDetails!.category!.toLowerCase()}'),
        ),
        const SizedBox(height: 12),
        jobProvider.detailsModel!.jobDetails!.state! == JobStatus.published ||
                jobProvider.detailsModel!.jobDetails!.state! ==
                    JobStatus.accepted
            ? jobDetailView(
                "assets/icons/coins_stacked.png",
                "€${format.format(
                  jobProvider.detailsModel!.jobDetails!.state! ==
                          JobStatus.published
                      ? jobProvider.detailsModel!.jobDetails!.budget
                      : jobProvider.detailsModel!.jobDetails!.acceptedBudget,
                )}")
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/coins_stacked.png",
                          height: 24, width: 24),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Accepted budget",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: black343,
                                fontFamily: 'Satoshi'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "€${format.format(
                              jobProvider.detailsModel!.jobDetails!.state! ==
                                      JobStatus.published
                                  ? jobProvider.detailsModel!.jobDetails!.budget
                                  : jobProvider
                                      .detailsModel!.jobDetails!.acceptedBudget,
                            )}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/message-text-square.png",
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "${jobProvider.detailsModel!.jobDetails!.description}",
                    style: const TextStyle(
                      color: black343,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 110),
      ],
    );
  }

  Widget galleryView(
      GetProfessionalJobListProvider getProfessionalJobListProvider) {
    int dataLength = getProfessionalJobListProvider.currentJobGallery.length;
    log("IMAGE Length ==> $dataLength");
    List<Widget> rightImages = [];
    List<Widget> leftImages = [];
    for (int i = 0;
        i < getProfessionalJobListProvider.currentJobGallery.length;
        i++) {
      if (i >
          (dataLength == 5
              ? 0
              : dataLength == 3
                  ? 0
                  : dataLength == 2
                      ? -1
                      : 2)) {
        if (i % 2 == 0) {
          rightImages.add(Container(
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  openImage(
                      image: getProfessionalJobListProvider
                          .currentJobGallery[i].mediaUrl!);
                },
                child: Hero(
                  tag: "photo",
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.network(
                      getProfessionalJobListProvider
                          .currentJobGallery[i].mediaUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Error Loading",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ));
        } else {
          leftImages.add(Container(
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  openImage(
                      image: getProfessionalJobListProvider
                          .currentJobGallery[i].mediaUrl!);
                },
                child: Hero(
                  tag: "photo",
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.34,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.network(
                      getProfessionalJobListProvider
                          .currentJobGallery[i].mediaUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Error Loading \n Image",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ));
        }
      } else {
        rightImages.add(Container(
          margin: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () {
                openImage(
                    image: getProfessionalJobListProvider
                        .currentJobGallery[i].mediaUrl!);
              },
              child: Hero(
                tag: "photo",
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    getProfessionalJobListProvider
                        .currentJobGallery[i].mediaUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                              Text(
                                "Error Loading",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
      }
    }

    return getProfessionalJobListProvider.getCurrentJobGallery().isEmpty
        ? emptyGalleryView()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(direction: Axis.vertical, children: rightImages),
              Wrap(direction: Axis.vertical, children: leftImages),
            ],
          );
  }

  void openImage({
    required String image,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(
                      tr('admin.users.no_image'),
                    ),
                  ),
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Hero(
                      tag: "photo",
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            fullscreenDialog: true));
  }

  Widget applicationWidgetView() {
    return Consumer<GetClientJobListProvider>(builder: (context, value, child) {
      return value.applicationsModel == null
          ? const Center(child: CircularProgressIndicator())
          : value.applicationsModel!.applications!.isEmpty
              ? emptyApplicationsView()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.applicationsModel!.applications!.length,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String b =
                        '${value.applicationsModel!.applications![index].chatCount}';
                    double aaa = b.length.toDouble() + 10.0;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                jobId: value.detailsModel!.jobDetails!.id
                                    .toString(),
                                userId: value.applicationsModel!
                                    .applications![index].professionalId
                                    .toString(),
                                userName: value
                                        .applicationsModel!
                                        .applications![index]
                                        .professionalName ??
                                    '',
                                userImage: value
                                        .applicationsModel!
                                        .applications![index]
                                        .professionalImage ??
                                    '',
                                jobCategory:
                                    value.detailsModel!.jobDetails!.category!,
                                state: value.detailsModel!.jobDetails!.state!,
                                acceptedBudget:
                                    value.detailsModel!.jobDetails!.state! ==
                                            JobStatus.published
                                        ? value.detailsModel!.jobDetails!.budget
                                        : value.detailsModel!.jobDetails!
                                            .acceptedBudget,
                                description: value
                                    .detailsModel!.jobDetails!.description!,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(children: [
                              CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${value.applicationsModel!.applications![index].professionalImage}")),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${value.applicationsModel!.applications![index].professionalName}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.euro_symbol,
                                          size: 14.0,
                                        ),
                                        Text(
                                          "${value.applicationsModel!.applications![index].price}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.0, right: aaa),
                                    child: Image.asset(
                                      "assets/icons/message_chat.png",
                                      height: 25,
                                      width: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: aaa),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: yellowF4D,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(
                                          '${value.applicationsModel!.applications![index].chatCount}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                      ),
                    );
                  },
                );
    });
  }

  Widget appBarView(JobDetails jobDetails) {
    return AppBar(
      backgroundColor: whiteF2F,
      automaticallyImplyLeading: true,
      centerTitle: true,
      elevation: 0,
      title: Text(
        tr('client.job_category.${jobDetails.category!.toLowerCase()}'),
      ),
      actions: [
        jobDetails.state == JobStatus.published
            ? InkWell(
                child: Image.asset('assets/icons/delete.png',
                    height: 20, width: 20, color: Colors.red),
                onTap: () {
                  showJobDeleteConfirmation(context, jobDetails.id!);
                },
              )
            : Container()
      ],
    );
  }

  Widget statusView(String state) {
    return Chip(
        backgroundColor: state == JobStatus.published
            ? publishedChipColor
            : state == JobStatus.accepted
                ? acceptedChipColor
                : state == JobStatus.doing
                    ? doingChipColor
                    : state == JobStatus.pending
                        ? pendingChipColor
                        : state == JobStatus.completed
                            ? completedChipColor
                            : state == JobStatus.rejected
                                ? rejectedChipColor
                                : state == JobStatus.reported
                                    ? reportedChipColor.withOpacity(0.1)
                                    : Colors.white,
        label: Text(
            tr(
              tr('client.job_status.${state.toLowerCase()}'),
            ),
            style: Theme.of(context).textTheme.caption!.apply(
                color: state == JobStatus.published
                    ? green26A
                    : state == JobStatus.accepted
                        ? acceptedTagTextColor
                        : state == JobStatus.pending
                            ? primaryColor
                            : state == JobStatus.reported
                                ? rejectedChipColor
                                : Colors.white)));
  }

  Widget textView(GetClientJobListProvider jobProvider) {
    return Text(
      jobProvider.detailsModel!.jobDetails!.title!,
      style: const TextStyle(
        color: splashColor1,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget tabViewClient(String state, int length) {
    var tabs = [
      tr('admin.job_detail.Description'),
      tr('admin.job_detail.Gallery')
    ];
    if (state == JobStatus.published) {
      tabs.add('${tr('admin.job_detail.Applicants')}($length)');
    }

    return singleSelectionButtons(
        context: context,
        buttons: tabs,
        padding: 8,
        selected: selectedType,
        onSelectionChange: (value) {
          setState(() {
            selectedType = value;
          });
        });
  }

  Widget jobDetailView(icon, text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ListTile(
        horizontalTitleGap: 1,
        leading: Image.asset(icon, height: 24, width: 24),
        title: Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }

  Widget emptyGalleryView() {
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
              Text(tr('admin.users.no_image'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(tr('admin.users.check_letter'),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget emptyApplicationsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/watch-circle.png',
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
              Text(tr('admin.users.no_application'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(tr('admin.users.check_letter'),
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

  void showJobDeleteConfirmation(BuildContext context, String jobId) {
    bool isJobUpdateLoading = false;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            contentPadding: const EdgeInsets.all(12),
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: StatefulBuilder(builder: (context, newState) {
              return confirmationDialogueView(
                  context: context,
                  titleIconColor: Colors.red,
                  mainIcon: 'delete.png',
                  title: tr('client.delete_job_dialogue.are_you_sure_delete'),
                  description: tr('client.delete_job_dialogue.once_delete'),
                  button1Name: tr('client.delete_job_dialogue.cancel'),
                  button2Name: tr('client.delete_job_dialogue.delete'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    Navigator.pop(context);
                  },
                  onButton2Click: () {
                    newState(() {
                      isJobUpdateLoading = true;
                    });
                    var provider = context.read<GetClientJobListProvider>();
                    provider
                        .deleteJob(context: context, jobId: jobId)
                        .then((value) {
                      provider.getClientJobList(provider.getSelectedFilter(),
                          provider.getSelectedJobType(), context);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  },
                  button2TextColor: Colors.red,
                  button2Icon: 'delete.png',
                  button1Icon: 'go_backward.png');
            })));
  }

  void showJobRejectConfirmation(BuildContext context, String jobId) {
    bool isJobUpdateLoading = false;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            contentPadding: const EdgeInsets.all(12),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: StatefulBuilder(builder: (context, newState) {
              return confirmationDialogueView(
                  context: context,
                  titleIconColor: Colors.red,
                  mainIcon: 'close_square.png',
                  title: tr('client.reject_job.are_you_sure_reject'),
                  description:
                      tr('client.reject_job.rejected_action_can_not_be_undone'),
                  button1Name: tr('client.Accept_job.Cancel'),
                  button2Name: tr('client.reject_job.Reject_job'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    Navigator.pop(context);
                  },
                  onButton2Click: () {
                    newState(() {
                      isJobUpdateLoading = true;
                    });
                    var provider = context.read<GetClientJobListProvider>();
                    provider
                        .updateJobStatus(
                            status: 2, context: context, jobId: jobId)
                        .then((value) {
                      if (value!.success!) {
                        provider.getDetailsClient(context, jobId);
                        provider.getClientJobList(provider.getSelectedFilter(),
                            provider.getSelectedJobType(), context);
                        Navigator.of(context).pop();
                      }
                      newState(() {
                        isJobUpdateLoading = false;
                      });
                    });
                  },
                  button2TextColor: Colors.red,
                  button2Icon: 'close_square.png',
                  button1Icon: 'go_backward.png');
            })));
  }

  void showJobApproveConfirmation(BuildContext context, String jobId) {
    bool isJobUpdateLoading = false;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            contentPadding: const EdgeInsets.all(12),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: StatefulBuilder(builder: (context, newState) {
              return confirmationDialogueView(
                  context: context,
                  titleIconColor: Colors.red,
                  mainIcon: 'check_circle.png',
                  title: tr('client.Accept_job.are_you_sure_accept'),
                  description: tr('client.Accept_job.status_cant_be_changed'),
                  button1Name: tr('client.Accept_job.accept_job'),
                  button2Name: tr('client.Accept_job.Cancel'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    var provider = context.read<GetClientJobListProvider>();
                    provider
                        .updateJobStatus(
                            status: 1, context: context, jobId: jobId)
                        .then((value) {
                      if (value!.success!) {
                        provider.getDetailsClient(context, jobId);
                        provider.getClientJobList(provider.getSelectedFilter(),
                            provider.getSelectedJobType(), context);
                        Navigator.of(context).pop();
                      }
                      newState(() {
                        isJobUpdateLoading = false;
                      });
                    });
                  },
                  onButton2Click: () {
                    Navigator.pop(context);
                  },
                  button2Icon: 'go_backward.png',
                  button1Icon: 'check_circle.png');
            })));
  }
}
