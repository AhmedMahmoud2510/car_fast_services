import 'package:quick_cars_service/barrel.dart';

class TechnicianHomeScreen extends StatefulWidget {
  const TechnicianHomeScreen({super.key});

  @override
  State<TechnicianHomeScreen> createState() => _TechnicianHomeScreenState();
}

class _TechnicianHomeScreenState extends State<TechnicianHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (!mounted) return;

      final cubit = context.read<HomeTechnicianCubit>();
      bool paginate = false;
      int pageSize = 1;
      int offset = 1;

      if (cubit.maintenanceRequestsPageSize != null) {
        paginate = cubit.maintenanceRequestsPaginate;
        pageSize = (cubit.maintenanceRequestsPageSize! / 5).ceil();
        offset = cubit.maintenanceRequestsOffset;
      }

      if ((_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          cubit.carMaintenanceRequestsModel != null &&
          !paginate)) {
        debugPrintWidget(
          'end of page$offset$pageSize${cubit.maintenanceRequestsPageSize}',
        );
        if (offset < pageSize) {
          cubit.setOffsetMaintenanceRequests(offset + 1);
          cubit.getCarRequestsMaintenance();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTechnicianCubit, HomeTechnicianState>(
      listener: (context, state) {
        if (state is DeleteRequestSuccessState) {
          context.read<HomeTechnicianCubit>().setOffsetMaintenanceRequests(1);
          context
              .read<HomeTechnicianCubit>()
              .maintenanceRequestsOffsetList
              .clear();
          context.read<HomeTechnicianCubit>().getCarRequestsMaintenance();
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeTechnicianCubit>();
        final requests = cubit.carMaintenanceRequestsModel?.data ?? [];
        final int totalRequests = requests.length;
        final double totalCost = requests.fold(
          0,
          (sum, item) =>
              sum + (double.tryParse(item.totalAmount.toString()) ?? 0),
        );
        return Scaffold(
          drawer: CacheHelper.getData(key: CacheKeys.userRole) == 'technician'
              ? const TechnicianDrawerWidget()
              : CacheHelper.getData(key: CacheKeys.userRole) == 'client'
              ? null
              : const AdminDrawerWidget(),
          appBar: AppBar(
            title: Text(
              'requests'.tr(),
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                10.verticalSpace,
                _buildSearchField(cubit),

                // --- قسم الإحصائيات الجديد ---
                if (requests.isNotEmpty)
                  _buildSummaryCard(totalRequests, totalCost),
                16.verticalSpace,
                // 8.verticalSpace,
                Expanded(child: _buildContent(context, state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(HomeTechnicianCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: cubit.searchController,
        decoration: InputDecoration(
          hintText: 'requests_search'.tr(),
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
          suffixIcon: cubit.searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, color: AppColors.primaryColor),
                  onPressed: () => cubit.clearSearch(),
                )
              : null,
          filled: true,
          fillColor: AppColors.secondaryColor.withAlpha(26),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        onChanged: (value) => cubit.onSearchChanged(value),
      ),
    );
  } // دالة بناء بطاقة الإحصائيات

  Widget _buildSummaryCard(int count, double cost) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildStatItem(
            label: 'إجمالي عدد الخدمات',
            value: '$count',
            icon: Icons.list_alt,
          ),
          12.verticalSpace,

          _buildStatItem(
            label: 'إجمالي سعر الخدمات',
            value: '${cost.toStringAsFixed(2)} ر.س',
            icon: Icons.payments_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18.r, color: AppColors.primaryColor),
        5.horizontalSpace,
        Text(label, style: Styles.style14W400.copyWith(color: Colors.grey)),
        const Spacer(),
        Text(
          value,
          style: Styles.style14W600.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, HomeTechnicianState state) {
    final cubit = context.read<HomeTechnicianCubit>();

    // إظهار مؤشر تحميل فقط في أول مرة أو عند تصفير البحث
    if (state is GetRequestsLoadingState &&
        cubit.carMaintenanceRequestsModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cubit.carMaintenanceRequestsModel == null ||
        cubit.carMaintenanceRequestsModel!.data!.isEmpty) {
      return const NoDataWidget();
    }

    // حالة وجود بيانات
    return RefreshIndicator(
      onRefresh: () async {
        String searchQuery = cubit.searchController.text;
        if (searchQuery.isNotEmpty) {
          await cubit.searchCarRequests(searchQuery);
        } else {
          cubit.setOffsetMaintenanceRequests(1);
          cubit.maintenanceRequestsOffsetList.clear();
          await cubit.getCarRequestsMaintenance();
        }
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: 100.h),
        itemCount: cubit.carMaintenanceRequestsModel!.data!.length,
        separatorBuilder: (context, index) => 15.verticalSpace,
        itemBuilder: (context, index) {
          final requests = cubit.carMaintenanceRequestsModel!.data!;
          final request = requests[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                Routes.requestDetailsScreen,
                arguments: request,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${'invoice_number'.tr()}: ",
                          style: Styles.style20W700.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${cubit.carMaintenanceRequestsModel!.data![index].id}',
                            style: Styles.style18W600.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${'invoice_date'.tr()}: ",
                          style: Styles.style20W600.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          '${cubit.carMaintenanceRequestsModel!.data![index].createdAt}',
                          style: Styles.style18W500.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${'car_number'.tr()}: ",
                          style: Styles.style20W700.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          '${cubit.carMaintenanceRequestsModel!.data![index].car!.plateNo}',
                          style: Styles.style18W500.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${'total_amount'.tr()}: ",
                          style: Styles.style20W700.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${cubit.carMaintenanceRequestsModel!.data![index].totalAmount} ريال',
                            style: Styles.style18W500.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    if (CacheHelper.getData(key: CacheKeys.userRole) !=
                        'technician')
                      TextButton(
                        onPressed: () {
                          context.pushNamed(
                            Routes.invoiceScreen,
                            arguments:
                                '${cubit.carMaintenanceRequestsModel!.data![index].id}',
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'invoice'.tr(),
                            style: Styles.style18W500.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
