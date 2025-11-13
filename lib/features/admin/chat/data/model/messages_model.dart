import '../../../cars/data/model/cars_model.dart';

class MessagesModel {
  int? code;
  String? message;
  List<Message>? messages;
  Meta? meta;
  Links? links;

  MessagesModel({this.code, this.message, this.messages, this.meta, this.links});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      messages = <Message>[];
      json['data'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (messages != null) {
      data['data'] = messages!.map((v) => v.toJson()).toList();
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

class Message {
  int? chatId;
  int? senderId;
  String? senderName;
  int? receiverId;
  String? receiverName;
  String? body;
  String? imagePath;
  String? createAt;

  Message({
    this.chatId,
    this.senderId,
    this.senderName,
    this.receiverId,
    this.receiverName,
    this.body,
    this.imagePath,
    this.createAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    receiverId = json['receiver_id'];
    receiverName = json['receiver_name'];
    body = json['body'];
    imagePath = json['image_path'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = chatId;
    data['sender_id'] = senderId;
    data['sender_name'] = senderName;
    data['receiver_id'] = receiverId;
    data['receiver_name'] = receiverName;
    data['body'] = body;
    data['image_path'] = imagePath;
    data['create_at'] = createAt;
    return data;
  }
}
