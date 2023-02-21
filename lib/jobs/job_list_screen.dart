import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/custom_progress_bar.dart';

import '../Constants.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  int selectedFilter = 1;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          appBarView(),
          Padding(
            padding: EdgeInsets.only(top: !isSelected ? 300 : 360),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: whiteF2F,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: !isSelected ? myJobsView() : searchJobsView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarView() {
    return Container(
      color: const Color(0xff1B1F1C),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jobs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.person, color: Colors.grey, size: 25),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.end,
            spacing: 20,
            children: [
              FilterChip(
                label: const Text(
                  'All Jobs',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.all
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.all,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.all;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Applied',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.applied
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.applied,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.applied;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Accepted',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.accepted
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.accepted,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.accepted;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Doing',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.doing
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.doing,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.doing;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Rejected',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.rejected
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.rejected,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.rejected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FilterChip(
                label: const Text(
                  'Completed',
                ),
                labelStyle: TextStyle(
                  color: selectedFilter != JobsFilters.completed
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                selected: selectedFilter == JobsFilters.completed,
                backgroundColor: black343,
                selectedColor: Colors.white,
                showCheckmark: false,
                onSelected: (bool value) {
                  setState(() {
                    selectedFilter = JobsFilters.completed;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteF2F,
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  padding: const EdgeInsets.all(8),
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
                        child: Container(
                            height: 34,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isSelected ? primaryColor : whiteF2F),
                            child: Center(
                                child: Text(
                              'Search Jobs ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .apply(
                                      color:
                                          isSelected ? whiteF2F : primaryColor),
                            ))),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
                        child: Container(
                            height: 34,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: !isSelected ? primaryColor : whiteF2F),
                            child: Center(
                              child: Text('My Jobs ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .apply(
                                          color: !isSelected
                                              ? Colors.white
                                              : primaryColor)),
                            )),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: !isSelected
                      ? Row(
                          children: [
                            Text(
                              'earning limit '.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Expanded(
                              child: CustomProgressBar(
                                max: 5,
                                current: 2,
                                color: primaryColor,
                                bgColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              '2500€/5000€',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          child: const ListTile(
                            horizontalTitleGap: 1,
                            leading: Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Icon(Icons.location_on_outlined,
                                  color: Colors.black, size: 28),
                            ),
                            title: Text(
                              'PROVINCE',
                              style: TextStyle(
                                color: black343,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              'Milano',
                              style: TextStyle(
                                color: splashColor1,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: splashColor1,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget myJobsView() {
    return selectedFilter == JobsFilters.doing ? noMyJobsView() : ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Cleaning'.toUpperCase(),
                          style: const TextStyle(
                            color: black343,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on_outlined,
                            color: Colors.black, size: 22),
                        const SizedBox(width: 3),
                        const Text(
                          'Via Zolo, 11, Milan',
                          style: TextStyle(
                            color: splashColor1,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '2 rooms, max 60\$',
                      style: TextStyle(
                        color: black343,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          height: 30,
                          color: redE45,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          child: const Text(
                            'Rejected',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '06/07/2022 — 12:30',
                          style: TextStyle(
                            color: black343,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.circle, size: 20, color: yellowF4D),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.black, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchJobsView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Babysitting'.toUpperCase(),
                          style: const TextStyle(
                            color: black343,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on_outlined,
                            color: Colors.black, size: 22),
                        const SizedBox(width: 3),
                        const Text(
                          'Help me with my child',
                          style: TextStyle(
                            color: splashColor1,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '2 rooms, max 60\$',
                      style: TextStyle(
                        color: black343,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '06/07/2022 — 12:30',
                      style: TextStyle(
                        color: black343,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.black, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noSearchJobsView() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Image.asset('assets/images/empty_job.png', height: 200),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Center(
                child: Column(
                  children: const [
                    SizedBox(height: 12),
                    Text(
                      'There are no jobs for now',
                      style: TextStyle(
                        color: splashColor1,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Check it bit later or set another filters',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: black343,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget noMyJobsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_job.png',scale: 1.5,),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: const [
              Text("You didn't took any job",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text("Search for a job",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
