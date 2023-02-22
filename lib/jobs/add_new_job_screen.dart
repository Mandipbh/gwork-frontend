import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        if(currentPage == 1){
          return true;
        }
        askForStopRegistration(context);
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
                      const Text(
                        'New Job',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      currentPage != 1
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                askForStopRegistration(context);
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
        ? 'Reason'
        : currentPage == 2
            ? 'Job Info'
            : currentPage == 3
                ? 'Schedule'
                : currentPage == 4
                    ? 'More Info'
                    : currentPage == 5
                        ? 'Summary'
                        : '';
    return Container(
      height: currentPage > 5 ? 78 : 128,
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          currentPage > 5
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: const Color(0xfff2f2f2),
                        child: Text(
                          currentPage.toString().padLeft(2, '0'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(label.toUpperCase()),
                      const SizedBox(width: 30),
                      Expanded(
                          child: CustomProgressBar(
                        max: 5,
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
              nextButtonName: currentPage > 5 ? 'Accept' : 'Next Step',
              nextButtonIcon: Icon(
                  currentPage > 5 ? Icons.done : Icons.arrow_forward,
                  color: Colors.white),
              showPrevious: currentPage != 1 && currentPage <= 5),
        ],
      ),
    );
  }
}
