import 'package:quick_cars_service/barrel.dart';

class CarVisitsModel {
  int? code;
  String? message;
  List<Data>? data;
  Meta? meta;
  Links? links;

  CarVisitsModel({this.code, this.message, this.data, this.meta, this.links});

  CarVisitsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  Car? car;
  String? desc;
  String? status;
  String? createdAt;

  Data({this.id, this.car, this.desc, this.status, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    desc = json['desc'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['desc'] = desc;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
