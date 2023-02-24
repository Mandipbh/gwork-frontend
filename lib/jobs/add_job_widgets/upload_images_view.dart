import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';

import '../../common/common_input_fields.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({super.key});

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
                'Add some images for your work',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Text('The following fields are optional',
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 24),
            Expanded(
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.width * 0.44,
                        child: Stack(
                          children: [
                            Container(
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
                            Positioned.fill(
                              child: Center(
                                child: Image.asset(
                                    'assets/images/upload_image.png',
                                    height: 100,
                                    width: 100),
                              ),
                            )
                          ],
                        ),
                      );
                    }))),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
