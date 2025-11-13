import 'package:quick_cars_service/barrel.dart';

class CarMaintenanceModel {
  int? code;
  String? message;
  List<CarService>? carServices;
  Meta? meta;
  Links? links;

  CarMaintenanceModel({
    this.code,
    this.message,
    this.carServices,
    this.meta,
    this.links,
  });

  CarMaintenanceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      carServices = <CarService>[];
      json['data'].forEach((v) {
        carServices!.add(CarService.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (carServices != null) {
      data['data'] = carServices!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class CarService {
  int? id;
  String? serviceName;
  String? serviceDesc;
  String? status;
  String? desc;
  String? createdAt;

  CarService({
    this.id,
    this.serviceName,
    this.serviceDesc,
    this.status,
    this.desc,
    this.createdAt,
  });

  CarService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    serviceDesc = json['service_desc'];
    status = json['status'];
    desc = json['desc'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_name'] = serviceName;
    data['service_desc'] = serviceDesc;
    data['status'] = status;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    return data;
  }
}
