import 'package:quick_cars_service/barrel.dart';
import 'package:quick_cars_service/features/service_record/controller/service_record_cubit.dart';
import 'package:quick_cars_service/features/service_record/data/model/service_record_model.dart'
    as sr;

class ServiceRecordScreen extends StatefulWidget {
  final String clientId;
  const ServiceRecordScreen({super.key, required this.clientId});

  @override
  State<ServiceRecordScreen> createState() => _ServiceRecordScreenState();
}

class _ServiceRecordScreenState extends State<ServiceRecordScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceRecordCubit>().getClientMaintenanceRequests(
      clientId: widget.clientId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceRecordCubit, ServiceRecordState>(
      builder: (context, state) {
        final cubit = context.read<ServiceRecordCubit>();
        final List<sr.Product> services = cubit.displayedServices;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'service_record'.tr(),
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: TextFormField(
                  controller: cubit.maintenanceRequestsSearchController,
                  decoration: InputDecoration(
                    hintText: 'search_for_service_name'.tr(),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                    ),
                    suffixIcon:
                        cubit
                            .maintenanceRequestsSearchController
                            .text
                            .isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              cubit.maintenanceRequestsSearchController.clear();
                              cubit.onSearchChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.secondaryColor.withAlpha(26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onChanged: cubit.onSearchChanged,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'service_record'.tr(),
                  style: Styles.style18W700.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              12.verticalSpace,

              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state is GetServiceRecordLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (services.isEmpty) {
                      return const NoDataWidget();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final sr.Product service = services[index];

                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  service.name,
                                  style: Styles.style14W600.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),

                              Text(
                                '${service.price} ر.س',
                                style: Styles.style14W700.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
