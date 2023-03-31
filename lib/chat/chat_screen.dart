import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/chat/edit_offer_screen.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/model/get_client_job_applications_model.dart';
import 'package:g_worker_app/jobs/provider/get_client_job_list_provider.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.applications}) : super(key: key);

  final Applications? applications;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      body: Stack(
        children: [
          topView(),
          centerView(),
          bottomView(),
        ],
      ),
    );
  }

  Widget topView() {
    return Consumer<GetClientJobListProvider>(
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 20),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                          color: splashColor1, size: 20),
                    ),
                    Column(
                      children: [
                        Text(
                          '${widget.applications!.professionalName}',
                          style: TextStyle(
                            color: splashColor1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          tr('client.chat.Babysitting'),
                          style: const TextStyle(
                            color: black343,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: widget.applications != null
                            ? widget.applications!.professionalImage != null
                                ? Image.network(
                                    widget.applications!.professionalImage!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const CircleAvatar(
                                          radius: 75,
                                          backgroundColor: Colors.white,
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 22,
                                              color: grey9EA,
                                            ),
                                          ));
                                    },
                                  )
                                : Center(
                                    child: Text(
                                        widget
                                            .applications!.professionalName![0],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  )
                            : Center(
                                child: Text(
                                    widget.applications!.professionalName![0],
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: whiteF2F,
                    //   radius: 25,
                    //   child: Text(
                    //     "ST",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         color: black343,
                    //         fontSize: 20,
                    //         fontFamily: 'Satoshi'),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const Divider(color: greyD3D, thickness: 1),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('client.chat.Offered_price'),
                          style: const TextStyle(
                            color: black343,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '5.000,00 €',
                          style: TextStyle(
                            color: splashColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Provider.of<SignUpProvider>(context).userType ==
                            UserType.client
                        ? GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditOfferScreen()),
                                  (Route<dynamic> route) => true);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      tr('client.chat.Accept').toUpperCase(),
                                      style: const TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Satoshi"),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.check,
                                        color: white, size: 30),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditOfferScreen()),
                                  (Route<dynamic> route) => true);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tr('client.chat.Edit').toUpperCase(),
                                  style: const TextStyle(
                                    color: splashColor1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.asset('assets/icons/edit_profile.png',
                                    height: 24, width: 24),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget centerView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset("assets/images/nomessage.svg"),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                child: Column(
                  children: [
                    Text(
                      tr('client.chat.no_messages'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: splashColor1,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      tr('client.chat.start_conversattion'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: black343,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 26, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: green0D3.withOpacity(0.2),
                blurRadius: 42,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: TextFormField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: tr('client.chat.Start_typing'),
              hintStyle: const TextStyle(
                color: grey9EA,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              suffixIcon:
                  Image.asset('assets/images/send.png', height: 15, width: 15),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
