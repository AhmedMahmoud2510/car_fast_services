class EndPoints {
  // static const String baseUrl = "https://fast-service.sitksa.online/api/";
  static const String baseUrl = 'https://fast-service.sitksa-eg.com/api/';

  /// Auth
  static const String login = 'login';
  static const String logout = 'logout';
  static const String getProfile = 'users/profile';

  /// Admin
  static const String getServices = 'product';
  static const String deleteService = 'product/';
  static const String updateService = 'product/';

  static const String getUsers = 'users';
  static const String addUser = 'user/create';
  static const String updateUser = 'user/';
  static const String cars = 'car';

  static const String carsSearch = 'cars/search?plate_no';

  static const String brands = 'model';
  static const String make = 'make';

  static const String addRequest = 'maintenance-request/store';
  static const String chatList = 'chat/show';
  static const String chatDetails = 'chat/messages/';
  static const String sendMessage = 'chat/messages/send';

  /// Client
  static const String getClientCars = 'client/';

  static const String getVisitsCar = 'maintenance-request/car/';
  static const String getMaintenanceCar = 'maintenance/request/';

  /// Technician
  static const String getMaintenanceRequests = 'maintenance-request/show-all';
  static const String getMaintenanceRequestsClient =
      'maintenance-request/client/';
  static const String getMaintenanceRequestsCar = 'maintenance-request/car/';
  static const String getMaintenanceRequestsTechnician =
      'maintenance-request/status-open';
  // static const String getInvoiceDetails = "maintenance-requests/print/";

  static const String getRequestDetails = 'maintenance/request/';
  static const String updateRequest = 'maintenance/';
  static const String search = 'maintenance-request/search';
}
