import 'package:quick_cars_service/barrel.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandsCubit, BrandsState>(
      listener: (context, state) {
        if (state is AddBrandSuccessState ||
            state is UpdateBrandSuccessState ||
            state is DeleteBrandSuccessState) {
          context.read<BrandsCubit>().setOffsetBrands(1);
          context.read<BrandsCubit>().brandsOffsetList.clear();
          context.read<BrandsCubit>().getBrands();
        }
      },
      builder: (context, state) {
        final ScrollController scrollController = ScrollController();
        bool paginate = false;
        int pageSize = 1;
        int offset = 1;
        if (context.read<BrandsCubit>().brandsPageSize != null) {
          paginate = context.read<BrandsCubit>().brandsPaginate;
          pageSize = (context.read<BrandsCubit>().brandsPageSize! / 5).ceil();
          offset = context.read<BrandsCubit>().brandsOffset;
        } else {}
        scrollController.addListener(() {
          if ((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              context.read<BrandsCubit>().brandsModel != null &&
              !paginate)) {
            debugPrintWidget(
              'end of page$offset$pageSize${context.read<BrandsCubit>().brandsPageSize}',
            );
            if (offset < pageSize) {
              context.read<BrandsCubit>().setOffsetBrands(offset + 1);
              context.read<BrandsCubit>().getBrands();
            }
          }
        });
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              context.read<BrandsCubit>().showUpdateAndAddBrandsDialog(
                context: context,
                isAdd: true,
              );
            },
            child: Text('add'.tr()),
          ),
          appBar: AppBar(
            title: Text(
              'brands'.tr(),
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),
          body: context.read<BrandsCubit>().brandsModel != null
              ? context.read<BrandsCubit>().brandsModel!.data!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: SingleChildScrollView(
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
                                              "${'car_brand'.tr()}: ",
                                              style: Styles.style20W700
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${context.read<BrandsCubit>().brandsModel!.data![index].name}',
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
                                            TextButton(
                                              onPressed: () {
                                                // context.read<BrandsCubit>().deleteBrand(id:'${context.read<BrandsCubit>().brandsModel!.data![index].id}');
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
                                                  'delete'.tr(),
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context
                                                    .read<BrandsCubit>()
                                                    .showUpdateAndAddBrandsDialog(
                                                      context: context,
                                                      isAdd: false,
                                                      brandId:
                                                          '${context.read<BrandsCubit>().brandsModel!.data![index].id}',
                                                      index: index,
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
                                    .read<BrandsCubit>()
                                    .brandsModel!
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
