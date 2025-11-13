import 'package:flutter/material.dart' as text;
import 'package:quick_cars_service/barrel.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final ScrollController scrollController = ScrollController();
        bool paginate = false;
        int pageSize = 1;
        int offset = 1;
        if (context.read<ChatCubit>().chatsPageSize != null) {
          paginate = context.read<ChatCubit>().chatsPaginate;
          pageSize = (context.read<ChatCubit>().chatsPageSize! / 5).ceil();
          offset = context.read<ChatCubit>().chatsOffset;
        } else {}
        scrollController.addListener(() {
          if ((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              context.read<ChatCubit>().chatsListModel != null &&
              !paginate)) {
            debugPrintWidget(
              'end of page$offset$pageSize${context.read<ChatCubit>().chatsPageSize}',
            );
            if (offset < pageSize) {
              context.read<ChatCubit>().setOffsetChats(offset + 1);
              context.read<ChatCubit>().getChats();
            }
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'chats'.tr(),
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<ChatCubit>().chatsOffsetList.clear();
              context.read<ChatCubit>().setOffsetChats(1);
              context.read<ChatCubit>().getChats();
            },
            child: context.read<ChatCubit>().chatsListModel != null
                ? context.read<ChatCubit>().chatsListModel!.data!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 15.h,
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Directionality(
                                    textDirection: text.TextDirection.ltr,
                                    child: InkWell(
                                      onTap: () async {
                                        ChatScreenModel model = ChatScreenModel(
                                          chatId: context
                                              .read<ChatCubit>()
                                              .chatsListModel!
                                              .data![index]
                                              .id,
                                          receiverId: context
                                              .read<ChatCubit>()
                                              .chatsListModel!
                                              .data![index]
                                              .user!
                                              .id,
                                        );
                                        context.pushNamed(
                                          Routes.chatScreen,
                                          arguments: model,
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        child: Row(
                                          children: [
                                            // Avatar
                                            CircleAvatar(
                                              radius: 26.r,
                                              backgroundColor: AppColors
                                                  .primaryColor
                                                  .withAlpha(51),
                                              child: Text(
                                                context
                                                        .read<ChatCubit>()
                                                        .chatsListModel!
                                                        .data![index]
                                                        .user!
                                                        .name!
                                                        .isNotEmpty
                                                    ? context
                                                          .read<ChatCubit>()
                                                          .chatsListModel!
                                                          .data![index]
                                                          .user!
                                                          .name![0]
                                                          .toUpperCase()
                                                    : '?',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            15.horizontalSpace,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    context
                                                        .read<ChatCubit>()
                                                        .chatsListModel!
                                                        .data![index]
                                                        .user!
                                                        .name!,
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  3.verticalSpace,
                                                  Text(
                                                    '${context.read<ChatCubit>().chatsListModel!.data![index].lastMessage}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${context.read<ChatCubit>().chatsListModel!.data![index].lastTimeMessage}',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                3.verticalSpace,
                                                if (context
                                                        .read<ChatCubit>()
                                                        .chatsListModel!
                                                        .data![index]
                                                        .countMessagesNotRead !=
                                                    0)
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      6.r,
                                                    ),
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Text(
                                                      '${context.read<ChatCubit>().chatsListModel!.data![index].countMessagesNotRead}',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      15.verticalSpace,
                                  itemCount: context
                                      .read<ChatCubit>()
                                      .chatsListModel!
                                      .data!
                                      .length,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const NoDataWidget()
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
