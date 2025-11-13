import 'package:quick_cars_service/barrel.dart';

class ProductsModel {
  int? code;
  String? message;
  List<Product>? products;
  Meta? meta;
  Links? links;

  ProductsModel({
    this.code,
    this.message,
    this.products,
    this.meta,
    this.links,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      products = <Product>[];
      json['data'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
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

class Product {
  int? id;
  String? name;
  String? price;
  Group? group;
  Group? uomId;

  Product({this.id, this.name, this.price, this.group, this.uomId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    uomId = json['uom_id'] != null ? Group.fromJson(json['uom_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (uomId != null) {
      data['uom_id'] = uomId!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  String? name;

  Group({this.id, this.name});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
