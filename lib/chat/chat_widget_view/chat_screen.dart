import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/chat/chat_widget_view/edit_offer_screen.dart';
import 'package:g_worker_app/chat/provider/chat_provider.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_widgets.dart';
import 'package:g_worker_app/jobs/model/get_client_job_applications_model.dart';
import 'package:g_worker_app/jobs/provider/get_client_job_list_provider.dart';
import 'package:g_worker_app/jobs/provider/get_professional_job_list_provider.dart';
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
    this.state,
    this.acceptedBudget,
    this.description,
  }) : super(key: key);

  final String jobId;
  final String userId;
  final String userName;
  final String userImage;
  final String jobCategory;
  final String? state;
  final int? acceptedBudget;
  final String? description;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final TextEditingController messageController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  bool isFromMessage = false;
  String? state;
  bool accept = true;

  @override
  void initState() {
    state = widget.state;
    context
        .read<ChatProvider>()
        .connectAndListen(context, widget.jobId, widget.userId);
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
          children: [
            topView(),
            const SizedBox(height: 10),
            Expanded(child: messageView()),
            bottomView()
          ],
        ),
      ),
    );
  }

  Widget topView() {
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
      child: Consumer<GetProfessionalJobListProvider>(
        builder: (context, getProfessionalJobListProvider, child) {
          return Column(
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
                        context.read<ChatProvider>().disconnectSocket();
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                          color: splashColor1, size: 20),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.userName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: splashColor1,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            tr('client.job_category.${widget.jobCategory.toLowerCase()}'),
                            style: const TextStyle(
                              color: black343,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
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
                        Text(
                          // '€ ${NumberFormat('#.00').format(
                          //   double.parse(getProfessionalJobListProvider
                          //       .detailsModel!.jobDetails!.acceptedBudget!),
                          // )}',
                          widget.acceptedBudget.toString(),
                          style: const TextStyle(
                            color: splashColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Provider.of<SignUpProvider>(context).userType ==
                                UserType.client &&
                            state == JobStatus.published
                        ? Consumer<GetClientJobListProvider>(
                            builder: (context, getClientJobProvider, child) {
                              return accept
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        showJobApproveConfirmation(
                                            context, widget.jobId);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tr('client.chat.Accept')
                                                    .toUpperCase(),
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
                                  : Icon(Icons.check,
                                      color: primaryColor, size: 30);
                            },
                          )
                        : const Icon(Icons.check,
                            color: primaryColor, size: 30),

                    // Consumer2(
                    //   builder:
                    //       <GetClientJobListProvider, SignUpProvider>(context,
                    //           getClientJobProvider, signUpProvider, child) {
                    //     return signUpProvider.userType == UserType.client &&
                    //             state == JobStatus.published
                    //         ? GestureDetector(
                    //             behavior: HitTestBehavior.opaque,
                    //             onTap: () {
                    //               showJobApproveConfirmation(
                    //                   context, widget.jobId);
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(8),
                    //                 color: primaryColor,
                    //               ),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 10, vertical: 12),
                    //                 child: Row(
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   children: [
                    //                     Text(
                    //                       tr('client.chat.Accept')
                    //                           .toUpperCase(),
                    //                       style: const TextStyle(
                    //                           color: white,
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.w700,
                    //                           fontFamily: "Satoshi"),
                    //                     ),
                    //                     const SizedBox(width: 8),
                    //                     const Icon(Icons.check,
                    //                         color: white, size: 30),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //         : const Icon(Icons.check,
                    //             color: primaryColor, size: 30);
                    //   },
                    // ),

                    // : GestureDetector(
                    //     behavior: HitTestBehavior.opaque,
                    //     onTap: () {
                    //       Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => EditOfferScreen(
                    //                     budget: widget.budget,
                    //                     description: widget.description,
                    //                     jobId: widget.jobId,
                    //                   )),
                    //           (Route<dynamic> route) => true);
                    //       log("ChatSJobId :: ${widget.jobId}");
                    //     },
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text(
                    //           tr('client.chat.Edit').toUpperCase(),
                    //           style: const TextStyle(
                    //             color: splashColor1,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //         const SizedBox(width: 8),
                    //         Image.asset('assets/icons/edit_profile.png',
                    //             height: 24, width: 24),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
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
              : ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                  itemCount: provider.getChatData().length,
                  itemBuilder: (context, index) {
                    isFromMessage =
                        widget.userId == provider.getChatData()[index].toUserId;
                    Widget timeLineWidget = const SizedBox();
                    if (index > 0) {
                      DateTime previousCreatedAtDate = DateTime.parse(
                              provider.getChatData()[index - 1].createdAt!)
                          .toLocal();
                      DateTime createdAtDate = DateTime.parse(
                              provider.getChatData()[index].createdAt!)
                          .toLocal();
                      DateTime now = DateTime.now();
                      if (previousCreatedAtDate.day != createdAtDate.day ||
                          previousCreatedAtDate.month != createdAtDate.month ||
                          previousCreatedAtDate.year != createdAtDate.year) {
                        timeLineWidget = createdAtDate.year == now.year &&
                                createdAtDate.month == now.month &&
                                createdAtDate.day == now.day
                            ? Row(
                                children: const [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Today'),
                                  ),
                                  Expanded(child: Divider())
                                ],
                              )
                            : Row(
                                children: [
                                  const Expanded(child: Divider()),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(DateFormat('dd MMM')
                                        .format(createdAtDate)),
                                  ),
                                  const Expanded(child: Divider())
                                ],
                              );
                      }
                    } else if (index == 0) {
                      DateTime createdAtDate = DateTime.parse(
                              provider.getChatData()[index].createdAt!)
                          .toLocal();
                      DateTime now = DateTime.now();
                      timeLineWidget = createdAtDate.year == now.year &&
                              createdAtDate.month == now.month &&
                              createdAtDate.day == now.day
                          ? Row(
                              children: const [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Today'),
                                ),
                                Expanded(child: Divider())
                              ],
                            )
                          : Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(DateFormat('dd MMM')
                                      .format(createdAtDate)),
                                ),
                                const Expanded(child: Divider())
                              ],
                            );
                    }
                    return Column(
                      children: [
                        timeLineWidget,
                        Align(
                          alignment: !isFromMessage
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Container(
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
                                    color:
                                        !isFromMessage ? white : primaryColor,
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
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          DateFormat('hh:mm').format(
                                              DateTime.parse(provider
                                                      .getChatData()[index]
                                                      .createdAt!)
                                                  .toLocal()),
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
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                );
    });
  }

  // Widget clientChatApplyView() {
  //   return Provider.of<SignUpProvider>(context).userType == UserType.client
  //       ? widget.state == JobStatus.published
  //           ? Consumer<GetClientJobListProvider>(
  //               builder: (context, getClientJobProvider, child) {
  //                 return GestureDetector(
  //                   behavior: HitTestBehavior.opaque,
  //                   onTap: () {
  //                     showJobApproveConfirmation(context, widget.jobId);
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                       color: primaryColor,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 10, vertical: 12),
  //                       child: Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Text(
  //                             tr('client.chat.Accept').toUpperCase(),
  //                             style: const TextStyle(
  //                                 color: white,
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w700,
  //                                 fontFamily: "Satoshi"),
  //                           ),
  //                           const SizedBox(width: 8),
  //                           const Icon(Icons.check, color: white, size: 30),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             )
  //           : const Icon(Icons.check, color: primaryColor, size: 30)
  //       : const Icon(Icons.check, color: primaryColor, size: 30);
  // }
  //
  // Widget profChatEditOfferView() {
  //   return Provider.of<SignUpProvider>(context).userType ==
  //           UserType.professional
  //       ? widget.state == JobStatus.applied
  //           ? GestureDetector(
  //               behavior: HitTestBehavior.opaque,
  //               onTap: () {
  //                 Navigator.pushAndRemoveUntil(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => EditOfferScreen(
  //                               budget: widget.budget,
  //                               description: widget.description,
  //                               jobId: widget.jobId,
  //                             )),
  //                     (Route<dynamic> route) => true);
  //                 log("ChatSJobId :: ${widget.jobId}");
  //               },
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     tr('client.chat.Edit').toUpperCase(),
  //                     style: const TextStyle(
  //                       color: splashColor1,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 8),
  //                   Image.asset('assets/icons/edit_profile.png',
  //                       height: 24, width: 24),
  //                 ],
  //               ),
  //             )
  //           : const Icon(Icons.check, color: primaryColor, size: 30)
  //       : const Icon(Icons.check, color: primaryColor, size: 30);
  // }

  Widget noMessageView() {
    return Center(
      child: SingleChildScrollView(
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
                  if (messageController.text.isNotEmpty) {
                    Provider.of<ChatProvider>(context, listen: false)
                        .sendMessage(messageController.text);
                    scrollToBottom(scrollController);
                    messageController.text = '';
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
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

  void showJobApproveConfirmation(BuildContext context, String jobId) {
    bool isJobUpdateLoading = false;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 28),
            contentPadding: const EdgeInsets.all(12),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: StatefulBuilder(builder: (context, newState) {
              return confirmationDialogueView(
                  context: context,
                  titleIconColor: primaryColor,
                  mainIcon: 'check_circle.png',
                  title: tr('client.accept_worker_chat.are_you_sure_accept'),
                  description:
                      tr('client.accept_worker_chat.status_cant_be_changed'),
                  button1Name: tr('client.accept_worker_chat.accept_worker'),
                  button2Name: tr('client.accept_worker_chat.cancel'),
                  showLoader: isJobUpdateLoading,
                  onButton1Click: () {
                    var getClientJobProvider =
                        context.read<GetClientJobListProvider>();
                    newState(() {
                      isJobUpdateLoading = true;
                    });
                    getClientJobProvider
                        .acceptJob(widget.jobId, widget.userId, context)
                        .then((acceptJobSuccess) {
                      if (acceptJobSuccess!.success!) {
                        getClientJobProvider.setIsAccepted(true);
                        getClientJobProvider.getDetailsClient(
                            context, widget.jobId);
                        getClientJobProvider.getClientJobList(
                            getClientJobProvider.getSelectedFilter(),
                            getClientJobProvider.getSelectedJobType(),
                            context);
                        Navigator.of(context).pop();
                      }
                      newState(() {
                        accept = false;
                        isJobUpdateLoading = false;
                      });
                    });
                  },
                  onButton2Click: () {
                    Navigator.pop(context);
                  },
                  button2Icon: 'go_backward.png',
                  button1Icon: 'check_circle.png');
            })));
  }
}

void scrollToBottom(ScrollController scrollController) {
  if (scrollController.hasClients) {
    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
