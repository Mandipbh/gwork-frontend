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
        label = 'Edit name';
        description = 'Please enter your first name.';
        break;
      case ProfileFieldType.lastName:
        label = 'Edit last name';
        description = 'Please enter your last name.';
        break;
      case ProfileFieldType.email:
        label = 'Edit email';
        description = 'Please enter a valid email address.';
        break;
      case ProfileFieldType.phoneNumber:
        label = 'Edit phone number';
        description =
            'Please enter your new phone number and we will send you an OTP code to confirm it.';
        break;
      case ProfileFieldType.vatNumber:
        label = 'Edit VAT number';
        description = 'Please enter your VAT number';
        break;
      case ProfileFieldType.password:
        label = 'Change password';
        description = 'Change your current password with a new one.';
        break;
      case ProfileFieldType.paymentMethod:
        label = 'Edit payment method';
        description = 'Edit your payment method.';
        break;
      case ProfileFieldType.birthdate:
        label = 'Edit birth date';
        description = 'Please enter your birth date.';
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
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Text(description,
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 40),
                  widget.type == ProfileFieldType.firstName
                      ? nameTextField(
                          controller: controller,
                          label: 'Name',
                          asset: 'user_first_name.png')
                      : widget.type == ProfileFieldType.lastName
                          ? nameTextField(
                              controller: controller,
                              label: 'Last name',
                              asset: 'user.png')
                          : widget.type == ProfileFieldType.email
                              ? nameTextField(
                                  label: 'Email',
                                  controller: controller,
                                  asset: 'mail.png')
                              : widget.type == ProfileFieldType.phoneNumber
                                  ? nameTextField(
                                      label: 'phone number',
                                      controller: controller,
                                      asset: 'phone.png')
                                  : widget.type == ProfileFieldType.birthdate
                                      ? nameTextField(
                                          label: 'Birth date',
                                          controller: controller,
                                          asset: 'calendar_birthday.png')
                                      : widget.type ==
                                              ProfileFieldType.vatNumber
                                          ? nameTextField(
                                              label: 'VAT number',
                                              controller: controller,
                                              asset: 'hash.png')
                                          : widget.type ==
                                                  ProfileFieldType.password
                                              ? Column(
                                                  children: [
                                                    passwordTextField(
                                                        label:
                                                            'current password',
                                                        controller:
                                                            TextEditingController()),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    passwordTextField(
                                                        label: 'new password',
                                                        controller:
                                                            TextEditingController()),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    passwordTextField(
                                                        label:
                                                            'confirm new password',
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
                                                            label:
                                                                'card holder',
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
                                                                  labelText:
                                                                      'Card Number'
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
                                                                            'Expire Date'.toUpperCase())),
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
                                                                            'CVV'.toUpperCase())),
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
