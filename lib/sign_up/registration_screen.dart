import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/common/common_loader.dart';

import 'package:g_worker_app/home_page/view/home_screen.dart';
import 'package:g_worker_app/main.dart';
import 'package:g_worker_app/pending_reject_application_screen/pending_application_screen.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/payment_info_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/personal_info_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/privacy_policy_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/profile_picture_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/select_service_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/set_password_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/document_provider/document_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/upload_document_view.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../common/common_buttons.dart';
import '../common/common_widgets.dart';
import '../custom_progress_bar.dart';
import '../sign_in/view/sign_in_sign_up_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool provideSelected = false;
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        askForExit(
          context: context,
          onBackPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignInSignUpScreen()),
                (Route<dynamic> route) => false);
          },
          title: tr('client.confirmation_panel.want_to_stop_registration'),
          description:
              tr('client.confirmation_panel.saved_data_will_be_deleted'),
          backButtonName: tr('admin.exit_dialogue.go_back'),
        );
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        tr('client.log_in.sign_up.Onboarding'),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          askForExit(
                            context: context,
                            onBackPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInSignUpScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            title: tr(
                                'client.confirmation_panel.want_to_stop_registration'),
                            description: tr(
                                'client.confirmation_panel.saved_data_will_be_deleted'),
                            backButtonName: tr('admin.exit_dialogue.go_back'),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              backgroundColor: const Color(0xfff2f2f2),
              elevation: 1,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: mainView(),
          )),
    );
  }

  Widget mainView() {
    final List<Widget> pagesClient = <Widget>[
      const SelectServiceView(),
      const SetPasswordView(),
      const PersonalInfoView(),
      const PaymentInfoView(),
      const ProfilePictureView(),
      const PrivacyPolicyView()
    ];
    final List<Widget> pagesProf = <Widget>[
      const SelectServiceView(),
      const SetPasswordView(),
      const PersonalInfoView(),
      const PaymentInfoView(),
      const UploadDocumentView(),
      const ProfilePictureView(),
      const PrivacyPolicyView()
    ];
    return Column(
      children: [
        Expanded(
          child: PageView(
              allowImplicitScrolling: false,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (int pageIndex) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    log("pageIndex ==> ${pagesClient.length}");
                    log("pageIndex ==> $pageIndex");
                    currentPage = pageIndex + 1;
                    log(currentPage.toString());
                  });
                });
              },
              children: Provider.of<SignUpProvider>(context, listen: false)
                          .userType ==
                      0
                  ? pagesClient
                  : pagesProf),
        ),
        progressView()
      ],
    );
  }

  Widget progressView() {
    String? labelCli;

    if (Provider.of<SignUpProvider>(context, listen: false).userType == 0) {
      labelCli = currentPage == 1
          ? tr('client.log_in.sign_up.Reason')
          : currentPage == 2
              ? tr('client.log_in.sign_up.Password')
              : currentPage == 3
                  ? tr('client.log_in.sign_up.personal_info')
                  : currentPage == 4
                      ? tr('client.log_in.sign_up.Paymen_method')
                      : currentPage == 5
                          ? tr('client.log_in.sign_up.Profile_picture')
                          : '';
    }
    String? labelPro;
    if (Provider.of<SignUpProvider>(context, listen: false).userType == 1) {
      labelPro = currentPage == 1
          ? tr('client.log_in.sign_up.Reason')
          : currentPage == 2
              ? tr('client.log_in.sign_up.Password')
              : currentPage == 3
                  ? tr('client.log_in.sign_up.personal_info')
                  : currentPage == 4
                      ? tr('client.log_in.sign_up.Paymen_method')
                      : currentPage == 5
                          ? tr('client.log_in.sign_up.Upload_Docs')
                          : currentPage == 6
                              ? tr('client.log_in.sign_up.Profile_picture')
                              : '';
    }

    return Provider.of<SignUpProvider>(context, listen: false).userType == 0
        ? Container(
            height: currentPage > 5 ? 78 : 135,
            // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Column(
              children: [
                currentPage > 5
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: const Color(0xfff2f2f2),
                              child: Text(
                                currentPage.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(labelCli!.toUpperCase()),
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
                Consumer<SignUpProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return previousAndNextButtons(
                        context: context,
                        onPreviousTap: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        onNextTap: () {
                          if (currentPage == 1) {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          }
                          if (currentPage == 2) {
                            // if(value.passwordController.text.isEmpty || value.confirmPasswordController.text.isEmpty)
                            //   {}
                            // else if(value.passwordController.text.compareTo(value.confirmPasswordController.text)){
                            //
                            // }
                            bool isValid = value.setPassword(
                                value.passwordController.text.toString(),
                                value.confirmPasswordController.text.toString(),
                                context);
                            if (isValid) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          if (currentPage == 3) {
                            bool isValid = value.setPersonalInfo(
                                value.nameController.text.toString(),
                                value.lastNameController.text.toString(),
                                value.emailController.text.toString(),
                                value.textCodeController.text.toString(),
                                value.birthDateController.text.toString(),
                                context);
                            if (isValid) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          if (currentPage == 4) {
                            bool isValid = value.setPaymentMethod(
                                value.cardHolderController.text.toString(),
                                value.cardNumberController.text.toString(),
                                value.expireDateController.text.toString(),
                                value.cvvController.text.toString(),
                                context);
                            if (isValid) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          if (currentPage == 5) {
                            var pImage = context.read<ProfilePicProvider>();
                            if (pImage.imagePath == "") {
                              ErrorLoader(
                                  context, "Please select profile picture");
                            } else {
                              value.setIsLogging(true);
                              print(currentPage);
                              ApiClient()
                                  .userRegister(context,
                                      firstName: value.name,
                                      lastName: value.lastName,
                                      email: value.email,
                                      phoneNumber: value.phoneController.text,
                                      password: value.password,
                                      vatNumber: value.textCode,
                                      birthDate: value.birthDate,
                                      role: '0',
                                      cardHolderName: value.cardHolder,
                                      cardNumber: value.cardNumber,
                                      cardExpiry: value.expireDate,
                                      image: Provider.of<ProfilePicProvider>(
                                              context,
                                              listen: false)
                                          .imagePath,
                                      cardCvv: value.cvv)
                                  .then((v) {
                                value.setIsLogging(false);
                                currentPage = currentPage + 1;
                                if (currentPage > 5) {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                }
                              });
                            }
                          }

                          if (currentPage == 6) {
                            value.clearSignUpProvider(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInSignUpScreen()));
                          }
                        },
                        nextButtonName: currentPage > 5
                            ? tr('client.privacy_policy.Accept')
                            : currentPage <= 4
                                ? tr(
                                    'Professional.logIn.onBoardingSetPassword.Next')
                                : tr(
                                    'Professional.logIn.onBoardingSetPassword.Finish'),
                        nextButtonIcon: Icon(
                            currentPage > 5 ? Icons.done : Icons.arrow_forward,
                            color: Colors.white),
                        showPrevious: currentPage != 1 && currentPage <= 5);
                  },
                ),
              ],
            ),
          )
        : Container(
            height: currentPage > 6 ? 78 : 135,
            // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Column(
              children: [
                currentPage > 6
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: const Color(0xfff2f2f2),
                              child: Text(
                                currentPage.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(labelPro!.toUpperCase()),
                            const SizedBox(width: 30),
                            Expanded(
                                child: CustomProgressBar(
                              max: 6,
                              current: currentPage.toDouble(),
                              color: primaryColor,
                              bgColor: whiteF2F,
                            )),
                          ],
                        ),
                      ),
                Consumer<SignUpProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return previousAndNextButtons(
                        context: context,
                        onPreviousTap: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        onNextTap: () {
                          if (currentPage == 1) {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          }
                          if (currentPage == 2) {
                            bool isValid = value.setPassword(
                                value.passwordController.text.toString(),
                                value.confirmPasswordController.text.toString(),
                                context);
                            if (isValid) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          if (currentPage == 3) {
                            bool isValid = value.setPersonalInfo(
                                value.nameController.text.toString(),
                                value.lastNameController.text.toString(),
                                value.emailController.text.toString(),
                                value.textCodeController.text.toString(),
                                value.birthDateController.text.toString(),
                                context);
                            if (isValid) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          if (currentPage == 4) {
                            bool isValid = value.setPaymentMethod(
                                value.cardHolderController.text.toString(),
                                value.cardNumberController.text.toString(),
                                value.expireDateController.text.toString(),
                                value.cvvController.text.toString(),
                                context);
                            if (isValid) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          if (currentPage == 5) {
                            Provider.of<DocumentPicProvider>(context,
                                    listen: false)
                                .docList;
                            print(
                                "##${Provider.of<DocumentPicProvider>(context, listen: false).docList}");

                            if (Provider.of<DocumentPicProvider>(context,
                                        listen: false)
                                    .docList
                                    .length <=
                                1) {
                              print(Provider.of<DocumentPicProvider>(context,
                                      listen: false)
                                  .docList);
                              ErrorLoader(
                                  context, "Please select atleast 1 document");
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }
                          log(currentPage.toString());
                          if (currentPage == 6) {
                            var pImage = context.read<ProfilePicProvider>();
                            if (pImage.imagePath == "") {
                              ErrorLoader(
                                  context, "Please select profile picture");
                            } else {
                              value.setIsLogging(true);
                              ApiClient()
                                  .userRegister(context,
                                      firstName: value.name,
                                      lastName: value.lastName,
                                      email: value.email,
                                      phoneNumber: value.phoneController.text,
                                      password: value.password,
                                      vatNumber: value.textCode,
                                      birthDate: value.birthDate,
                                      role: '1',
                                      cardHolderName: value.cardHolder,
                                      cardNumber: value.cardNumber,
                                      cardExpiry: value.expireDate,
                                      image: Provider.of<ProfilePicProvider>(
                                              context,
                                              listen: false)
                                          .imagePath,
                                      cardCvv: value.cvv)
                                  .then((v) {
                                value.setIsLogging(false);

                                currentPage = currentPage + 1;
                                if (currentPage > 6) {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                }
                              });
                            }
                          }

                          if (currentPage == 7) {
                            value.clearSignUpProvider(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PendingApplicationScreen()));
                          }
                        },
                        nextButtonName: currentPage > 6
                            ? tr('client.privacy_policy.Accept')
                            : currentPage <= 5
                                ? tr(
                                    'Professional.logIn.onBoardingSetPassword.Next')
                                : tr(
                                    'Professional.logIn.onBoardingSetPassword.Finish'),
                        nextButtonIcon: Icon(
                            currentPage > 6 ? Icons.done : Icons.arrow_forward,
                            color: Colors.white),
                        showPrevious: currentPage != 1 && currentPage <= 6);
                  },
                ),
              ],
            ),
          );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:g_worker_app/pending_reject_application_screen/pending_application_screen.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/payment_info_view.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/personal_info_view.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/privacy_policy_view.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/profile_picture_view.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/select_service_view.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/set_password_view.dart';
