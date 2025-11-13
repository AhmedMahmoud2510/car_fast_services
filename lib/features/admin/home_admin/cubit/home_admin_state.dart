part of 'home_admin_cubit.dart';

abstract class HomeAdminState {}

class HomeAdminInitial extends HomeAdminState {}

class GetServicesLoadingState extends HomeAdminState {}

class GetServicesSuccessState extends HomeAdminState {}

class GetServicesFailedState extends HomeAdminState {}

class ChangeServicesPaginateState extends HomeAdminState {}

class SetOffsetServicesState extends HomeAdminState {}

class AddServicesLoadingState extends HomeAdminState {}

class AddServicesSuccessState extends HomeAdminState {}

class AddServicesFailedState extends HomeAdminState {}

class DeleteServicesLoadingState extends HomeAdminState {}

class DeleteServicesSuccessState extends HomeAdminState {}

class DeleteServicesFailedState extends HomeAdminState {}

class UpdateServicesLoadingState extends HomeAdminState {}

class UpdateServicesSuccessState extends HomeAdminState {}

class UpdateServicesFailedState extends HomeAdminState {}
