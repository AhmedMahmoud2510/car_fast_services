
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:quick_cars_service/core/api/api_services.dart';
import 'package:quick_cars_service/core/api/failures.dart';
import 'package:quick_cars_service/features/admin/chat/data/model/chat_list_model.dart';
import 'package:quick_cars_service/features/admin/chat/data/model/messages_model.dart';

class ChatRepo {
  final ApiServices apiServices;

  ChatRepo(this.apiServices);

  Future<Either<Failure, ChatsListModel>> getChats({required String page}) async {
    var response = await apiServices.getChatList(page:page);
    if (response?.statusCode == 200) {
      ChatsListModel data = ChatsListModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }
  Future<Either<Failure, MessagesModel>> getChatDetails({ String? page, required String userId}) async {
    var response = await apiServices.getChatDetails(userId: userId,page:page);
    if (response?.statusCode == 200) {
      MessagesModel data = MessagesModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }

  Future<Either<Failure, Message>> sendMessage({ required String receiverId,  String? textMessage, File? image}) async {
    var response = await apiServices.sendMessage(receiverId: receiverId,messageText: textMessage,image: image);
    if (response?.statusCode == 200||response?.statusCode == 201) {
      Message data = Message.fromJson(response?.data['data']);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }
}