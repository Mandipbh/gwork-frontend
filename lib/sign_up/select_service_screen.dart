import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/custom_progress_bar.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  bool provideSelected = false;
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          child: Text(
            'What are you\nsearching for?',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Text('Please select one of two options',
            style: Theme.of(context).textTheme.bodyText2),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    provideSelected = !provideSelected;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: provideSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Provide Services',
                          style: Theme.of(context).textTheme.caption!.apply(
                              color: provideSelected
                                  ? Colors.white
                                  : primaryColor),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: provideSelected
                              ? const Color(0xff343734)
                              : const Color(0xfff2f2f2),
                          child: Image.asset(
                              'assets/icons/ic_provide_service.png',
                              color: provideSelected
                                  ? Colors.white
                                  : primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    provideSelected = !provideSelected;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: !provideSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Provide Services',
                            style: Theme.of(context).textTheme.caption!.apply(
                                color: !provideSelected
                                    ? Colors.white
                                    : primaryColor)),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: !provideSelected
                                ? const Color(0xff343734)
                                : const Color(0xfff2f2f2),
                          child: Image.asset(
                              'assets/icons/ic_require_service.png',
                              color: !provideSelected
                                  ? Colors.white
                                  : primaryColor),),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget progressView() {
    return Container(
      height: currentPage > 5 ? 78 : 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      padding: const EdgeInsets.all(8),
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
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('Reason'.toUpperCase(),style:Theme.of(context).textTheme.caption),
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
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: currentPage == 1 || currentPage > 5
                ? GestureDetector(
                    onTap: () {
                      if (currentPage > 5) {
                      } else {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: primaryColor),
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentPage > 5
                                ? 'Accept'.toUpperCase()
                                : 'Next Step'.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                              currentPage > 5
                                  ? Icons.done
                                  : Icons.arrow_forward,
                              color: Colors.white)
                        ],
                      )),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          },
                          child: SizedBox(
                            height: 60,
                            child: Center(
                                child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.arrow_back,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Previous Step'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: primaryColor),
                            child: Center(
                                child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Next Step'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(Icons.arrow_forward,
                                    color: Colors.white)
                              ],
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
