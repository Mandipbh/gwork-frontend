import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/chat/chat_screen.dart';
import 'package:g_worker_app/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import '../common/common_buttons.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isSelected = false;
  bool isApply = false;
  bool isReject = false;
  int selectedType = 1;
  List chatlist = [
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€30,00",
      "chatpending": "1"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Eleanor Pena",
      "money": "€60,00",
      "chatpending": "20"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Kathryn Murphy",
      "money": "€60,00",
      "chatpending": "100"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Ronald Richards",
      "money": "€10,00",
      "chatpending": "1012"
    },
    {
      "image": "assets/images/Ellipse.png",
      "name": "Devon Lane",
      "money": "€50,00",
      "chatpending": "1"
    }
  ];
  List imagelist = [
    "https://i.pinimg.com/550x/2f/eb/0d/2feb0d13f24b8474915d732b071d0123.jpg",
    "https://i.pinimg.com/564x/15/be/7b/15be7b96ffa36a6b799e79ba895029be.jpg",
    "https://i.pinimg.com/564x/52/77/c8/5277c8cdeb152d49a635cf1899a3ef85.jpg",
    "https://i.pinimg.com/564x/74/d1/72/74d17228a9ab972ac3a4d5c0ead0f4b6.jpg",
    "https://i.pinimg.com/564x/fe/ff/ee/feffee64844e3dd2decccaa3661b1a41.jpg",
    "https://i.pinimg.com/564x/47/d4/3b/47d43bb5fb9df374dc08d8620d744d81.jpg",
    "https://i.pinimg.com/564x/59/16/8b/59168ba23c7371050a093394a7b76080.jpg",
  ];
  List oddlist = [];
  List evenlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < imagelist.length; i++) {
      if (i % 2 == 0) {
        oddlist.add(imagelist[i]);
      }
    }
    for (int i = 0; i < imagelist.length; i++) {
      if (i % 2 == 1) {
        evenlist.add(imagelist[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(height: 35),
              appBarView(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      statusView(),
                      const SizedBox(height: 12),
                      textView(),
                      const SizedBox(height: 12),
                      tabView(),
                      const SizedBox(height: 12),
                      selectedType == 1
                          ? Expanded(
                              child: SingleChildScrollView(
                                child: description(),
                              ),
                            )
                          : Expanded(
                              child: SingleChildScrollView(child: Gallary())),
                    ],
                  ),
                ),
              )
            ],
          ),
          isReject == true
              ? const SizedBox.shrink()
              : isApply == true
                  ? rejectView()
                  : Provider.of<SignUpProvider>(context, listen: false)
                              .userType ==
                          0
                      ? const SizedBox.shrink()
                      : bottomView(),
        ],
      ),
    );
  }

  Widget description() {
    return Column(
      children: [
        jobDetailView("assets/icons/marker_location.png",
            "Via Bronzolo, 11, Milano, 25124"),
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
              child: const Text(
                "ST",
                style: TextStyle(color: black343),
              ),
            ),
            title: const Text(
              "Eleanor Pena",
              style: TextStyle(
                color: black343,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              "Client",
              style: TextStyle(
                color: grey807,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: isApply == true
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatScreen()),
                          (Route<dynamic> route) => true);
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
                            child: const Center(
                              child: Text(
                                '12',
                                style: TextStyle(
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
        jobDetailView("assets/icons/calendar.png", "03/02/2021 — 09:31"),
        const SizedBox(height: 12),
        jobDetailView("assets/icons/briefcase.png", "Babysitting"),
        const SizedBox(height: 12),
        jobDetailView("assets/icons/coins_stacked.png", "€60,00"),
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
                const Expanded(
                  child: Text(
                    "Babysitters perform general caregiving duties that ensure children’s needs are met while their parents or guardians are away. Their duties include providing transportation to and from a child’s extracurricular activities, preparing basic meals and keeping the child company with games and other entertainment.",
                    style: TextStyle(
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

  Widget Gallary() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // itemCount: (imagelist.length / 2).toInt(),
                itemCount: oddlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.network(
                          oddlist[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: evenlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.network(
                        evenlist[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  // Widget Application() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: chatlist.length,
  //     itemBuilder: (context, index) {
  //       String b = chatlist[index]["chatpending"].toString();
  //       double aaa = b.length.toDouble() + 10.0;
  //       return InkWell(
  //         onTap: () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ChatScreen(),
  //               ));
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.all(5.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: white, borderRadius: BorderRadius.circular(12)),
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Row(children: [
  //                 CircleAvatar(
  //                   child: Image.asset("${chatlist[index]["image"]}"),
  //                 ),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "${chatlist[index]["name"]}",
  //                       style: TextStyle(
  //                           fontSize: 14, fontWeight: FontWeight.w700),
  //                     ),
  //                     Text(
  //                       "${chatlist[index]["money"]}",
  //                       style: TextStyle(
  //                           fontSize: 14, fontWeight: FontWeight.w500),
  //                     ),
  //                   ],
  //                 ),
  //                 Spacer(),
  //                 Container(
  //                   child: Stack(
  //                     alignment: Alignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.only(top: 5.0, right: aaa),
  //                         child: Image.asset(
  //                           "assets/icons/message_chat.png",
  //                           height: 25,
  //                           width: 50,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.only(left: aaa),
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                               color: Color(0xffF4D874),
  //                               borderRadius: BorderRadius.circular(13)),
  //                           child: Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 5.0),
  //                             child: Text(
  //                               "${chatlist[index]["chatpending"]}",
  //                               style: TextStyle(fontSize: 12),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       // Row(children: [
  //
  //                       // ],),
  //                     ],
  //                   ),
  //                 )
  //               ]),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget appBarView() {
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
        tr('admin.job_detail.Babysitting'),
        style: const TextStyle(
          color: splashColor1,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Provider.of<SignUpProvider>(context, listen: false).userType == 0
            ? Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Image.asset(
                  'assets/icons/delete.png',
                  height: 24,
                  width: 24,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget statusView() {
    return Center(
      child: MaterialButton(
        onPressed: () {},
        height: 22,
        minWidth: 73,
        color: isReject == true
            ? redE45
            : isApply == true
                ? blue4C7.withOpacity(0.3)
                : greenE1F,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Text(
          isReject == true
              ? tr('admin.dashboard.rejected')
              : isApply == true
                  ? tr('Professional.logIn.Jobs.Applied')
                  : tr('admin.dashboard.Published'),
          style: TextStyle(
            color: isReject == true
                ? Colors.white
                : isApply == true
                    ? blue4C7
                    : green26A,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget textView() {
    return Text(
      tr('admin.job_detail.Building_restructuring'),
      style: const TextStyle(
        color: splashColor1,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget tabView() {
    return singleSelectionButtons(
        context: context,
        buttons: [
          tr('admin.job_detail.Description'),
          tr('admin.job_detail.Gallery'),
          // tr('admin.job_detail.Applications'),
        ],
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
          style: const TextStyle(
            color: black343,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget bottomView() {
    return Positioned(
      bottom: 14,
      left: 14,
      right: 14,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteF2F,
          boxShadow: [
            BoxShadow(
              color: green0D3.withOpacity(0.2),
              blurRadius: 42,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/coins-stacked-01.png",
                            height: 24,
                            width: 24,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr('admin.job_detail.Price'),
                                style: const TextStyle(
                                  color: black343,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Text(
                                "100,00",
                                style: TextStyle(
                                  color: black343,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Image.asset("assets/icons/currency-euro.png",
                              height: 24, width: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    askForApply(context);
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tr('admin.job_detail.Apply').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward,
                            color: Colors.white, size: 22)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void askForApply(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 13),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: jobApplyPopPupView()));
  }

  Widget jobApplyPopPupView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: whiteEFE,
          child: Image.asset(
            "assets/icons/check_circle.png",
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          tr('Professional.apply_job_dialogue.are_you_sure_apply'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: splashColor1,
            fontSize: 24,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr('Professional.apply_job_dialogue.you_can_change'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: black343,
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        MaterialButton(
          onPressed: () {
            setState(() {
              isApply = true;
              Navigator.pop(context);
            });
          },
          height: 48,
          minWidth: double.infinity,
          color: splashColor1,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('Professional.apply_job_dialogue.Apply').toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                "assets/icons/check_circle.png",
                color: white,
                height: 22,
                width: 22,
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('Professional.apply_job_dialogue.Cancel').toUpperCase(),
                style: const TextStyle(
                  color: splashColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.close, color: splashColor1, size: 22)
            ],
          ),
        ),
      ],
    );
  }

  Widget rejectView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          askForReject(context);
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

  void askForReject(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 13),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: jobRejectView()));
  }

  Widget jobRejectView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: redF8D,
          child: Image.asset("assets/icons/close_square.png",
              height: 24, width: 24, color: redE45),
        ),
        const SizedBox(height: 14),
        Text(
          tr('Professional.reject_job_dialogue.are_you_sure_reject'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: splashColor1,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr('Professional.reject_job_dialogue.once_reject'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: black343,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          height: 48,
          minWidth: double.infinity,
          color: splashColor1,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('Professional.reject_job_dialogue.Cancel').toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.close, color: Colors.white, size: 22)
            ],
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              isReject = true;
              Navigator.pop(context);
              print("!!!!$isReject");
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('Professional.reject_job_dialogue.reject').toUpperCase(),
                style: const TextStyle(
                  color: redE45,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              Image.asset("assets/icons/close_square.png",
                  height: 24, width: 24, color: redE45),
            ],
          ),
        ),
      ],
    );
  }

  void askForStartJob(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: jobStartPopPupView()));
  }

  Widget jobStartPopPupView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: whiteEFE,
          child: Image.asset(
            "assets/icons/flag.png",
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          tr('Professional.start_job_dialogue.are_you_sure_start'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: splashColor1,
            fontSize: 24,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr('Professional.start_job_dialogue.press_start'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: black343,
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        MaterialButton(
          onPressed: () {
            setState(() {
              isApply = true;
              Navigator.pop(context);
            });
          },
          height: 48,
          minWidth: double.infinity,
          color: splashColor1,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('Professional.start_job_dialogue.Start_job').toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                "assets/icons/flag.png",
                height: 24,
                width: 24,
                color: white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('Professional.start_job_dialogue.Cancel').toUpperCase(),
                style: const TextStyle(
                  color: splashColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.close, color: splashColor1, size: 22)
            ],
          ),
        ),
      ],
    );
  }

  void askForCompleteJob(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: jobCompletePopPupView()));
  }

  Widget jobCompletePopPupView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: whiteEFE,
          child: Image.asset(
            "assets/icons/check-circle-broken.png",
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          tr('Professional.complete_job_dialogue.are_you_sure_complete'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: splashColor1,
            fontSize: 24,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr('Professional.complete_job_dialogue.once_complete'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: black343,
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        MaterialButton(
          onPressed: () {
            setState(() {
              isApply = true;
              Navigator.pop(context);
            });
          },
          height: 48,
          minWidth: double.infinity,
          color: splashColor1,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('Professional.complete_job_dialogue.Complete_job')
                    .toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                "assets/icons/check-circle-broken.png",
                height: 24,
                width: 24,
                color: white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('Professional.complete_job_dialogue.Cancel').toUpperCase(),
                style: const TextStyle(
                  color: splashColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.close, color: splashColor1, size: 22)
            ],
          ),
        ),
      ],
    );
  }
}
