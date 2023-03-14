import 'package:dio/dio.dart';
import 'package:poll/models/poll.dart';
import 'package:poll/models/poll_bind.dart';

class Api {
  static Dio get dioAuth => Dio(
        BaseOptions(baseUrl: "http://192.168.1.96"),
      );

  static Future<PollModel?> createPoll(PollBind pollBind) async {
    try {
      Response response = await dioAuth.post('/poll', data: pollBind.toJson());
      if (response.statusCode == 200) {
        return PollModel.fromMap(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<PollModel?> getPoll(int id) async {
    try {
      Response response = await dioAuth.get('/poll', queryParameters: {"id": id});
      if (response.statusCode == 200) {
        return PollModel.fromMap(response.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<List<PollModel>?> getAllPolls() async {
    try {
      Response response = await dioAuth.get('/poll/all');
      if (response.statusCode == 200) {
        List<dynamic> items = response.data;
        return items.map((e) => PollModel.fromMap(e)).toList();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<List<int>?> getPollVotes(int id) async {
    try {
      Response response = await dioAuth.get('/poll/votes', queryParameters: {"id": id});
      if (response.statusCode == 200) {
        // List<dynamic> items = response.data;
        // return items.map((e) => int.parse(e)).toList();
        return response.data;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<List<int>?> patchVote(int id, int index) async {
    try {
      Response response = await dioAuth.patch('/poll', queryParameters: {"id": id, "index": index});
      if (response.statusCode == 200) {
        List<dynamic> items = response.data;
        return items.map((e) => e as int).toList();
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
