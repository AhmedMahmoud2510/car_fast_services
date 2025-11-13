import 'package:quick_cars_service/features/admin/users/data/model/users_model.dart';

import '../../../cars/data/model/cars_model.dart';

class ChatsListModel {
  int? code;
  String? message;
  List<Data>? data;
  Meta? meta;
  Links? links;

  ChatsListModel({this.code, this.message, this.data, this.meta, this.links});

  ChatsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  User? user;
  String? lastMessage;
  String? lastTimeMessage;
  int? countMessagesNotRead;

  Data(
      {this.id,
        this.user,
        this.lastMessage,
        this.lastTimeMessage,
        this.countMessagesNotRead});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    lastMessage = json['last_message'];
    lastTimeMessage = json['last_time_message'];
    countMessagesNotRead = json['count_messages_not_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['last_message'] = lastMessage;
    data['last_time_message'] = lastTimeMessage;
    data['count_messages_not_read'] = countMessagesNotRead;
    return data;
  }
}