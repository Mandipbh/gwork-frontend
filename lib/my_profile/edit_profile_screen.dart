import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';

import '../colors.dart';
import '../common/common_buttons.dart';
import '../common/common_input_fields.dart';

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
        label = tr('admin.Edit_phone_number');
        description = tr('admin.enter_new_phone_no');
        break;
      case ProfileFieldType.vatNumber:
        label = tr('client.log_in.VAT_number.Edit_VAT_number');
        description = tr('client.log_in.VAT_number.enter_VAR_number');
        break;
      case ProfileFieldType.password:
        label = tr('admin.change_password');
        description = tr('admin.change_current_password');
        break;
      case ProfileFieldType.paymentMethod:
        label = tr('client.log_in.Payment_method.Edit_payment_method');
        description =
            tr('client.log_in.Payment_method.Edit_your_payment_method');
        break;
      case ProfileFieldType.birthdate:
        label = tr('client.log_in.Birth_date.Edit_birth_date');
        description = tr('client.log_in.Birth_date.enter_your_birth_date');
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                        style: Theme.of(context).textTheme.displayLarge),
                  ),
                  Text(description,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 40),
                  widget.type == ProfileFieldType.firstName
                      ? nameTextField(
                          controller: controller,
                          label: tr('admin.First_Name'),
                          asset: 'user_first_name.png')
                      : widget.type == ProfileFieldType.lastName
                          ? nameTextField(
                              controller: controller,
                              label: tr('admin.Last_name'),
                              asset: 'user.png')
                          : widget.type == ProfileFieldType.email
                              ? nameTextField(
                                  label: tr('admin.Email'),
                                  controller: controller,
                                  asset: 'mail.png')
                              : widget.type == ProfileFieldType.phoneNumber
                                  ? nameTextField(
                                      label: tr('admin.phone_number'),
                                      controller: controller,
                                      asset: 'phone.png')
                                  : widget.type == ProfileFieldType.birthdate
                                      ? nameTextField(
                                          label: tr('admin.Birth_Date'),
                                          controller: controller,
                                          asset: 'calendar_birthday.png')
                                      : widget.type ==
                                              ProfileFieldType.vatNumber
                                          ? nameTextField(
                                              label: tr('admin.VAT_Number'),
                                              controller: controller,
                                              asset: 'hash.png')
                                          : widget.type ==
                                                  ProfileFieldType.password
                                              ? Column(
                                                  children: [
                                                    passwordTextField(
                                                        label: tr(
                                                            'admin.Current_Password'),
                                                        controller:
                                                            TextEditingController()),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    passwordTextField(
                                                        label: tr(
                                                            'admin.New_Password'),
                                                        controller:
                                                            TextEditingController()),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    passwordTextField(
                                                        label: tr(
                                                            'admin.Confirm_New_PAssword'),
                                                        controller:
                                                            TextEditingController()),
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
                                                                'user_first_name.png'),
                                                        const SizedBox(
                                                            height: 20),
                                                        Container(
                                                          height: 60,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                          child: TextField(
                                                              style:
                                                                  const TextStyle(
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
                                                                  icon: Image.asset(
                                                                      'assets/icons/credit_card_shield.png',
                                                                      height:
                                                                          24,
                                                                      width:
                                                                          24),
                                                                  hintText:
                                                                      '0000 0000 0000 0000',
                                                                  labelText: tr(
                                                                          'client.log_in.sign_up.Card_number')
                                                                      .toUpperCase())),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: 60,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16)),
                                                                child: TextField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .emailAddress,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                            'dd/mm',
                                                                        hintStyle: const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color: Colors
                                                                                .black12),
                                                                        icon: Image.asset(
                                                                            'assets/icons/calendar_expiry_date.png',
                                                                            height:
                                                                                24,
                                                                            width:
                                                                                24),
                                                                        labelText:
                                                                            tr('client.log_in.sign_up.Expire_date').toUpperCase())),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 20),
                                                            Expanded(
                                                              child: Container(
                                                                height: 60,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16)),
                                                                child: TextField(
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                    obscureText:
                                                                        true,
                                                                    obscuringCharacter:
                                                                        '*',
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly
                                                                    ],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        floatingLabelBehavior: FloatingLabelBehavior
                                                                            .always,
                                                                        icon: Image.asset(
                                                                            'assets/icons/lock_unlocked.png',
                                                                            height:
                                                                                24,
                                                                            width:
                                                                                24),
                                                                        hintText:
                                                                            '***',
                                                                        labelText:
                                                                            tr('client.log_in.sign_up.CVV').toUpperCase())),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                      ],
                                                    )
                                                  : Container(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: submitButton(
                  onButtonTap: () {},
                  context: context,
                  backgroundColor: primaryColor,
                  buttonName: widget.type == ProfileFieldType.password
                      ? 'Set new password'
                      : widget.type == ProfileFieldType.paymentMethod
                          ? 'Update payment info'
                          : 'Confirm',
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
      ),
    );
  }
}
