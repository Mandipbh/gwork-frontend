import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Summary',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Text(
                'Building restructuring, or even bigger title about what to do',
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
                            color: isDescriptionSelected
                                ? primaryColor
                                : whiteF2F),
                        child: Center(
                            child: Text(
                          'Description',
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
                            color: !isDescriptionSelected
                                ? primaryColor
                                : whiteF2F),
                        child: Center(
                          child: Text('Gallery',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .apply(
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
      ),
    );
  }

  Widget descriptionView() {
    return Column(children: [
      Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(0x0ffffffff)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/marker_location.png",
                scale: 2,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Via Bronzolo, 11, Milano, 25124",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(0x0ffffffff)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/calendar.png",
                scale: 2,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "03/02/2021 — 09:31",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(0x0ffffffff)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/job.png",
                scale: 2,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Babysitting",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(0x0ffffffff)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/budget.png",
                scale: 2,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Accepted budget",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "€60,00",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(0x0ffffffff)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/icons/message_text.png",
                scale: 2,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  "Babysitters perform general caregiving duties that ensure children’s needs are met while their parents or guardians are away. Their duties include providing transportati",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  galleryView() {
    return Expanded(
      child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: List.generate(8, (index) {
            return SizedBox(
              height: MediaQuery.of(context).size.width * 0.44,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Upload Photo'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .apply(color: primaryColor),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
