import 'package:quick_cars_service/barrel.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.isReception});
  final bool isReception;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is AddUserSuccessState || state is UpdateUserSuccessState) {
          context.read<UsersCubit>().setOffsetUsers(1);
          context.read<UsersCubit>().usersOffsetList.clear();
          context.read<UsersCubit>().getUsers();
        }
      },
      builder: (context, state) {
        final userCubit = context.read<UsersCubit>();
        final ScrollController scrollController = ScrollController();
        bool paginate = false;
        int pageSize = 1;
        int offset = 1;
        if (context.read<UsersCubit>().usersPageSize != null) {
          paginate = context.read<UsersCubit>().usersPaginate;
          pageSize = (context.read<UsersCubit>().usersPageSize! / 5).ceil();
          offset = context.read<UsersCubit>().usersOffset;
        } else {}
        scrollController.addListener(() {
          if ((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              context.read<UsersCubit>().usersModel != null &&
              !paginate)) {
            debugPrintWidget(
              'end of page$offset$pageSize${context.read<UsersCubit>().usersPageSize}',
            );
            if (offset < pageSize) {
              context.read<UsersCubit>().setOffsetUsers(offset + 1);
              context.read<UsersCubit>().getUsers();
            }
          }
        });
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () async {
              final userRole = await CacheHelper.getData(
                key: CacheKeys.userRole,
              );
              context.read<UsersCubit>().showUpdateAndAddUsersDialog(
                context: context,
                isAdmin: userRole == 'admin' ? true : false,
                isAdd: true,
                isReception: isReception,
              );
            },
            child: Text('add'.tr()),
          ),
          appBar: AppBar(
            title: Text(
              'users'.tr(),
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),
          body: context.read<UsersCubit>().usersModel != null
              ? context.read<UsersCubit>().usersModel!.data!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          child: Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 15.h,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${'name'.tr()}: ",
                                              style: Styles.style20W700
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${context.read<UsersCubit>().usersModel!.data![index].name}',
                                                style: Styles.style18W500
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        15.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${'phone'.tr()}: ",
                                              style: Styles.style20W700
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            Text(
                                              '${context.read<UsersCubit>().usersModel!.data![index].phone}',
                                              style: Styles.style18W500
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        15.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${'acc_type'.tr()}: ",
                                              style: Styles.style20W700
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            Text(
                                              '${context.read<UsersCubit>().usersModel!.data![index].role}',
                                              style: Styles.style18W500
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        15.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (!isReception)
                                              BlocProvider(
                                                create: (context) =>
                                                    ChatCubit(getIt()),
                                                child: BlocBuilder<ChatCubit, ChatState>(
                                                  builder: (context, state) {
                                                    final chatCubit = context
                                                        .read<ChatCubit>();
                                                    return TextButton(
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    20.r,
                                                                  ),
                                                            ),
                                                            title: Center(
                                                              child: Text(
                                                                '${'type_message'.tr()} ${"to".tr()} : ${userCubit.usersModel!.data![index].name} ',
                                                                style: Styles
                                                                    .style20W700
                                                                    .copyWith(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                    ),
                                                              ),
                                                            ),
                                                            content: SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  TextField(
                                                                    controller:
                                                                        chatCubit
                                                                            .messageController,
                                                                    textCapitalization:
                                                                        TextCapitalization
                                                                            .sentences,
                                                                    decoration: InputDecoration(
                                                                      hintText:
                                                                          'type_message'
                                                                              .tr(),
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            15.w,
                                                                        vertical:
                                                                            15.h,
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              30.r,
                                                                            ),
                                                                        borderSide: const BorderSide(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              30.r,
                                                                            ),
                                                                        borderSide: const BorderSide(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                        ),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              30.r,
                                                                            ),
                                                                        borderSide: const BorderSide(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                    style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          AppColors
                                                                              .primaryColor, // Text color
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                          15.r,
                                                                        ), // Rounded corners
                                                                      ),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20.w,
                                                                      ),
                                                                      child: Text(
                                                                        'cancel'
                                                                            .tr(),
                                                                        style: Styles
                                                                            .style18W500
                                                                            .copyWith(
                                                                              color: AppColors.primaryColor,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      chatCubit
                                                                          .sendMessage(
                                                                            receiverId:
                                                                                '${userCubit.usersModel!.data![index].id}',
                                                                          )
                                                                          .then((
                                                                            v,
                                                                          ) {
                                                                            ChatScreenModel
                                                                            model = ChatScreenModel(
                                                                              chatId: chatCubit.sentMessage!.chatId,
                                                                              receiverId: userCubit.usersModel!.data![index].id,
                                                                            );
                                                                            context.pushReplacementNamed(
                                                                              Routes.chatScreen,
                                                                              arguments: model,
                                                                            );
                                                                          });
                                                                    },
                                                                    style: TextButton.styleFrom(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .primaryColor, // Change to your desired color
                                                                      foregroundColor:
                                                                          AppColors
                                                                              .secondaryColor, // Text color
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                          15.r,
                                                                        ), // Rounded corners
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .send_outlined,
                                                                      color: AppColors
                                                                          .secondaryColor,
                                                                      size:
                                                                          40.r,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      style: TextButton.styleFrom(
                                                        backgroundColor: AppColors
                                                            .primaryColor, // Change to your desired color
                                                        foregroundColor: AppColors
                                                            .secondaryColor, // Text color
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15.r,
                                                              ), // Rounded corners
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 20.w,
                                                            ),
                                                        child: Text(
                                                          'chat'.tr(),
                                                          style: Styles
                                                              .style18W500
                                                              .copyWith(
                                                                color: AppColors
                                                                    .secondaryColor,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            if (isReception)
                                              BlocProvider(
                                                create: (context) =>
                                                    CarsCubit(getIt()),
                                                child: BlocBuilder<CarsCubit, CarsState>(
                                                  builder: (context, state) {
                                                    return TextButton(
                                                      onPressed: () async {
                                                        context.read<CarsCubit>().getBrands().then((
                                                          onValue,
                                                        ) {
                                                          context
                                                              .read<CarsCubit>()
                                                              .getMakes()
                                                              .then((onValue) {
                                                                context
                                                                    .read<
                                                                      CarsCubit
                                                                    >()
                                                                    .showUpdateAndAddCarsDialog(
                                                                      context:
                                                                          context,
                                                                      isAdd:
                                                                          true,
                                                                      userId: userCubit
                                                                          .usersModel!
                                                                          .data![index]
                                                                          .id,
                                                                    );
                                                              });
                                                        });
                                                      },
                                                      style: TextButton.styleFrom(
                                                        backgroundColor: AppColors
                                                            .primaryColor, // Change to your desired color
                                                        foregroundColor: AppColors
                                                            .secondaryColor, // Text color
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15.r,
                                                              ), // Rounded corners
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 20.w,
                                                            ),
                                                        child: Text(
                                                          'add_car'.tr(),
                                                          style: Styles
                                                              .style18W500
                                                              .copyWith(
                                                                color: AppColors
                                                                    .secondaryColor,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            TextButton(
                                              onPressed: () async {
                                                final userRole =
                                                    await CacheHelper.getData(
                                                      key: CacheKeys.userRole,
                                                    );
                                                context
                                                    .read<UsersCubit>()
                                                    .showUpdateAndAddUsersDialog(
                                                      context: context,
                                                      isAdd: false,
                                                      isReception: isReception,
                                                      isAdmin:
                                                          userRole == 'admin'
                                                          ? true
                                                          : false,
                                                      userName:
                                                          '${context.read<UsersCubit>().usersModel!.data![index].name}',
                                                      phone:
                                                          '${context.read<UsersCubit>().usersModel!.data![index].phone}',
                                                      role:
                                                          '${context.read<UsersCubit>().usersModel!.data![index].role}',
                                                      userID:
                                                          '${context.read<UsersCubit>().usersModel!.data![index].id}',
                                                    );
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .primaryColor, // Change to your desired color
                                                foregroundColor: AppColors
                                                    .secondaryColor, // Text color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.r,
                                                      ), // Rounded corners
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                ),
                                                child: Text(
                                                  'update'.tr(),
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    15.verticalSpace,
                                itemCount: context
                                    .read<UsersCubit>()
                                    .usersModel!
                                    .data!
                                    .length,
                              ),
                              100.verticalSpace,
                            ],
                          ),
                        ),
                      )
                    : const NoDataWidget()
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
