import 'package:flutter/material.dart';
import 'package:g_worker_app/chat/chart_screen.dart';
import 'package:g_worker_app/colors.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isSelected = false;
  bool isApply = false;
  bool isReject = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteD9D,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(height: 35),
              appBarView(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        statusView(),
                        const SizedBox(height: 12),
                        textView(),
                        const SizedBox(height: 12),
                        tabView(),
                        const SizedBox(height: 12),
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
                            leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 30),
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
                                ? InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ChatScreen()),
                                        (Route<dynamic> route) => true);
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.asset(
                                    "assets/icons/message_chat.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  Positioned(
                                    top: 15,
                                    right: 5,
                                    child: Container(
                                      height: 18,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(24),
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
                        jobDetailView(
                            "assets/icons/calendar.png", "03/02/2021 — 09:31"),
                        const SizedBox(height: 12),
                        jobDetailView(
                            "assets/icons/briefcase.png", "Babysitting"),
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
                                  "assets/icons/message_chat.png",
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
                    ),
                  ),
                ),
              ),
            ],
          ),
          isReject == true
              ? const SizedBox.shrink()
              : isApply == true
              ? rejectView()
              : bottomView(),
        ],
      ),
    );
  }

  Widget appBarView() {
    return AppBar(
      backgroundColor: whiteD9D,
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, color: splashColor1, size: 20),
      ),
      title: const Text(
        'Babysitting',
        style: TextStyle(
          color: splashColor1,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
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
              ? 'Rejected'
              : isApply == true
              ? 'Applied'
              : 'Published',
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
    return const Text(
      'Building restructuring, or even bigger title about what to do',
      style: TextStyle(
        color: splashColor1,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget tabView() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Container(
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? whiteF2F : primaryColor),
                child: Center(
                    child: Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(color: isSelected ? primaryColor : Colors.white),
                    ))),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Container(
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: !isSelected ? whiteF2F : primaryColor),
                child: Center(
                  child: Text('Gallery',
                      style: Theme.of(context).textTheme.subtitle1!.apply(
                          color: !isSelected ? primaryColor : Colors.white)),
                )),
          ),
        ),
      ]),
    );
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
        leading: Image.asset(icon),
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
                child: InkWell(
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
                            "assets/icons/coins_stacked.png",
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Price",
                                style: TextStyle(
                                  color: black343,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "100,00",
                                style: TextStyle(
                                  color: black343,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          // Image.asset("assets/images/currency-euro.svg"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
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
                          "Apply".toUpperCase(),
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
          child: Image.asset("assets/icons/coins_stacked.png"),
        ),
        const SizedBox(height: 14),
        const Text(
          "Are you sure you want to apply for the job? ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: splashColor1,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "You can change the offer in any moment",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: black343,
            fontSize: 14,
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
                "Apply".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.check, color: Colors.white, size: 22)
            ],
          ),
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Cancel".toUpperCase(),
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
      child: InkWell(
        onTap: () {
          askForReject(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Reject".toUpperCase(),
              style: const TextStyle(
                color: redE45,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset("assets/icons/close_square.png"),
          ],
        ),
      ),
    );
  }

  void askForReject(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
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
          child: Image.asset("assets/icons/close_square.png"),
        ),
        const SizedBox(height: 14),
        const Text(
          "Are you sure you want to reject the job? ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: splashColor1,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Once rejected the action can not be undone",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: black343,
            fontSize: 14,
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
                "Cancel".toUpperCase(),
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
        InkWell(
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
                "Reject".toUpperCase(),
                style: const TextStyle(
                  color: redE45,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              Image.asset("assets/icons/close_square.png"),
            ],
          ),
        ),
      ],
    );
  }
}
