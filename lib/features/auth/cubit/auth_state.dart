part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailedState extends AuthState {}

class GetProfileLoadingState extends AuthState {}

class GetProfileSuccessState extends AuthState {}

class GetProfileFailedState extends AuthState {}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutFailedState extends AuthState {}
