part of 'brands_cubit.dart';

abstract class BrandsState {}

class BrandsInitial extends BrandsState {}

class GetBrandsLoadingState extends BrandsState {}

class GetBrandsSuccessState extends BrandsState {}

class GetBrandsFailedState extends BrandsState {}

class ChangeBrandsPaginateState extends BrandsState {}

class SetOffsetBrandsState extends BrandsState {}

class GetMakesLoadingState extends BrandsState {}

class GetMakesSuccessState extends BrandsState {}

class GetMakesFailedState extends BrandsState {}

class ChangeMakesPaginateState extends BrandsState {}

class SetOffsetMakesState extends BrandsState {}

class AddBrandLoadingState extends BrandsState {}

class AddBrandSuccessState extends BrandsState {}

class AddBrandFailedState extends BrandsState {}

class DeleteBrandLoadingState extends BrandsState {}

class DeleteBrandSuccessState extends BrandsState {}

class DeleteBrandFailedState extends BrandsState {}

class UpdateBrandLoadingState extends BrandsState {}

class UpdateBrandSuccessState extends BrandsState {}

class UpdateBrandFailedState extends BrandsState {}
