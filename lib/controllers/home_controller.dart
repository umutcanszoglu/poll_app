import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poll/models/poll.dart';
import 'package:poll/models/poll_bind.dart';
import 'package:poll/services/api.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final options = <TextEditingController>[].obs;

  final polls = <PollModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    getPolls();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    for (final e in options) {
      e.dispose();
    }
    super.onClose();
  }

  Future<PollModel> vote(int id, int index) async {
    final newVotes = await Api.patchVote(id, index);
    final idx = polls.indexWhere((e) => e.id == id);
    polls[idx] = polls[idx].copyWith(voted: true, votes: newVotes);
    polls.refresh();
    return polls[idx];
  }

  void addOption() => options.add(TextEditingController());

  void removeOption(int idx) => options.removeAt(idx);

  Future<void> createPoll() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final optionList = options.map((e) => e.text.trim()).toList();

    final pollBind = PollBind(title: title, description: description, options: optionList);
    final result = await Api.createPoll(pollBind);

    if (result != null) {
      clearFields();
      polls.add(result);
      Get.back();
    }
  }

  void getPolls() async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await Api.getAllPolls();
    polls.value = result ?? [];
    isLoading.value = false;
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    for (final e in options) {
      e.clear();
    }
  }
}
