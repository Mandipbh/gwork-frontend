import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/add_job_widgets/upload_images_view.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../common/common_input_fields.dart';

class SummaryView extends StatefulWidget {
  const SummaryView({Key? key}) : super(key: key);

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  bool isDescriptionSelected = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              tr('client.summary.Summary'),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(tr('client.summary.Building_restructuring'),
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      isDescriptionSelected = !isDescriptionSelected;
                    });
                  },
                  child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              isDescriptionSelected ? primaryColor : whiteF2F),
                      child: Center(
                          child: Text(
                        tr('client.summary.Description'),
                        style: Theme.of(context).textTheme.subtitle1!.apply(
                            color: isDescriptionSelected
                                ? whiteF2F
                                : primaryColor),
                      ))),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      isDescriptionSelected = !isDescriptionSelected;
                    });
                  },
                  child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              !isDescriptionSelected ? primaryColor : whiteF2F),
                      child: Center(
                        child: Text(tr('client.summary.Gallery'),
                            style: Theme.of(context).textTheme.subtitle1!.apply(
                                color: !isDescriptionSelected
                                    ? Colors.white
                                    : primaryColor)),
                      )),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          isDescriptionSelected ? descriptionView() : galleryView(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget descriptionView() {
    return Consumer<CreateClientJobProvider>(
      builder: (context, value, child) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffffffff)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/marker_location.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        value.streetController.text,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffffffff)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/calendar.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${value.dateController.text} — ${value.timeController.text}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffffffff)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/job.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        value.category.toString(),
                        // value.category == 1
                        //     ? "Cleaning"
                        //     : value.category == 2
                        //         ? "Babysitting"
                        //         : value.category == 3
                        //             ? "Tutoring"
                        //             : "HandyMan",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffffffff)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/budget.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr('client.summary.Accepted_budget'),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            value.budgetController.text,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0x0ffffffff)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/message_text.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          value.describeController.text,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  galleryView() {
    return Consumer<UploadImageProvider>(
      builder: (context, uploadImageProvider, child) {
        return Expanded(
          child: uploadImageProvider.imageList.length == 1
              ? const Center(
                  child: Text("NO IMAGE FOUND"),
                )
              : GridView.count(
                  // physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: List.generate(
                      uploadImageProvider.imageList.length - 1, (index) {
                    List<String> abc = [];
                    for (var i in uploadImageProvider.imageList) {
                      if (!i.contains("add")) {
                        abc.add(i);
                      }
                    }
                    return abc.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text(
                                                  "${abc[index].split("/").last}"),
                                            ),
                                            body: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Hero(
                                                tag: "abc",
                                                child: Image.file(
                                                  File(
                                                    abc[index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                      fullscreenDialog: true));
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.44,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Hero(
                                  tag: "abc",
                                  child: Image.file(
                                    File(
                                      abc[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text("NO IMAGE FOUND"),
                          );
                  }),
                ),
        );
      },
    );
  }
}
