import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/my_profile/provider/my_profile_provider.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../common/common_buttons.dart';
import '../../common/common_input_fields.dart';

class EditProfileScreen extends StatefulWidget {
  int type;
  String value;

  EditProfileScreen({super.key, required this.type, required this.value});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String label = '';
  String description = '';
  var controller = TextEditingController();

  @override
  void initState() {
    print(widget.value);
    controller.text = widget.value;
    switch (widget.type) {
      case ProfileFieldType.firstName:
        label = tr('admin.Edit_name');
        description = tr('admin.enter_first_name');
        break;
      case ProfileFieldType.lastName:
        label = tr('admin.Edit_last_name');
        description = tr('admin.enter_last_name');
        break;
      case ProfileFieldType.email:
        label = tr('admin.Edit_email');
        description = tr('admin.enter_valid_email');
        break;
      case ProfileFieldType.phoneNumber:
        String filteredNumber = controller.text.substring(3);
        controller.text = filteredNumber;
        label = tr('admin.Edit_phone_number');
        description = tr('admin.enter_new_phone_no');
        break;
      case ProfileFieldType.vatNumber:
        label = tr('client.VAT_number.Edit_VAT_number');
        description = tr('client.VAT_number.enter_VAR_number');
        break;
      case ProfileFieldType.password:
        label = tr('admin.change_password');
        description = tr('admin.change_current_password');
        break;
      case ProfileFieldType.paymentMethod:
        label = tr('client.Payment_method.Edit_payment_method');
        description = tr('client.Payment_method.Edit_your_payment_method');
        break;
      case ProfileFieldType.birthdate:
        label = tr('client.Birth_date.Edit_birth_date');
        description = tr('client.Birth_date.enter_your_birth_date');
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<MyProfileProvider>().clearEditProfileProvider();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            label,
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<MyProfileProvider>(
            builder: (buildContext, myProfileProvider, child) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                  widget.type == ProfileFieldType.password
                                      ? 'Change Password'
                                      : '$label',
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                            Text(description,
                                style: Theme.of(context).textTheme.bodyText2),
                            const SizedBox(height: 40),
                            widget.type == ProfileFieldType.firstName
                                ? nameTextField(
                                    controller: controller,
                                    label: tr('admin.First_Name'),
                                    context: context,
                                    asset: 'user_first_name.png')
                                : widget.type == ProfileFieldType.lastName
                                    ? nameTextField(
                                        controller: controller,
                                        label: tr('admin.Last_name'),
                                        context: context,
                                        asset: 'user.png')
                                    : widget.type == ProfileFieldType.email
                                        ? nameTextField(
                                            label: tr('admin.Email'),
                                            context: context,
                                            controller: controller,
                                            asset: 'mail.png')
                                        : widget.type ==
                                                ProfileFieldType.phoneNumber
                                            ? phoneNumberTextField(
                                                controller: controller,
                                                context: context,
                                              )
                                            : widget.type ==
                                                    ProfileFieldType.birthdate
                                                ? birthDateTextField(
                                                    controller, context)
                                                : widget.type ==
                                                        ProfileFieldType
                                                            .vatNumber
                                                    ? vatNumberTextField(
                                                        controller: controller,
                                                        context: context)
                                                    : widget.type ==
                                                            ProfileFieldType
                                                                .password
                                                        ? Column(
                                                            children: [
                                                              passwordTextField(
                                                                  label: tr(
                                                                      'admin.Current_Password'),
                                                                  controller:
                                                                      myProfileProvider
                                                                          .currentPasswordController),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              passwordTextField(
                                                                  label: tr(
                                                                      'admin.New_Password'),
                                                                  controller:
                                                                      myProfileProvider
                                                                          .newPasswordController),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              passwordTextField(
                                                                  label: tr(
                                                                      'admin.Confirm_New_PAssword'),
                                                                  controller:
                                                                      myProfileProvider
                                                                          .confirmNewPasswordController),
                                                            ],
                                                          )
                                                        : widget.type ==
                                                                ProfileFieldType
                                                                    .paymentMethod
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  nameTextField(
                                                                    label: tr(
                                                                        'client.log_in.sign_up.card_holder'),
                                                                    asset:
                                                                        'user_first_name.png',
                                                                    context:
                                                                        context,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Container(
                                                                    height: 60,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16)),
                                                                    child: TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .number,
                                                                        inputFormatters: [
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        decoration: InputDecoration(
                                                                            icon: Image.asset('assets/icons/credit_card_shield.png',
                                                                                height: 24,
                                                                                width: 24),
                                                                            hintText: '0000 0000 0000 0000',
                                                                            labelText: tr('client.log_in.sign_up.Card_number').toUpperCase())),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              60,
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 8),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(16)),
                                                                          child: TextField(
                                                                              keyboardType: TextInputType.number,
                                                                              style: const TextStyle(fontSize: 18),
                                                                              decoration: InputDecoration(border: InputBorder.none, hintText: 'dd/mm', hintStyle: const TextStyle(fontSize: 18, color: Colors.black12), icon: Image.asset('assets/icons/calendar_expiry_date.png', height: 24, width: 24), labelText: tr('client.log_in.sign_up.Expire_date').toUpperCase())),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              60,
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 8),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(16)),
                                                                          child: TextField(
                                                                              style: const TextStyle(
                                                                                  fontSize:
                                                                                      18),
                                                                              obscureText:
                                                                                  true,
                                                                              obscuringCharacter:
                                                                                  '*',
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: InputDecoration(border: InputBorder.none, floatingLabelBehavior: FloatingLabelBehavior.always, icon: Image.asset('assets/icons/lock_unlocked.png', height: 24, width: 24), hintText: '***', labelText: tr('client.log_in.sign_up.CVV').toUpperCase())),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                ],
                                                              )
                                                            : Container(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: submitButton(
                            onButtonTap: () {
                              // controller.text = widget.value;
                              switch (widget.type) {
                                case ProfileFieldType.firstName:
                                  myProfileProvider.updateName(
                                      controller, context);
                                  break;
                                case ProfileFieldType.lastName:
                                  myProfileProvider.updateLastName(
                                      controller, context);
                                  break;
                                case ProfileFieldType.email:
                                  myProfileProvider.updateEmail(
                                      controller, context);
                                  break;
                                case ProfileFieldType.phoneNumber:
                                  myProfileProvider.updatePhone(
                                      controller, context);
                                  break;
                                case ProfileFieldType.birthdate:
                                  myProfileProvider.updateBirthDate(
                                      controller, context);
                                  break;
                                case ProfileFieldType.vatNumber:
                                  myProfileProvider.updateVatNumber(
                                      controller, context);
                                  break;
                                case ProfileFieldType.password:
                                  myProfileProvider.updatePassword(
                                      myProfileProvider
                                          .currentPasswordController.text,
                                      myProfileProvider
                                          .newPasswordController.text,
                                      myProfileProvider
                                          .confirmNewPasswordController.text,
                                      context);
                                  break;
                              }
                            },
                            context: context,
                            backgroundColor: primaryColor,
                            buttonName: widget.type == ProfileFieldType.password
                                ? tr('admin.set_new_password')
                                : widget.type == ProfileFieldType.paymentMethod
                                    ? tr(
                                        'client.Payment_method.Update_payment_info')
                                    : tr('admin.Confirm'),
                            iconAsset: widget.type == ProfileFieldType.password
                                ? 'lock.png'
                                : widget.type == ProfileFieldType.paymentMethod
                                    ? 'credit_card_edit.png'
                                    : 'check.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                      child: Center(
                          child: myProfileProvider.getIsLoading()
                              ? const CircularProgressIndicator()
                              : const SizedBox(
                                  height: 0,
                                )))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
