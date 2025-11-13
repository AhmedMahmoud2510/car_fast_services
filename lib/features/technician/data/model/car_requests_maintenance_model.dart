import 'package:quick_cars_service/barrel.dart';

class CarMaintenanceRequestsModel {
  int? code;
  String? message;
  List<Data>? data;
  Meta? meta;
  Links? links;

  CarMaintenanceRequestsModel({
    this.code,
    this.message,
    this.data,
    this.meta,
    this.links,
  });

  CarMaintenanceRequestsModel.fromJson(Map<String, dynamic> json) {
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
  String? uuid;
  String? status;
  String? meterReading;
  String? meterNext;
  String? paymentType;
  String? cashAmount;
  String? visaAmount;
  String? discount;
  String? totalAmount;
  String? qrCode;
  Technician? technician;
  Car? car;
  List<Maintenances>? maintenances;
  String? createdAt;

  Data({
    this.id,
    this.uuid,
    this.status,
    this.meterReading,
    this.meterNext,
    this.paymentType,
    this.cashAmount,
    this.visaAmount,
    this.discount,
    this.totalAmount,
    this.qrCode,
    this.technician,
    this.car,
    this.maintenances,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    status = json['status'];
    meterReading = json['meter_reading'];
    meterNext = json['meter_next'];
    paymentType = json['payment_type'];
    cashAmount = json['cash_amount'];
    visaAmount = json['visa_amount'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    qrCode = json['qr_code'];
    technician = json['technician'] != null
        ? Technician.fromJson(json['technician'])
        : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    if (json['maintenances'] != null) {
      maintenances = <Maintenances>[];
      json['maintenances'].forEach((v) {
        maintenances!.add(Maintenances.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['status'] = status;
    data['meter_reading'] = meterReading;
    data['meter_next'] = meterNext;
    data['payment_type'] = paymentType;
    data['cash_amount'] = cashAmount;
    data['visa_amount'] = visaAmount;
    data['discount'] = discount;
    data['total_amount'] = totalAmount;
    data['qr_code'] = qrCode;
    if (technician != null) {
      data['technician'] = technician!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (maintenances != null) {
      data['maintenances'] = maintenances!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Technician {
  int? id;
  String? name;
  String? phone;
  String? role;

  Technician({this.id, this.name, this.phone, this.role});

  Technician.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['role'] = role;
    return data;
  }
}

class Car {
  int? id;
  Technician? customer;
  Make? make;
  Make? model;
  String? plateNo;
  String? chassisNo;
  String? madeYear;

  Car({
    this.id,
    this.customer,
    this.make,
    this.model,
    this.plateNo,
    this.chassisNo,
    this.madeYear,
  });

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? Technician.fromJson(json['customer'])
        : null;
    make = json['make'] != null ? Make.fromJson(json['make']) : null;
    model = json['model'] != null ? Make.fromJson(json['model']) : null;
    plateNo = json['plate_no'];
    chassisNo = json['chassis_no'];
    madeYear = json['made_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (make != null) {
      data['make'] = make!.toJson();
    }
    if (model != null) {
      data['model'] = model!.toJson();
    }
    data['plate_no'] = plateNo;
    data['chassis_no'] = chassisNo;
    data['made_year'] = madeYear;
    return data;
  }
}

class Make {
  int? id;
  String? name;

  Make({this.id, this.name});

  Make.fromJson(Map<String, dynamic> json) {
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

class Maintenances {
  int? id;
  String? unitPriceIncludeTax;
  String? unitPriceBeforeTax;
  String? unitPrice;
  String? qty;
  String? discount;
  String? totalPriceBeforeTax;
  String? totalPriceIncludeTax;
  String? totalPrice;
  String? taxAmount;
  String? status;
  Product? product;

  Maintenances({
    this.id,
    this.unitPriceIncludeTax,
    this.unitPriceBeforeTax,
    this.unitPrice,
    this.qty,
    this.discount,
    this.totalPriceBeforeTax,
    this.totalPriceIncludeTax,
    this.totalPrice,
    this.taxAmount,
    this.status,
    this.product,
  });

  Maintenances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitPriceIncludeTax = json['unit_price_include_tax'];
    unitPriceBeforeTax = json['unit_price_before_tax'];
    unitPrice = json['unit_price'];
    qty = json['qty'];
    discount = json['discount'];
    totalPriceBeforeTax = json['total_price_before_tax'];
    totalPriceIncludeTax = json['total_price_include_tax'];
    totalPrice = json['total_price'];
    taxAmount = json['tax_amount'];
    status = json['status'];
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_price_include_tax'] = unitPriceIncludeTax;
    data['unit_price_before_tax'] = unitPriceBeforeTax;
    data['unit_price'] = unitPrice;
    data['qty'] = qty;
    data['discount'] = discount;
    data['total_price_before_tax'] = totalPriceBeforeTax;
    data['total_price_include_tax'] = totalPriceIncludeTax;
    data['total_price'] = totalPrice;
    data['tax_amount'] = taxAmount;
    data['status'] = status;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
