import 'package:quick_cars_service/barrel.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._usersRepo) : super(UsersInitial());
  final UsersRepo _usersRepo;
  UsersModel? usersModel;
  List<int> usersOffsetList = [];
  int usersOffset = 1;
  bool usersPaginate = false;
  int? usersPageSize;
  Future<void> getUsers() async {
    showLoading();
    if (!usersOffsetList.contains(usersOffset)) {
      usersOffsetList.add(usersOffset);
      emit(GetUsersLoadingState());
      if (usersModel != null && usersOffset == 1) {
        usersModel = null;
      }
      final result = await _usersRepo.getUsers(page: '$usersOffset');
      result.fold(
        (l) {
          hideLoading();
          emit(GetUsersFailedState());
        },
        (model) {
          hideLoading();
          if (usersOffset == 1) {
            usersModel = model;
          } else {
            usersModel!.data!.addAll(model.data!);
          }
          usersPageSize = usersModel!.meta!.total;
          usersPaginate = false;
          emit(GetUsersSuccessState());
        },
      );
    } else {
      hideLoading();
      if (usersPaginate) {
        usersPaginate = false;
        emit(ChangeUsersPaginateState());
      }
    }
  }

  void setOffsetUsers(int offset) {
    usersOffset = offset;
    emit(SetOffsetUsersState());
  }

  User? addedUser;
  Future<void> addUser() async {
    showLoading();
    emit(AddUserLoadingState());
    final result = await _usersRepo.addUser(
      name: nameController.text,
      phone: phoneController.text,
      role: selectedRole,
      password: passwordController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(AddUserFailedState());
      },
      (model) {
        hideLoading();
        addedUser = model;
        nameController.clear();
        phoneController.clear();
        selectedRole = 'client';
        passwordController.clear();
        emit(AddUserSuccessState());
      },
    );
  }

  User? updatedUser;
  Future<void> updateUser({required String id}) async {
    showLoading();
    emit(UpdateUserLoadingState());
    final result = await _usersRepo.updateUser(
      userID: id,
      name: nameController.text,
      phone: phoneController.text,
      role: selectedRole,
      password: passwordController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(UpdateUserFailedState());
      },
      (model) {
        hideLoading();
        updatedUser = model;
        nameController.clear();
        phoneController.clear();
        passwordController.clear();
        selectedRole = 'client';
        emit(UpdateUserSuccessState());
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> rolesList = ['admin', 'client', 'technician', 'reception'];
  List<String> rolesListReception = ['client'];
  String selectedRole = 'client';
  void showUpdateAndAddUsersDialog({
    required BuildContext context,
    required bool isAdd,
    required bool isReception,
    required bool isAdmin,
    int? index,
    String? userName,
    String? phone,
    String? role,
    String? userID,
  }) {
    if (!isAdd) {
      nameController.text = userName!;
      phoneController.text = phone!;
      selectedRole = role!;
      passwordController.text = '';
    } else {
      passwordController.text = '12345678';
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Center(
          child: Text(
            isAdd ? 'add_user'.tr() : userName!,
            style: Styles.style20W600.copyWith(color: AppColors.primaryColor),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'name'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ), // Outline border
                ),
              ),
              15.verticalSpace,
              Text(
                'phone'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ), // Outline border
                ),
              ),
              15.verticalSpace,
              Text(
                'password'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              TextFormField(
                readOnly: isAdd ? true : false,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: passwordController.text,
                  labelStyle: Styles.style14W400.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ), // Outline border
                ),
              ),
              15.verticalSpace,
              if (isAdmin)
                Text(
                  'acc_type'.tr(),
                  style: Styles.style16W600.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              if (isAdmin) 5.verticalSpace,
              if (isAdmin)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                  ),
                  initialValue: selectedRole,
                  items: isReception
                      ? rolesListReception.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: Styles.style14W400.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        }).toList()
                      : rolesList.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: Styles.style14W400.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                  onChanged: (newValue) {
                    selectedRole = newValue!;
                  },
                ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (isAdd) {
                    addUser().then((v) {
                      Navigator.pop(context);
                    });
                  } else {
                    updateUser(id: userID!).then((v) {
                      Navigator.pop(context);
                    });
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryColor, // Change to your desired color
                  foregroundColor: AppColors.secondaryColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ), // Rounded corners
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    isAdd ? 'add'.tr() : 'update'.tr(),
                    style: Styles.style18W500.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ), // Rounded corners
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'cancel'.tr(),
                    style: Styles.style18W500.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
