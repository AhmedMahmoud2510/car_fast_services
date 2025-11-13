import 'package:quick_cars_service/barrel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._chatRepo) : super(ChatInitial());
  final ChatRepo _chatRepo;
  ChatsListModel? chatsListModel;
  List<int> chatsOffsetList = [];
  int chatsOffset = 1;
  bool chatsPaginate = false;
  int? chatsPageSize;
  Future<void> getChats() async {
    showLoading();
    if (!chatsOffsetList.contains(chatsOffset)) {
      chatsOffsetList.add(chatsOffset);
      emit(GetChatsLoadingState());
      if (chatsListModel != null && chatsOffset == 1) {
        chatsListModel = null;
      }
      final result = await _chatRepo.getChats(page: '$chatsOffset');
      result.fold(
        (l) {
          hideLoading();
          emit(GetChatsFailedState());
        },
        (model) {
          hideLoading();
          if (chatsOffset == 1) {
            chatsListModel = model;
          } else {
            chatsListModel!.data!.addAll(model.data!);
          }
          chatsPageSize = chatsListModel!.meta!.total;
          chatsPaginate = false;
          emit(GetChatsSuccessState());
        },
      );
    } else {
      hideLoading();
      if (chatsPaginate) {
        chatsPaginate = false;
        emit(ChangeChatsPaginateState());
      }
    }
  }

  void setOffsetChats(int offset) {
    chatsOffset = offset;
    emit(SetOffsetChatsState());
  }

  MessagesModel? messagesModel;
  List<int> messagesOffsetList = [];
  int messagesOffset = 1;
  bool messagesPaginate = false;
  int? messagesPageSize;
  Future<void> getChatDetails({required String userId}) async {
    showLoading();
    if (!messagesOffsetList.contains(messagesOffset)) {
      messagesOffsetList.add(messagesOffset);
      emit(GetMessagesLoadingState());
      if (messagesModel != null && messagesOffset == 1) {
        messagesModel = null;
      }
      final result = await _chatRepo.getChatDetails(
        userId: userId,
        page: '$messagesOffset',
      );
      result.fold(
        (l) {
          hideLoading();
          emit(GetMessagesFailedState());
        },
        (model) {
          hideLoading();
          if (messagesOffset == 1) {
            messagesModel = model;
          } else {
            messagesModel!.messages!.addAll(model.messages!);
          }
          messagesPageSize = messagesModel!.meta!.total;
          messagesPaginate = false;
          emit(GetMessagesSuccessState());
        },
      );
    } else {
      hideLoading();
      if (messagesPaginate) {
        messagesPaginate = false;
        emit(ChangeMessagesPaginateState());
      }
    }
  }

  void setOffsetMessages(int offset) {
    messagesOffset = offset;
    emit(SetOffsetMessagesState());
  }

  PusherChannelsFlutter? pusher;

  Future<void> initPusher({required String channelName}) async {
    pusher = PusherChannelsFlutter.getInstance();

    await pusher!.init(
      apiKey: '91de3e5d6fe9b80128ff',
      cluster: 'eu',
      onEvent: onEvent,
      onSubscriptionSucceeded: (channelName, data) {
        if (kDebugMode) {
          print('Subscribed to $channelName');
        }
      },
    );

    await pusher!.connect();
    await pusher!.subscribe(channelName: channelName);
  }

  void onEvent(PusherEvent event) {
    try {
      if (kDebugMode) {
        print('❌ Error parsing Pusher message: ${event.data}');
      }
      messageController.clear();
      removePickedImage();
      final json = jsonDecode(event.data);
      final newMessage = Message.fromJson(json);
      messagesModel?.messages?.insert(0, newMessage);
      emit(ChatMessagesUpdatedState(messagesModel!));
    } catch (e, stack) {
      if (kDebugMode) {
        print('❌ Error parsing Pusher message: $e');
        print(stack);
      }
    }
  }

  void disposePusher({required String channelName}) {
    pusher?.unsubscribe(channelName: channelName);
    pusher?.disconnect();
  }

  final picker = ImagePicker();
  XFile? pickedFile;
  Future<void> pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    emit(PickImageState());
  }

  void removePickedImage() {
    pickedFile = null;
    emit(ChatImageRemovedState()); // trigger rebuild
  }

  Message? sentMessage;
  TextEditingController messageController = TextEditingController();
  Future<void> sendMessage({required String receiverId}) async {
    showLoading();
    emit(SendMessageLoadingState());
    final result = await _chatRepo.sendMessage(
      receiverId: receiverId,
      textMessage: messageController.text.isEmpty
          ? null
          : messageController.text,
      image: pickedFile != null ? File(pickedFile!.path) : null,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(SendMessageFailedState());
      },
      (model) {
        hideLoading();
        sentMessage = model;
        emit(SendMessageSuccessState());
      },
    );
  }
}