// import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/upload_document_view.dart';
//
// import '../colors.dart';
// import '../common/common_buttons.dart';
// import '../common/common_widgets.dart';
// import '../custom_progress_bar.dart';
// import '../sign_in/view/sign_in_sign_up_screen.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});
//
//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   bool provideSelected = false;
//   PageController controller = PageController();
//   int currentPage = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         askForExit(
//           context: context,
//           onBackPressed: () {
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const SignInSignUpScreen()),
//                 (Route<dynamic> route) => false);
//           },
//           title: tr('client.confirmation_panel.want_to_stop_registration'),
//           description:
//               tr('client.confirmation_panel.saved_data_will_be_deleted'),
//           backButtonName: tr('admin.exit_dialogue.go_back'),
//         );
//         return false;
//       },
//       child: Scaffold(
//           backgroundColor: const Color(0xfff2f2f2),
//           appBar: PreferredSize(
//             preferredSize:
//                 Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
//             child: AppBar(
//               centerTitle: true,
//               automaticallyImplyLeading: false,
//               flexibleSpace: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(
//                         width: 30,
//                       ),
//                       Text(
//                         tr('client.log_in.sign_up.Onboarding'),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.close),
//                         onPressed: () {
//                           askForExit(
//                             context: context,
//                             onBackPressed: () {
//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const SignInSignUpScreen()),
//                                   (Route<dynamic> route) => false);
//                             },
//                             title: tr(
//                                 'client.confirmation_panel.want_to_stop_registration'),
//                             description: tr(
//                                 'client.confirmation_panel.saved_data_will_be_deleted'),
//                             backButtonName: tr('admin.exit_dialogue.go_back'),
//                           );
//                         },
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               backgroundColor: const Color(0xfff2f2f2),
//               elevation: 1,
//             ),
//           ),
//           body: Container(
//             padding: const EdgeInsets.all(20),
//             child: mainView(),
//           )),
//     );
//   }
//
//   Widget mainView() {
//     final List<Widget> pages = <Widget>[
//       const SelectServiceView(),
//       const SetPasswordView(),
//       const PersonalInfoView(),
//       const PaymentInfoView(),
//       const UploadDocumentView(),
//       const ProfilePictureView(),
//       const PrivacyPolicyView()
//     ];
//     return Column(
//       children: [
//         Expanded(
//           child: PageView(
//             allowImplicitScrolling: false,
//             physics: const NeverScrollableScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             controller: controller,
//             onPageChanged: (int pageIndex) {
//               WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                 setState(() {
//                   currentPage = pageIndex + 1;
//                 });
//               });
//             },
//             children: pages,
//           ),
//         ),
//         progressView()
//       ],
//     );
//   }
//
//   Widget progressView() {
//     String label = currentPage == 1
//         ? tr('client.log_in.sign_up.Reason')
//         : currentPage == 2
//             ? tr('client.log_in.sign_up.Password')
//             : currentPage == 3
//                 ? tr('client.log_in.sign_up.personal_info')
//                 : currentPage == 4
//                     ? tr('client.log_in.sign_up.Paymen_method')
//                     : currentPage == 5
//                         ? tr('client.log_in.sign_up.Upload_Docs')
//                         : currentPage == 6
//                             ? tr('client.log_in.sign_up.Profile_picture')
//                             : '';
//     return Container(
//       height: currentPage > 6 ? 78 : 135,
//       // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12), color: Colors.white),
//       child: Column(
//         children: [
//           currentPage > 6
//               ? Container()
//               : Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 15,
//                         backgroundColor: const Color(0xfff2f2f2),
//                         child: Text(
//                           currentPage.toString().padLeft(2, '0'),
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 12),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Text(label.toUpperCase()),
//                       const SizedBox(width: 30),
//                       Expanded(
//                           child: CustomProgressBar(
//                         max: 6,
//                         current: currentPage.toDouble(),
//                         color: primaryColor,
//                         bgColor: whiteF2F,
//                       )),
//                     ],
//                   ),
//                 ),
//           previousAndNextButtons(
//               context: context,
//               onPreviousTap: () {
//                 controller.previousPage(
//                     duration: const Duration(milliseconds: 200),
//                     curve: Curves.easeIn);
//               },
//               onNextTap: () {
//                 if (currentPage > 6) {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const PendingApplicationScreen()),
//                   );
//                 } else {
//                   controller.nextPage(
//                       duration: const Duration(milliseconds: 200),
//                       curve: Curves.easeIn);
//                 }
//               },
//               nextButtonName: currentPage > 6
//                   ? tr('client.privacy_policy.Accept')
//                   : currentPage <= 5
//                       ? tr('Professional.logIn.onBoardingSetPassword.Next')
//                       : tr('Professional.logIn.onBoardingSetPassword.Finish'),
//               nextButtonIcon: Icon(
//                   currentPage > 6 ? Icons.done : Icons.arrow_forward,
//                   color: Colors.white),
//               showPrevious: currentPage != 1 && currentPage <= 6),
//         ],
//       ),
//     );
//   }
// }
