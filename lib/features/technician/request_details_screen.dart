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
                                if (userRole == 'technician') ...[
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
}
