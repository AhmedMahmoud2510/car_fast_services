part of 'cars_cubit.dart';

abstract class CarsState {}

class CarsInitial extends CarsState {}

class GetBrandsLoadingState extends CarsState {}

class GetBrandsSuccessState extends CarsState {}

class GetBrandsFailedState extends CarsState {}

class GetMakesLoadingState extends CarsState {}

class GetMakesSuccessState extends CarsState {}

class GetMakesFailedState extends CarsState {}

class GetCarsLoadingState extends CarsState {}

class GetCarsSuccessState extends CarsState {}

class GetCarsFailedState extends CarsState {}

class ChangeCarsPaginateState extends CarsState {}

class SetOffsetCarsState extends CarsState {}

class AddCarLoadingState extends CarsState {}

class AddCarSuccessState extends CarsState {}

class AddCarFailedState extends CarsState {}

class DeleteCarLoadingState extends CarsState {}

class DeleteCarSuccessState extends CarsState {}

class DeleteCarFailedState extends CarsState {}

class UpdateCarLoadingState extends CarsState {}

class UpdateCarSuccessState extends CarsState {}

class UpdateCarFailedState extends CarsState {}

class CarsSearchLoadingState extends CarsState {}

class CarsSearchSuccessState extends CarsState {}

class CarsSearchFailedState extends CarsState {}
