import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_widgets.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/document_provider/document_provider.dart';
import 'package:provider/provider.dart';

class UploadDocumentView extends StatelessWidget {
  const UploadDocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 16),
          Text(tr('client.log_in.sign_up.Upload_document'),
              style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 15),
          DottedBorder(
            borderType: BorderType.Rect,
            dashPattern: [8, 8],
            color: grey9EA,
            strokeWidth: 2,
            child: const SizedBox(
              height: 110,
              width: 110,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            tr('Professional.logIn.onBoardingDocuments.Upload_documents_that_can_prove_your_competences'),
            style: const TextStyle(
              color: black343,
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Consumer<DocumentPicProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9),
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: value.docList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      uploadDocuments(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: value.docList[index] == "add"
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 21),
                                Image.asset('assets/images/upload_image.png',
                                    height: 100, width: 100),
                                Text(
                                    tr('Professional.logIn.onBoardingDocuments.Upload_Document'),
                                    style: Theme.of(context).textTheme.caption),
                                const SizedBox(height: 13),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(value.docList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
