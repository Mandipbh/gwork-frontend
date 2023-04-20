import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/add_offer_screen.dart';
import 'package:g_worker_app/jobs/provider/get_professional_job_list_provider.dart';

import 'package:provider/provider.dart';
import '../Constants.dart';
import '../chat/chat_widget_view/chat_screen.dart';
import '../common/common_buttons.dart';
import '../common/common_widgets.dart';

class JobDetailsScreenProfessional extends StatefulWidget {
  const JobDetailsScreenProfessional({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  final String? jobId;

  @override
  State<JobDetailsScreenProfessional> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreenProfessional> {
  bool isSelected = false;
  int selectedType = 1;
  String state = '';

  getJobDetails() {
    var provider =
        Provider.of<GetProfessionalJobListProvider>(context, listen: false);
    provider.getDetailsProfessional(context, widget.jobId);
    provider.getGallery(context, widget.jobId);
  }

  @override
  void initState() {
    super.initState();
    getJobDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetProfessionalJobListProvider>(
        builder: (context, provider, child) {
      state = !provider.getIsOverviewLoading()
          ? provider.detailsModel!.jobDetails!.applicationState!
          : '';
      return WillPopScope(
        onWillPop: () async {
          context.read<GetProfessionalJobListProvider>().clearDataModel();
          return true;
        },
        child: Scaffold(
          backgroundColor: whiteF2F,
          body: provider.getIsOverviewLoading()
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        provider.detailsModel == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : appBarView(provider),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                provider.detailsModel == null
                                    ? const Center(
                                        child: SizedBox(),
                                      )
                                    : statusChip(
                                        provider.detailsModel!.jobDetails!
                                            .applicationState!,
                                        context),
                                const SizedBox(height: 12),
                                textView(provider),
                                const SizedBox(height: 12),
                                tabViewProfessional(),
                                const SizedBox(height: 12),
                                selectedType == 1
                                    ? Expanded(
                                        child: provider.detailsModel == null
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : SingleChildScrollView(
                                                child: description(provider),
                                              ),
                                      )
                                    : selectedType == 2
                                        ? Expanded(
                                            child: SingleChildScrollView(
                                              child: galleryView(provider),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 1,
                      left: 1,
                      right: 1,
                      child: state == JobStatus.accepted
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              width: MediaQuery.of(context).size.width - 20,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              child: submitButton(
                                onButtonTap: () {
                                  showStartJobConfirmation(context,
                                      provider.detailsModel!.jobDetails!.id!);
                                },
                                context: context,
                                backgroundColor: primaryColor,
                                buttonName: tr(
                                    'Professional.start_job_dialogue.Start_job'),
                                iconAsset: 'flag.png',
                              ),
                            )
                          : state == JobStatus.doing
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  width: MediaQuery.of(context).size.width - 20,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  child: submitButton(
                                    onButtonTap: () {
                                      showCompleteJobConfirmation(
                                          context,
                                          provider
                                              .detailsModel!.jobDetails!.id!);
                                    },
                                    context: context,
                                    backgroundColor: primaryColor,
                                    buttonName: tr(
                                        'Professional.complete_job_dialogue.Complete_job'),
                                    iconAsset: 'check_circle.png',
                                  ),
                                )
                              : state == JobStatus.completed
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(8),
                                      child: submitButton(
                                        onButtonTap: () {},
                                        context: context,
                                        backgroundColor: primaryColor,
                                        buttonName:
                                            tr('admin.job_detail.View_invoice'),
                                        iconAsset: 'file.png',
                                      ),
                                    )
                                  : state == JobStatus.applied
                                      ? rejectView(provider)
                                      : state == JobStatus.published
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white54,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20,
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      onTap: () {
                                                        openPriceEditOption(
                                                            provider);
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            color:
                                                                Colors.white),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Image.asset(
                                                                'assets/icons/coins-stacked-01.png',
                                                                width: 20,
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    tr('admin.job_detail.Price')
                                                                        .toUpperCase(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .button!
                                                                        .apply(
                                                                            color:
                                                                                primaryColor),
                                                                  ),
                                                                  Text(
                                                                    '00.00',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .button!
                                                                        .apply(
                                                                            color:
                                                                                primaryColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Image.asset(
                                                                  'assets/icons/currency-euro.png',
                                                                  height: 24,
                                                                  width: 24),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      onTap: () {
                                                        showJobApplyConfirmation(
                                                            context,
                                                            provider
                                                                .detailsModel!
                                                                .jobDetails!
                                                                .id!,
                                                            provider
                                                                .detailsModel!
                                                                .jobDetails!
                                                                .budget!);
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            color:
                                                                primaryColor),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                tr('Professional.apply_job_dialogue.Apply')
                                                                    .toUpperCase(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .button!
                                                                    .apply(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              const Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
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

  Widget description(GetProfessionalJobListProvider provider) {
    return Column(
      children: [
        jobDetailView("assets/icons/marker_location.png",
            "${provider.detailsModel!.jobDetails!.street!}, ${provider.detailsModel!.jobDetails!.province!}"),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: ListTile(
            horizontalTitleGap: 10,
            leading: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              radius: 20,
              child: provider.detailsModel!.jobDetails!.clientImage != null
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
                          provider.detailsModel!.jobDetails!.clientImage!,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
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
                      "${provider.detailsModel!.jobDetails!.clientName!.split(' ')[0][0]}${provider.detailsModel!.jobDetails!.clientName!.split(' ')[1][0]}",
                      style: const TextStyle(color: black343),
                    ),
            ),
            title: Text(
              provider.detailsModel!.jobDetails!.clientName!,
              style: const TextStyle(
                color: black343,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              tr('admin.dashboard.client'),
              style: const TextStyle(
                color: grey807,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: provider.detailsModel!.jobDetails!.applicationState !=
                    JobStatus.published
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              jobId: provider.detailsModel!.jobDetails!.id!,
                              userId:
                                  provider.detailsModel!.jobDetails!.userId!,
                              userName: provider
                                  .detailsModel!.jobDetails!.clientName!,
                              userImage: provider
                                  .detailsModel!.jobDetails!.clientImage!,
                              jobCategory:
                                  provider.detailsModel!.jobDetails!.category!,
                              state: provider.detailsModel!.jobDetails!.state!,
                              acceptedBudget: provider
                                  .detailsModel!.jobDetails!.acceptedBudget!,
                              description: provider
                                  .detailsModel!.jobDetails!.description!,
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
                                "${provider.detailsModel!.jobDetails!.chatCount}",
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
                  )
                : const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 12),
        jobDetailView("assets/icons/calendar.png",
            "${provider.detailsModel!.jobDetails!.jobDate}"),
        const SizedBox(height: 12),
        jobDetailView(
          "assets/images/briefcase.png",
          tr('client.job_category.${provider.detailsModel!.jobDetails!.category!.toLowerCase()}'),
        ),
        const SizedBox(height: 12),
        jobDetailView(
            "assets/icons/coins_stacked.png",
            '€ ${NumberFormat('#.00').format(
              provider.detailsModel!.jobDetails!.applicationState ==
                      JobStatus.published
                  ? provider.detailsModel!.jobDetails!.budget
                  : provider.detailsModel!.jobDetails!.acceptedBudget!,
            )}'),
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
                    "${provider.detailsModel!.jobDetails!.description}",
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

  Widget appBarView(GetProfessionalJobListProvider provider) {
    return AppBar(
      backgroundColor: whiteF2F,
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, color: splashColor1, size: 20),
      ),
      title: Text(
        tr('client.job_category.${provider.detailsModel!.jobDetails!.category!.toLowerCase()}'),
        style: const TextStyle(
          color: splashColor1,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget textView(GetProfessionalJobListProvider provider) {
    return Text(
      provider.detailsModel!.jobDetails!.title!,
      style: const TextStyle(
        color: splashColor1,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget tabViewProfessional() {
    return singleSelectionButtons(
        context: context,
        buttons: [
          tr('admin.job_detail.Description'),
          tr('admin.job_detail.Gallery'),
        ],
        padding: 8,
        selected: selectedType,
        onSelectionChange: (value) {
          setState(() {
            selectedType = value;
            print("dhyfgh $value");
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
          style: const TextStyle(
            color: black343,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget rejectView(GetProfessionalJobListProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showJobRejectConfirmation(
              context, provider.detailsModel!.jobDetails!.id!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('admin.job_detail.reject').toUpperCase(),
              style: const TextStyle(
                color: redE45,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset("assets/icons/close_square.png",
                height: 30, width: 30, color: redE45),
          ],
        ),
      ),
    );
  }

  void openPriceEditOption(
      GetProfessionalJobListProvider getProfessionalJobListProvider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOfferScreen(
          budget:
              getProfessionalJobListProvider.detailsModel!.jobDetails!.budget,
          description: getProfessionalJobListProvider
              .detailsModel!.jobDetails!.description!,
          jobId: getProfessionalJobListProvider.detailsModel!.jobDetails!.id!,
        ),
      ),
    );
    log("ProfAddId :: ${getProfessionalJobListProvider.detailsModel!.jobDetails!.id!}");
  }

  void showJobApplyConfirmation(BuildContext context, String jobId, int price) {
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
                  mainIcon: 'coins-stacked-01.png',
                  title:
                      tr('Professional.apply_job_dialogue.are_you_sure_apply'),
                  description:
                      tr('Professional.apply_job_dialogue.you_can_change'),
                  button1Name: tr('Professional.apply_job_dialogue.Apply'),
                  button2Name: tr('Professional.apply_job_dialogue.Cancel'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    newState(() {
                      isJobUpdateLoading = true;
                    });
                    var provider =
                        context.read<GetProfessionalJobListProvider>();
                    provider
                        .applyJob(context: context, price: price, jobId: jobId)
                        .then((value) {
                      if (value!.success!) {
                        Navigator.pop(context);
                        provider.getDetailsProfessional(context, jobId);
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

  void showJobRejectConfirmation(BuildContext context, String jobId) {
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
                    var provider =
                        context.read<GetProfessionalJobListProvider>();
                    provider
                        .rejectJobs(context: context, jobId: jobId)
                        .then((value) {
                      if (value!.success!) {
                        Navigator.pop(context);
                        provider.getDetailsProfessional(context, jobId);
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

  void showStartJobConfirmation(BuildContext context, String jobId) {
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
                  mainIcon: 'flag.png',
                  title:
                      tr('Professional.start_job_dialogue.are_you_sure_start'),
                  description:
                      tr('Professional.start_job_dialogue.press_start'),
                  button1Name: tr('Professional.start_job_dialogue.Start_job'),
                  button2Name: tr('Professional.start_job_dialogue.Cancel'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    newState(() {
                      isJobUpdateLoading = true;
                    });
                    var provider =
                        context.read<GetProfessionalJobListProvider>();
                    provider
                        .startJob(context: context, jobId: jobId)
                        .then((value) {
                      if (value!.success!) {
                        Navigator.pop(context);
                        provider.getDetailsProfessional(context, jobId);
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
                  button1Icon: 'flag.png');
            })));
  }

  void showCompleteJobConfirmation(BuildContext context, String jobId) {
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
                  mainIcon: 'check_circle.png',
                  title: tr(
                      'Professional.complete_job_dialogue.are_you_sure_complete'),
                  description:
                      tr('Professional.complete_job_dialogue.once_complete'),
                  button1Name:
                      tr('Professional.complete_job_dialogue.Complete_job'),
                  button2Name: tr('Professional.complete_job_dialogue.Cancel'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    newState(() {
                      isJobUpdateLoading = true;
                    });
                    var provider =
                        context.read<GetProfessionalJobListProvider>();
                    provider
                        .completeJob(context: context, jobId: jobId)
                        .then((value) {
                      if (value!.success!) {
                        Navigator.pop(context);
                        provider.getDetailsProfessional(context, jobId);
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
