import 'package:quick_cars_service/barrel.dart';

class ApiServices {
  ApiServices(this._dioFactory);
  final DioFactory _dioFactory;

  Future<Response?> login({required phone, required password}) async {
    return _dioFactory.post(
      endPoint: EndPoints.login,
      data: {'phone': phone, 'password': password},
    );
  }

  Future<Response?> getProfile() async {
    return _dioFactory.get(endPoint: EndPoints.getProfile);
  }

  Future<Response?> logout() async {
    return _dioFactory.get(endPoint: EndPoints.logout);
  }

  Future<Response?> getServices({page}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.getServices}?page=$page'
          : '${EndPoints.getServices}?data=all',
    );
  }

  Future<Response?> addService({required title, required desc}) async {
    return _dioFactory.post(
      data: {'title': title, 'desc': desc},
      endPoint: EndPoints.getServices,
    );
  }

  Future<Response?> deleteService({required id}) async {
    return _dioFactory.post(
      data: {'_method': 'delete'},
      endPoint: '${EndPoints.deleteService}$id',
    );
  }

  Future<Response?> updateService({
    required id,
    required title,
    required desc,
  }) async {
    return _dioFactory.post(
      endPoint: '${EndPoints.updateService}$id',
      data: {'_method': 'put', 'title': title, 'desc': desc},
    );
  }

  Future<Response?> getUsers({page}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.getUsers}?page=$page'
          : '${EndPoints.getUsers}?data=all',
    );
  }

  Future<Response?> addUser({
    required name,
    required phone,
    required password,
    required role,
  }) async {
    return _dioFactory.post(
      data: {'name': name, 'phone': phone, 'password': password, 'role': role},
      endPoint: EndPoints.addUser,
    );
  }

  Future<Response?> updateUser({
    required id,
    required name,
    required phone,
    required password,
    required role,
  }) async {
    return _dioFactory.post(
      data: password == null
          ? {'name': name, 'phone': phone, 'role': role}
          : {'name': name, 'phone': phone, 'password': password, 'role': role},
      endPoint: '${EndPoints.updateUser}$id/update',
    );
  }

  Future<Response?> getCars({page}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.cars}?page=$page'
          : '${EndPoints.cars}?data=all',
    );
  }

  Future<Response?> addCar({
    required brandID,
    required makeID,
    required carNumber,
    required year,
    required bodyNumber,
    // required carMeter,
    required userId,
  }) async {
    return _dioFactory.post(
      data: {
        'model_id': brandID,
        'make_id': makeID,
        'plate_no': carNumber,
        'made_year': year,
        'chassis_no': bodyNumber,
        // 'car_meter': carMeter,
        'customer_id': userId,
      },
      endPoint: EndPoints.cars,
    );
  }

  Future<Response?> updateCar({
    required carId,
    required brandID,
    required makeID,
    required carNumber,
    required year,
    required bodyNumber,
    required carMeter,
    required userId,
  }) async {
    return _dioFactory.post(
      data: {
        'model_id': brandID,
        'make_id': makeID,
        'plate_no': carNumber,
        'made_year': year,
        'chassis_no': bodyNumber,
        // 'car_meter': carMeter,
        'customer_id': userId,
        '_method': 'PUT',
      },
      endPoint: '${EndPoints.cars}/$carId',
    );
  }

  Future<Response?> deleteCar({required id}) async {
    return _dioFactory.post(
      data: {'_method': 'delete'},
      endPoint: '${EndPoints.cars}/$id',
    );
  }

  Future<Response?> carsSearch({required carNumber}) async {
    return _dioFactory.get(endPoint: '${EndPoints.carsSearch}= $carNumber');
  }

  Future<Response?> getBrands({page}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.brands}?page=$page'
          : '${EndPoints.brands}?data=all',
    );
  }

  Future<Response?> addBrand({required name}) async {
    return _dioFactory.post(data: {'name': name}, endPoint: EndPoints.brands);
  }

  Future<Response?> updateBrand({required brandID, required name}) async {
    return _dioFactory.post(
      data: {'name': name, '_method': 'PUT'},
      endPoint: '${EndPoints.brands}/$brandID',
    );
  }

  Future<Response?> deleteBrand({required brandId}) async {
    return _dioFactory.post(
      data: {'_method': 'delete'},
      endPoint: '${EndPoints.brands}/$brandId',
    );
  }

  Future<Response?> getMake({page}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.make}?page=$page'
          : '${EndPoints.make}?data=all',
    );
  }

  Future<Response?> addMake({required name}) async {
    return _dioFactory.post(data: {'name': name}, endPoint: EndPoints.make);
  }

  Future<Response?> updateMake({required makeID, required name}) async {
    return _dioFactory.post(
      data: {'name': name, '_method': 'PUT'},
      endPoint: '${EndPoints.make}/$makeID',
    );
  }

  Future<Response?> deleteMake({required makeID}) async {
    return _dioFactory.post(
      data: {'_method': 'delete'},
      endPoint: '${EndPoints.make}/$makeID',
    );
  }

  Future<Response?> getClientCars({required id}) async {
    return _dioFactory.get(endPoint: '${EndPoints.getClientCars}$id/cars');
  }

  Future<Response?> getCarVisits({required id}) async {
    return _dioFactory.get(endPoint: '${EndPoints.getVisitsCar}$id');
  }

  Future<Response?> getCarMaintenance({required id}) async {
    return _dioFactory.get(endPoint: '${EndPoints.getMaintenanceCar}$id');
  }

  Future<Response?> getCarRequestsMaintenance({page}) async {
    return _dioFactory.get(
      endPoint:
          // isClient?'${EndPoints.getMaintenanceRequestsClient}$clientId':
          '${EndPoints.getMaintenanceRequests}?page=$page',
      // :'${EndPoints.getMaintenanceRequestsTechnician}?page=$page'
    );
  }

  Future<Response?> getCarRequestsMaintenanceTechnician({page}) async {
    return _dioFactory.get(
      endPoint: '${EndPoints.getMaintenanceRequestsTechnician}?page=$page',
    );
  }

  Future<Response?> getCarRequestsMaintenanceClient({page, clientId}) async {
    return _dioFactory.get(
      endPoint: '${EndPoints.getMaintenanceRequestsClient}$clientId',
    );
  }

  Future<Response?> getCarRequestsMaintenanceCar({page, carId}) async {
    return _dioFactory.get(
      endPoint: '${EndPoints.getMaintenanceRequestsCar}$carId',
    );
  }

  Future<Response?> search({text}) async {
    return _dioFactory.get(endPoint: '${EndPoints.search}?search=$text');
  }
  // Future<Response?> getInvoiceDetails({invoiceId}) async {
  //   return _dioFactory.get(
  //     endPoint:'${EndPoints.getInvoiceDetails}$invoiceId',
  //   );
  // }

  Future<Response?> getRequestDetails({required String id}) async {
    return _dioFactory.get(endPoint: '${EndPoints.getRequestDetails}$id');
  }

  Future<Response?> updateRequestStatus({
    required bool isMaintenance,
    required String id,
    // required String desc,
    required String status,
  }) async {
    return _dioFactory.post(
      endPoint: isMaintenance
          ? '${EndPoints.getRequestDetails}$id'
          : '${EndPoints.updateRequest}$id',
      data: {
        'status': status,
        // 'desc': desc,
        '_method': 'PUT',
      },
    );
  }

  Future<Response?> deleteRequest({required requestId}) async {
    return _dioFactory.post(
      data: {'_method': 'delete'},
      endPoint: '${EndPoints.getMaintenanceCar}$requestId',
    );
  }

  Future<Response?> addRequest({
    required carId,
    required serviceIds,
    required meterReading,
    required meterTypeCustom,
  }) async {
    return _dioFactory.post(
      data: {
        'entity_id': carId,
        'services': serviceIds,
        'meter_reading': meterReading,
        'meter_type_custom': meterTypeCustom,
      },
      endPoint: EndPoints.addRequest,
    );
  }

  Future<Response?> getChatList({page}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.chatList}?page=$page'
          : '${EndPoints.chatList}?data=all',
    );
  }

  Future<Response?> getChatDetails({page, required userId}) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.chatDetails}$userId?page=$page'
          : '${EndPoints.chatDetails}$userId?data=all',
    );
  }

  Future<Response?> sendMessage({
    required receiverId,
    messageText,
    image,
  }) async {
    return _dioFactory.postWithImage(
      endPoint: EndPoints.sendMessage,
      data: messageText != null
          ? {'body': messageText, 'receiver_id': receiverId}
          : {'receiver_id': receiverId},
      imageFile: image,
    );
  }
  Future<Response?> getServiceRecord({
    required String clientId,
    int? page,
  }) async {
    return _dioFactory.get(
      endPoint: page != null
          ? '${EndPoints.getMaintenanceRequestsClient}$clientId?page=$page'
          : '${EndPoints.getMaintenanceRequestsClient}$clientId',
    );
  }

}
