import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SelectServiceView extends StatefulWidget {
  const SelectServiceView({super.key});

  @override
  State<SelectServiceView> createState() => _SelectServiceViewState();
}

class _SelectServiceViewState extends State<SelectServiceView> {
  bool provideSelected = false;
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          child: Text(
            tr('client.log_in.sign_up.searching_for'),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Text(tr('client.log_in.sign_up.select_options'),
            style: Theme.of(context).textTheme.bodyText2),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<SignUpProvider>(context, listen: false)
                          .updateUserType(1);
                      setState(() {
                        provideSelected = !provideSelected;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color:
                                  provideSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              tr('client.log_in.sign_up.Provide_services'),
                              style: Theme.of(context).textTheme.caption!.apply(
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
                              child: Image.asset('assets/icons/briefcase.png',
                                  height: 30,
                                  width: 30,
                                  color: provideSelected
                                      ? Colors.white
                                      : primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<SignUpProvider>(context, listen: false)
                          .updateUserType(0);
                      setState(() {
                        provideSelected = !provideSelected;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: !provideSelected
                                  ? primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                                tr('client.log_in.sign_up.Require_services'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .apply(
                                        color: !provideSelected
                                            ? Colors.white
                                            : primaryColor)),
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: !provideSelected
                                  ? const Color(0xff343734)
                                  : const Color(0xfff2f2f2),
                              child: Image.asset(
                                  'assets/icons/announcement.png',
                                  height: 30,
                                  width: 30,
                                  color: !provideSelected
                                      ? Colors.white
                                      : primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
