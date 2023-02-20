import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/CommonWidgets.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/custom_progress_bar.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  bool provideSelected = false;
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 8),
          child: Text(
            'What are you\nsearching for?',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        const Text('Please select one of two options',
            style: TextStyle(fontSize: 14)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    provideSelected = !provideSelected;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: provideSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Provide Services',
                          style: TextStyle(
                              color: provideSelected
                                  ? Colors.white
                                  : primaryColor),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: provideSelected
                                ? const Color(0xff343734)
                                : const Color(0xfff2f2f2),
                            child: Icon(Icons.shopping_bag_outlined,
                                color: provideSelected
                                    ? Colors.white
                                    : primaryColor)),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    provideSelected = !provideSelected;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          color: !provideSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Provide Services',
                          style: TextStyle(
                              color:
                              !provideSelected ? Colors.white : primaryColor),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: !provideSelected
                                ? const Color(0xff343734)
                                : const Color(0xfff2f2f2),
                            child: Icon(Icons.announcement_outlined,
                                color: !provideSelected
                                    ? Colors.white
                                    : primaryColor)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget newPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Set Password',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Text('Choose a secure password for your account.',
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: TextField(
              obscureText: true,
              obscuringCharacter: '*',
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  icon: const Icon(Icons.lock_outline),
                  labelText: 'New Password'.toUpperCase())),
        ),
        const SizedBox(height: 20),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: TextField(
              obscureText: true,
              obscuringCharacter: '*',
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  icon: const Icon(Icons.lock_outline),
                  labelText: 'Confirm New Password'.toUpperCase())),
        ),
      ],
    );
  }

  Widget personalInfoView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Personal info',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Text('Please fill all the fields',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.person_outline_outlined),
                    labelText: 'Name'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.person_outline_outlined),
                    labelText: 'Last Name'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.email_outlined),
                    labelText: 'Email'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.numbers_outlined),
                    labelText: 'VAT Number'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'dd/mm/yyyy',
                    hintStyle:
                        const TextStyle(fontSize: 18, color: Colors.black12),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.calendar_month_outlined),
                    labelText: 'Birth date'.toUpperCase())),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget paymentMethodView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Payment Method',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Text('Add payment method for your account',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.person_outline_outlined),
                    labelText: 'Card Holder'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: const Icon(Icons.credit_card),
                    labelText: 'Card Number'.toUpperCase())),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'dd/mm',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.black12),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          icon: const Icon(Icons.calendar_today_outlined),
                          labelText: 'Expire Date'.toUpperCase())),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                      style: const TextStyle(fontSize: 18),
                      obscureText: true,
                      obscuringCharacter: '*',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          icon: const Icon(Icons.lock_open_outlined),
                          labelText: 'CVV'.toUpperCase())),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget profilePictureView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Payment Method',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Text('Add payment method for your account',
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        Center(
          child: Container(
            height: 150,
            width: 150,
            child: Stack(
              children: const [
                CircleAvatar(
                    radius: 75,
                    backgroundColor: Color(0xff6DCF82),
                    child: Text(
                      'ST',
                      style: TextStyle(fontSize: 65, color: Colors.white),
                    )),
                Positioned(
                    bottom: 1,
                    right: 2,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.cloud_upload_outlined,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget privacyPolicyView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Text("""What is Lorem Ipsum?\n
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

Why do we use it?\n
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


Where does it come from?\n
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
          """, style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget progressView() {
    return Container(
      height: currentPage > 5 ? 78 : 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          currentPage > 5
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                      Text('Reason'.toUpperCase()),
                      const SizedBox(width: 30),
                      Expanded(
                          child: CustomProgressBar(
                        max: 5,
                        current: currentPage.toDouble(),
                        color: primaryColor,
                      )),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: currentPage == 1 || currentPage > 5
                ? GestureDetector(
                    onTap: () {
                      if (currentPage > 5) {
                      } else {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: primaryColor),
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentPage > 5
                                ? 'Accept'.toUpperCase()
                                : 'Next Step'.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                              currentPage > 5
                                  ? Icons.done
                                  : Icons.arrow_forward,
                              color: Colors.white)
                        ],
                      )),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          },
                          child: SizedBox(
                            height: 60,
                            child: Center(
                                child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.arrow_back,
                                    color: Colors.black),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Previous Step'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: primaryColor),
                            child: Center(
                                child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Next Step'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(Icons.arrow_forward,
                                    color: Colors.white)
                              ],
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
