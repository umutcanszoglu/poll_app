import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll/controllers/home_controller.dart';
import 'package:poll/models/poll.dart';
import 'package:poll/screens/vote_detail_page.dart';

class VotePage extends StatelessWidget {
  const VotePage({super.key, required this.selectedPoll});
  final PollModel selectedPoll;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: const Color(0xff787878),
      body: ListView(padding: const EdgeInsets.all(50.0), children: [
        const CustomText(text: "Vote This Poll"),
        const SizedBox(height: 60),
        CustomText(text: selectedPoll.title),
        const SizedBox(height: 60),
        CustomText(text: selectedPoll.description),
        const SizedBox(height: 40),
        const Divider(
          thickness: 2,
          color: Color(0xffFFFFFF),
        ),
        ...selectedPoll.options.asMap().entries.map((kv) => CustomElevatedButton(
              option: kv.value,
              onTap: () async {
                final newPoll = await controller.vote(selectedPoll.id, kv.key);
                Get.to(VoteDetail(selectedPoll: newPoll));
              },
            ))
      ]),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.option,
    required this.onTap,
  });
  final String option;
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
            backgroundColor: const Color.fromARGB(154, 187, 255, 0)),
        child: Text(
          option,
          textAlign: TextAlign.center,
        ),
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
