import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/home_page/view/home_screen.dart';

import 'package:g_worker_app/jobs/add_job_widgets/job_info_view.dart';
import 'package:g_worker_app/jobs/add_job_widgets/job_reason_view.dart';
import 'package:g_worker_app/jobs/add_job_widgets/more_info_view.dart';
import 'package:g_worker_app/jobs/add_job_widgets/schedule_view.dart';
import 'package:g_worker_app/jobs/add_job_widgets/summary_view.dart';
import 'package:g_worker_app/jobs/add_job_widgets/upload_images_view.dart';
import '../colors.dart';
import '../common/common_buttons.dart';
import '../common/common_widgets.dart';
import '../custom_progress_bar.dart';

class AddNewJobScreen extends StatefulWidget {
  const AddNewJobScreen({super.key});

  @override
  State<AddNewJobScreen> createState() => _AddNewJobScreenState();
}

class _AddNewJobScreenState extends State<AddNewJobScreen> {
  bool provideSelected = false;
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage == 1) {
          return true;
        }
        askForExit(
          context: context,
          onBackPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => false);
          },
          title:
              tr('client.log_in.confirmation_panel.want_to_stop_registration'),
          description: 'All inserted data will be deleted',
          backButtonName: tr('admin.exit_dialogue.go_back'),
        );
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
            child: AppBar(
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: whiteF2F,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentPage == 1
                          ? IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          : const SizedBox(
                              width: 16,
                            ),
                      Text(
                        tr('client.type_picker.New_job'),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      currentPage != 1
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                askForExit(
                                  context: context,
                                  onBackPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                  title:
                                      'Are you sure you want to stop creating the job?',
                                  description:
                                      'All inserted data will be deleted',
                                  backButtonName:
                                      tr('admin.exit_dialogue.go_back'),
                                );
                              },
                            )
                          : const SizedBox(
                              width: 16,
                            ),
                    ],
                  ),
                ],
              ),
              backgroundColor: const Color(0xfff2f2f2),
              elevation: 1,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: mainView(),
          )),
    );
  }

  Widget mainView() {
    final List<Widget> pages = <Widget>[
      const JobReasonView(),
      const JobInfoView(),
      const ScheduleView(),
      const MoreInfoView(),
      const UploadImageView(),
      const SummaryView()
    ];
    return Column(
      children: [
        Expanded(
          child: PageView(
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (int pageIndex) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  currentPage = pageIndex + 1;
                });
              });
            },
            children: pages,
          ),
        ),
        progressView()
      ],
    );
  }

  Widget progressView() {
    String label = currentPage == 1
        ? tr('Professional.logIn.onBoardingUserType.reason')
        : currentPage == 2
            ? tr('client.Job_info.Job_info')
            : currentPage == 3
                ? tr('client.date_time.Schedule')
                : currentPage == 4 || currentPage == 5
                    ? tr('client.case_descrive.More_info')
                    : currentPage == 6
                        ? tr('client.summary.Summary')
                        : '';
    return Container(
      height: 128,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: const Color(0xfff2f2f2),
                  child: Text(
                    currentPage.toString().padLeft(2, '0'),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 12),
                Text(label.toUpperCase()),
                const SizedBox(width: 30),
                Expanded(
                    child: CustomProgressBar(
                  max: 6,
                  current: currentPage.toDouble(),
                  color: primaryColor,
                  bgColor: whiteF2F,
                )),
              ],
            ),
          ),
          previousAndNextButtons(
              context: context,
              onPreviousTap: () {
                controller.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              onNextTap: () {
                if (currentPage > 5) {
                  Navigator.of(context).pop();
                } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                }
              },
              nextButtonName: currentPage > 5
                  ? 'Publish'
                  : tr('Professional.logIn.onBoardingUserType.Next'),
              nextButtonIcon: Icon(
                  currentPage > 5 ? Icons.done : Icons.arrow_forward,
                  color: Colors.white),
              showPrevious: currentPage != 1),
        ],
      ),
    );
  }
}
