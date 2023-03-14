import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll/controllers/home_controller.dart';
import 'package:poll/screens/home_page.dart';
import 'package:poll/screens/vote_detail_page.dart';
import 'package:poll/screens/vote_page.dart';

class PollPage extends StatelessWidget {
  const PollPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xff787878),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 80,
                  color: const Color.fromARGB(255, 178, 197, 9),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Go Poll",
                      style: TextStyle(
                        color: Color(0xff1E1E1E),
                        fontSize: 40,
                        fontFamily: "Verdana",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(
                            children: controller.polls
                                .map((e) => PollContainer(
                                      title: e.title,
                                      onTap: () {
                                        if (e.voted == false) {
                                          Get.to(VotePage(selectedPoll: e));
                                        } else {
                                          Get.to(VoteDetail(selectedPoll: e));
                                        }
                                      },
                                      isVoted: e.voted,
                                    ))
                                .toList(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 51, 51, 51),
          onPressed: () {
            Get.to(const PollHomePage());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PollContainer extends StatelessWidget {
  const PollContainer({
    super.key,
    required this.title,
    required this.onTap,
    required this.isVoted,
  });
  final String title;
  final Function() onTap;
  final bool isVoted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xff1E1E1E),
            border: Border.all(color: const Color(0xff787878)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListTile(
              minLeadingWidth: 0,
              title: Text(
                title,
                style: const TextStyle(color: Color(0xffCECECE)),
              ),
              trailing: isVoted
                  ? const Icon(
                      Icons.check_circle_outline,
                      color: Color.fromARGB(209, 21, 255, 0),
                      size: 30,
                    )
                  : const Icon(
                      Icons.cancel_outlined,
                      color: Color.fromARGB(217, 255, 0, 0),
                      size: 30,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
