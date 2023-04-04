import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/chat/chat_widget_view/edit_offer_screen.dart';
import 'package:g_worker_app/chat/provider/chat_provider.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/jobs/model/get_client_job_applications_model.dart';
import 'package:g_worker_app/jobs/provider/get_client_job_list_provider.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

import '../model/message_model.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key,
    required this.jobId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.jobCategory,
  }) : super(key: key);

  final String jobId;
  final String userId;
  final String userName;
  final String userImage;
  final String jobCategory;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final TextEditingController messageController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  bool isFromMessage = false;

  @override
  void initState() {
    context.read<ChatProvider>().connectAndListen(widget.jobId, widget.userId);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    scrollController.addListener(() {
      if (scrollController.offset == 0) {
        context.read<ChatProvider>().getMoreMessages();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatProvider>().disconnectSocket();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteF2F,
        body: Column(
          children: [topView(), Expanded(child: messageView()), bottomView()],
        ),
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
                          widget.userName,
                          style: const TextStyle(
                            color: splashColor1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.jobCategory,
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
                            color: whiteF2F,
                          ),
                          child: widget.userImage.isNotEmpty
                              ? Image.network(
                                  widget.userImage,
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
                                      '${widget.userName.split(' ')[0][0].toUpperCase()}${widget.userName.split(' ')[1][0].toUpperCase()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                )),
                    ),
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

  Widget messageView() {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return provider.getIsLoading()
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.getChatData().isEmpty
              ? noMessageView()
              : ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  itemCount: provider.getChatData().length,
                  itemBuilder: (context, index) {
                    isFromMessage =
                        widget.userId == provider.getChatData()[index].toUserId;
                    return Column(
                      crossAxisAlignment: !isFromMessage
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: !isFromMessage
                                  ? 0
                                  : MediaQuery.of(context).size.width * 0.1,
                              right: !isFromMessage
                                  ? MediaQuery.of(context).size.width * 0.11
                                  : 0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: !isFromMessage ? white : primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        !isFromMessage ? 24 : 14),
                                    bottomRight: Radius.circular(
                                        !isFromMessage ? 24 : 14),
                                    topLeft: Radius.circular(
                                        !isFromMessage ? 14 : 24),
                                    bottomLeft: Radius.circular(
                                        !isFromMessage ? 14 : 24),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        provider.getChatData()[index].chat!,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            color: !isFromMessage
                                                ? primaryColor
                                                : white,
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        DateFormat('hh:mm').format(
                                            DateTime.parse(provider
                                                    .getChatData()[index]
                                                    .createdAt!)
                                                .toUtc()),
                                        style: const TextStyle(
                                            color: grey9EA,
                                            fontFamily: 'Satoshi',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              !isFromMessage
                                  ? Positioned(
                                      left: -4,
                                      bottom: 0,
                                      child: Image.asset(
                                        "assets/images/whiteChatBg.png",
                                        height: 10,
                                      ),
                                    )
                                  : Positioned(
                                      right: 4,
                                      bottom: 0,
                                      child: Image.asset(
                                        "assets/images/blackChatBg.png",
                                        height: 45,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
    });
  }

  Widget noMessageView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/chat.png", height: 142, width: 142),
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
            controller: messageController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: tr('client.chat.Start_typing'),
              hintStyle: const TextStyle(
                color: grey9EA,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                  Provider.of<ChatProvider>(context, listen: false)
                      .sendMessage(messageController.text);
                  messageController.text = '';
                },
                child: Image.asset('assets/images/send.png',
                    height: 15, width: 15),
              ),
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
