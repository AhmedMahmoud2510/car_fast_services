import 'package:quick_cars_service/barrel.dart';
import 'package:quick_cars_service/features/technician/data/model/car_requests_maintenance_model.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key, required this.request});
  final Data request;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final role = await CacheHelper.getData(key: CacheKeys.userRole);
    if (mounted) {
      setState(() {
        userRole = role;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final maintenanceList = widget.request.maintenances ?? [];
    final int totalServices = maintenanceList.length;

    // حساب إجمالي التكلفة (تحويل السعر من نص إلى رقم وجمعه)
    final double totalCost = maintenanceList.fold(0, (sum, item) {
      return sum + (double.tryParse(item.product?.price ?? '0') ?? 0);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'request_details'.tr(),
          style: Styles.style16W600.copyWith(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: BlocBuilder<HomeTechnicianCubit, HomeTechnicianState>(
        builder: (context, state) {
          final cubit = context.read<HomeTechnicianCubit>();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15.r),
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryItem(
                          label: 'إجمالي عدد الخدمات',
                          value: '$totalServices',
                          icon: Icons.settings_suggest_outlined,
                        ),
                        12.verticalSpace,
                        _buildSummaryItem(
                          label: 'إجمالي التكاليف',
                          value: '${totalCost.toStringAsFixed(2)} ر.س',
                          icon: Icons.monetization_on_outlined,
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final request = widget.request.maintenances![index];

                      return GestureDetector(
                        onTap: () {
                          if (userRole == 'technician') {
                            cubit.showUpdateRequestDialog(
                              context: context,
                              requestId: '${request.id}',
                              isMaintenance: false,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            border: Border.all(color: AppColors.primaryColor),
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
                                      "${'service_name'.tr()}: ",
                                      style: Styles.style20W700.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        request.product?.name ?? '',
                                        style: Styles.style18W500.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // if (userRole == 'technician')
                                ...[
                                  15.verticalSpace,

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${'price'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          request.product?.price ?? '',
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (userRole == 'admin') ...[
                                  15.verticalSpace,

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${'status'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          request.status ?? '',
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => 15.verticalSpace,
                    itemCount: widget.request.maintenances!.length,
                  ),
                  100.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryItem({
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
          style: Styles.style18W600.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
