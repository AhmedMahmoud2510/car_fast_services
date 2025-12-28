import 'package:quick_cars_service/barrel.dart';

class RequestDetailsModel {
  int? code;
  String? message;
  List<RequestDetailsDataModel>? data;
  Meta? meta;
  Links? links;

  RequestDetailsModel({
    this.code,
    this.message,
    this.data,
    this.meta,
    this.links,
  });

  RequestDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RequestDetailsDataModel>[];
      json['data'].forEach((v) {
        data!.add(RequestDetailsDataModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class RequestDetailsDataModel {
  int? id;
  String? serviceName;
  String? serviceDesc;
  String? status;
  String? desc;
  String? createdAt;

  RequestDetailsDataModel({
    this.id,
    this.serviceName,
    this.serviceDesc,
    this.status,
    this.desc,
    this.createdAt,
  });

  RequestDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
