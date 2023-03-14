import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll/controllers/home_controller.dart';
import 'package:poll/screens/poll_page.dart';

class PollHomePage extends StatelessWidget {
  const PollHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus, //bunu beğendim.
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 41, 41, 41),
          onPressed: () {
            Get.to(const PollPage());
          },
          child: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Color(0xffFFFFFf),
          ),
        ),
        backgroundColor: const Color(0xff787878),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(30.0),
            children: [
              const Text(
                "Create Poll",
                style: TextStyle(
                  color: Color(0xff1E1E1E),
                  fontSize: 40,
                  fontFamily: "Verdana",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                title: "Title",
                controller: controller.titleController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: "Description",
                controller: controller.descriptionController,
              ),
              const SizedBox(height: 30),
              const Text(
                "Options",
                style: TextStyle(
                  color: Color(0xff1E1E1E),
                  fontSize: 30,
                  fontFamily: "Verdana",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.options
                        .asMap()
                        .entries
                        .map((kv) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: CustomTextField(
                                      title: (kv.key + 1).toString(),
                                      controller: kv.value,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => controller.removeOption(kv.key),
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ClipRRect(
                    child: ElevatedButton(
                  onPressed: controller.addOption,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      backgroundColor: const Color.fromARGB(255, 48, 48, 48)),
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                )),
              ),
              ElevatedButton(
                onPressed: () => controller.createPoll(),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    backgroundColor: const Color.fromARGB(255, 48, 48, 48)),
                child: const Text(
                  "Create Poll",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.title, this.controller}) : super(key: key);
  final String title;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xff1E1E1E), fontSize: 19),
      decoration: InputDecoration(
        labelText: title,
        hintText: "enter...",
        hintStyle: const TextStyle(color: Color(0xff1E1E1E), fontSize: 17),
        labelStyle: const TextStyle(color: Color(0xff1E1E1E), fontSize: 17),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0x001e1e1e)),
            borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0x001e1e1e)),
            borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xff1E1E1E)),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
