part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class GetChatsLoadingState extends ChatState {}

class GetChatsSuccessState extends ChatState {}

class GetChatsFailedState extends ChatState {}

class ChangeChatsPaginateState extends ChatState {}

class SetOffsetChatsState extends ChatState {}

class GetMessagesLoadingState extends ChatState {}

class GetMessagesSuccessState extends ChatState {}

class GetMessagesFailedState extends ChatState {}

class ChangeMessagesPaginateState extends ChatState {}

class SetOffsetMessagesState extends ChatState {}

class ChatMessagesUpdatedState extends ChatState {
  final MessagesModel model;

  ChatMessagesUpdatedState(this.model);
}

class PickImageState extends ChatState {}

class ChatImageRemovedState extends ChatState {}

class SendMessageLoadingState extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class SendMessageFailedState extends ChatState {}
