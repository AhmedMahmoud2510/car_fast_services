part of 'home_technician_cubit.dart';

abstract class HomeTechnicianState {}

class HomeTechnicianInitial extends HomeTechnicianState {}

class GetRequestsLoadingState extends HomeTechnicianState {}

class GetRequestsSuccessState extends HomeTechnicianState {}

class GetRequestsFailedState extends HomeTechnicianState {}

class ChangeMaintenanceRequestsPaginateState extends HomeTechnicianState {}

class SetOffsetMaintenanceRequestsState extends HomeTechnicianState {}

class GetRequestDetailsLoadingState extends HomeTechnicianState {}

class GetRequestDetailsSuccessState extends HomeTechnicianState {}

class GetRequestDetailsFailedState extends HomeTechnicianState {}

class SetRequestStatusState extends HomeTechnicianState {}

class UpdateRequestLoadingState extends HomeTechnicianState {}

class UpdateRequestSuccessState extends HomeTechnicianState {}

class UpdateRequestFailedState extends HomeTechnicianState {}

class DeleteRequestLoadingState extends HomeTechnicianState {}

class DeleteRequestSuccessState extends HomeTechnicianState {}

class DeleteRequestFailedState extends HomeTechnicianState {}

class SetSelectedCarState extends HomeTechnicianState {}

class SetSelectedServicesState extends HomeTechnicianState {}

class AddRequestLoadingState extends HomeTechnicianState {}

class AddRequestSuccessState extends HomeTechnicianState {}

class AddRequestFailedState extends HomeTechnicianState {}
