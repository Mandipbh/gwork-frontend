import 'package:flutter/material.dart';
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
        label = 'name';
        description = 'Please enter your first name.';
        break;
      case ProfileFieldType.lastName:
        label = 'last name';
        description = 'Please enter your last name.';
        break;
      case ProfileFieldType.email:
        label = 'email';
        description = 'Please enter a valid email address.';
        break;
      case ProfileFieldType.vatNumber:
        label = 'VAT number';
        description = 'Please enter your VAT number';
        break;
      case ProfileFieldType.password:
        label = 'password';
        description = 'Change your current password with a new one.';
        break;
      case ProfileFieldType.birthdate:
        label = 'birth date';
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
                            : 'Edit $label',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Text(description,
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 40),
                  widget.type == ProfileFieldType.firstName
                      ? nameTextField(
                          controller: controller,
                          label: label,
                          asset: 'user_first_name.png')
                      : widget.type == ProfileFieldType.lastName
                          ? nameTextField(
                              controller: controller,
                              label: label,
                              asset: 'user.png')
                          : widget.type == ProfileFieldType.email
                              ? nameTextField(
                                  label: label,
                                  controller: controller,
                                  asset: 'mail.png')
                              : widget.type == ProfileFieldType.birthdate
                                  ? nameTextField(
                                      label: label,
                                      controller: controller,
                                      asset: 'calendar_birthday.png')
                                  : widget.type == ProfileFieldType.vatNumber
                                      ? nameTextField(
                                          label: label,
                                          controller: controller,
                                          asset: 'hash.png')
                                      : widget.type == ProfileFieldType.password
                                          ? Column(
                                              children: [
                                                passwordTextField(
                                                    label: 'current password'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                passwordTextField(
                                                  label: 'new password',
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                passwordTextField(
                                                  label: 'confirm new password',
                                                ),
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
                      : 'Confirm',
                  iconAsset: widget.type == ProfileFieldType.password
                      ? 'lock.png'
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
