part of 'service_record_cubit.dart';

abstract class ServiceRecordState {}

class ServiceRecordInitial extends ServiceRecordState {}

class GetServiceRecordLoadingState extends ServiceRecordState {}

class GetServiceRecordSuccessState extends ServiceRecordState {}

class GetServiceRecordFailedState extends ServiceRecordState {}
