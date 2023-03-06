import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';

class EditOfferScreen extends StatefulWidget {
  const EditOfferScreen({Key? key}) : super(key: key);

  @override
  State<EditOfferScreen> createState() => _EditOfferScreenState();
}

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
      title: const Text(
        'Edit offer',
        style: TextStyle(
          color: splashColor1,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget bodyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Building restructuring, or even bigger title about what to do',
              style: TextStyle(
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
                      "assets/icons/chat.png",
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Babysitters perform general caregiving duties that ensure children’s needs are met while their parents or guardians are away. Their duties include providing transportation to and from a child’s extracurricular activities, preparing basic meals and keeping the child company with games and other entertainment.",
                        style: TextStyle(
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
              child: const ListTile(
                horizontalTitleGap: 1,
                // leading: SvgPicture.asset("assets/images/coins.svg"),
                title: Text(
                  "€60,00",
                  style: TextStyle(
                    color: black343,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
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
              child: const ListTile(
                horizontalTitleGap: 1,
                title: Text(
                  "Offer price",
                  style: TextStyle(
                    color: black343,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "60",
                  style: TextStyle(
                    color: grey9EA,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // trailing: SvgPicture.asset("assets/images/currency-euro.svg"),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Once an offer is accepted and confirmed, it becomes a binding agreement.",
              style: TextStyle(
                color: black343,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () {},
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
                    "Edit offer".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.edit, color: Colors.white, size: 22)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
