import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/provider/get_professional_job_list_provider.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:provider/provider.dart';

class EditOfferScreen extends StatefulWidget {
  const EditOfferScreen({Key? key, this.budget, this.description, this.jobId})
      : super(key: key);

  final int? budget;
  final String? description;
  final String? jobId;

  @override
  State<EditOfferScreen> createState() => _EditOfferScreenState();
}

var editOfferController = TextEditingController();

class _EditOfferScreenState extends State<EditOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      body: Column(
        children: [
          const SizedBox(height: 70),
          appBarView(),
          const SizedBox(height: 24),
          bodyView(),
        ],
      ),
    );
  }

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
        tr('Professional.edit_offer.Edit_offer'),
        style: const TextStyle(
          color: splashColor1,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget bodyView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                tr('Professional.edit_offer.Building_restructuring'),
                style: const TextStyle(
                  color: black343,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
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
                      Expanded(
                        child: Text(
                          "${widget.description}",
                          style: const TextStyle(
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
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ListTile(
                  horizontalTitleGap: 1,
                  leading: Image.asset("assets/icons/coins_stacked.png",
                      height: 24, width: 24),
                  title: Text(
                    '€ ${NumberFormat('#.00').format(widget.budget)}',
                    style: const TextStyle(
                      color: black343,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 62,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: editOfferController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Image.asset(
                        "assets/icons/currency-euro.png",
                        scale: 2,
                      ),
                    ),
                    labelText: tr('Professional.edit_offer.Offer_price'),
                    hintText: '00,00',
                    contentPadding: const EdgeInsets.only(left: 16, top: 12),
                    hintStyle: const TextStyle(
                      color: grey9EA,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    counterText: "",
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                tr('Professional.edit_offer.Once_an_offer_is_accepted'),
                style: const TextStyle(
                  color: black343,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                onPressed: () {
                  ApiClient()
                      .editJobOffer(
                          jobId: widget.jobId!,
                          budget: editOfferController.text,
                          context: context)
                      .then((editOfferSuccessResponse) {
                    if (editOfferSuccessResponse!.success!) {
                      log("EditOfferJobId :: ${widget.jobId}");
                      var provider =
                          Provider.of<GetProfessionalJobListProvider>(context,
                              listen: false);
                      provider.getDetailsProfessional(context, widget.jobId);
                    }
                  });
                },
                height: 48,
                minWidth: double.infinity,
                color: splashColor1,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tr('Professional.edit_offer.Edit_offer').toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset('assets/icons/edit_profile.png',
                        height: 24, width: 24, color: white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
