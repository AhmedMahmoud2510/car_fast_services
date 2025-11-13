import 'package:quick_cars_service/barrel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.data});
  final ChatScreenModel data;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().initPusher(
      channelName: 'chat${widget.data.chatId}${widget.data.receiverId}',
    );
  }

  @override
  void dispose() {
    context.read<ChatCubit>().disposePusher(
      channelName: 'chat${widget.data.chatId}${widget.data.receiverId}',
    );
    super.dispose();
  }

  Widget _buildMessage(Message message, int userId) {
    final isMe = userId != message.senderId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primaryColor
              : AppColors.greyColor.withAlpha(77),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomRight: isMe
                ? const Radius.circular(0)
                : Radius.circular(20.r),
            bottomLeft: !isMe
                ? const Radius.circular(0)
                : Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imagePath != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        backgroundColor: Colors.black,
                        body: GestureDetector(
                          onHorizontalDragEnd: (_) => Navigator.pop(context),
                          child: PhotoView(
                            imageProvider: NetworkImage(message.imagePath!),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    message.imagePath!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (message.imagePath != null) 10.verticalSpace,
            Text(
              message.body ?? '',
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(ChatCubit chatCubit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      color: AppColors.secondaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show selected image preview if available
          if (chatCubit.pickedFile != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.file(
                    File(chatCubit.pickedFile!.path),
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => chatCubit.removePickedImage(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(153),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          10.verticalSpace,

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.image, color: AppColors.primaryColor),
                onPressed: () async {
                  await chatCubit.pickImage();
                },
              ),
              Expanded(
                child: TextField(
                  controller: chatCubit.messageController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'type_message'.tr(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  chatCubit.sendMessage(
                    receiverId: '${widget.data.receiverId}',
                  );
                },
                backgroundColor: AppColors.primaryColor,
                child: const Icon(Icons.send, color: AppColors.secondaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatMessagesUpdatedState) {
          if (kDebugMode) {
            print(
              '✅ New message received, messages: ${state.model.messages?.length}',
            );
          }
        }
        // if (state is SendMessageSuccessState) {
        //   context.read<ChatCubit>().chatsOffsetList.clear();
        //   context.read<ChatCubit>().setOffsetChats(1);
        //   context.read<ChatCubit>().getChats();
        // }
      },
      builder: (context, state) {
        final chatCubit = context.watch<ChatCubit>();
        final messagesModel = chatCubit.messagesModel;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              messagesModel?.messages?.last.receiverName ?? '',
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),
          body: messagesModel == null
              ? const SizedBox.shrink()
              : messagesModel.messages!.isEmpty
              ? const NoDataWidget()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.all(10.sp),
                        itemCount: messagesModel.messages!.length,
                        itemBuilder: (context, index) {
                          return _buildMessage(
                            messagesModel.messages![index],
                            widget.data.receiverId!,
                          );
                        },
                      ),
                    ),
                    _buildInputField(chatCubit),
                  ],
                ),
        );
      },
    );
  }
}
