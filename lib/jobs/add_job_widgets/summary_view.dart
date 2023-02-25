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
            Text('Building restructuring, or even bigger title about what to do',
                style: Theme.of(context).textTheme.headline3),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white),
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
                            color: isDescriptionSelected ? primaryColor : whiteF2F),
                        child: Center(
                            child: Text(
                              'Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .apply(
                                  color:
                                  isDescriptionSelected ? whiteF2F : primaryColor),
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
                            color: !isDescriptionSelected ? primaryColor : whiteF2F),
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
