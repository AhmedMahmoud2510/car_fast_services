part of 'users_cubit.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class GetUsersLoadingState extends UsersState {}

class GetUsersSuccessState extends UsersState {}

class GetUsersFailedState extends UsersState {}

class ChangeUsersPaginateState extends UsersState {}

class SetOffsetUsersState extends UsersState {}

class AddUserLoadingState extends UsersState {}

class AddUserSuccessState extends UsersState {}

class AddUserFailedState extends UsersState {}

class UpdateUserLoadingState extends UsersState {}

class UpdateUserSuccessState extends UsersState {}

class UpdateUserFailedState extends UsersState {}
