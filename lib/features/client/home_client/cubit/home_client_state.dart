part of 'home_client_cubit.dart';

abstract class HomeClientState {}

class HomeClientInitial extends HomeClientState {}

class GetServicesLoadingState extends HomeClientState {}

class GetServicesSuccessState extends HomeClientState {}

class GetServicesFailedState extends HomeClientState {}

class GetClientCarsLoadingState extends HomeClientState {}

class GetClientCarsSuccessState extends HomeClientState {}

class GetClientCarsFailedState extends HomeClientState {}
