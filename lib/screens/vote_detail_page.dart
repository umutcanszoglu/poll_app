import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:poll/screens/poll_page.dart';

import '../models/poll.dart';

class VoteDetail extends StatelessWidget {
  const VoteDetail({super.key, required this.selectedPoll});
  final PollModel selectedPoll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff787878),
      body: ListView(
        padding: const EdgeInsets.all(60),
        children: [
          const CustomText(text: "Title"),
          const SizedBox(height: 60),
          PieChart(dataMap: selectedPoll.toVoteMap()),
          CustomElevatedButton(
            onTap: () {
              Get.to(const PollPage());
            },
          )
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xffFFFFFF),
        fontSize: 40,
        fontFamily: "Verdana",
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            backgroundColor: const Color.fromARGB(154, 203, 207, 191)),
        child: const Text(
          "Go Back",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
