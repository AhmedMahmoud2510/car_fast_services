class MaintenanceResponse {
  final int code;
  final String message;
  final List<MaintenanceRequest> data;
  final Meta meta;
  final Links links;

  MaintenanceResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.meta,
    required this.links,
  });
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
      'links': links.toJson(),
    };
  }

  factory MaintenanceResponse.fromJson(Map<String, dynamic> json) {
    return MaintenanceResponse(
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => MaintenanceRequest.fromJson(e))
          .toList(),
      meta: Meta.fromJson(json['meta']),
      links: Links.fromJson(json['links']),
    );
  }
}

class MaintenanceRequest {
  final int id;
  final String? uuid;
  final String status;
  final String? meterReading;
  final String? meterNext;
  final String paymentType;
  final String cashAmount;
  final String visaAmount;
  final String? discount;
  final String totalAmount;
  final String? qrCode;
  final Technician? technician;
  final Car car;
  final List<MaintenanceItem> maintenances;
  final String createdAt;

  MaintenanceRequest({
    required this.id,
    this.uuid,
    required this.status,
    this.meterReading,
    this.meterNext,
    required this.paymentType,
    required this.cashAmount,
    required this.visaAmount,
    this.discount,
    required this.totalAmount,
    this.qrCode,
    this.technician,
    required this.car,
    required this.maintenances,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'status': status,
      'meter_reading': meterReading,
      'meter_next': meterNext,
      'payment_type': paymentType,
      'cash_amount': cashAmount,
      'visa_amount': visaAmount,
      'discount': discount,
      'total_amount': totalAmount,
      'qr_code': qrCode,
      'technician': technician?.toJson(),
      'car': car.toJson(),
      'maintenances': maintenances.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
    };
  }

  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequest(
      id: json['id'],
      uuid: json['uuid'],
      status: json['status'],
      meterReading: json['meter_reading'],
      meterNext: json['meter_next'],
      paymentType: json['payment_type'],
      cashAmount: json['cash_amount'],
      visaAmount: json['visa_amount'],
      discount: json['discount'],
      totalAmount: json['total_amount'],
      qrCode: json['qr_code'],
      technician: json['technician'] != null
          ? Technician.fromJson(json['technician'])
          : null,
      car: Car.fromJson(json['car']),
      maintenances: (json['maintenances'] as List)
          .map((e) => MaintenanceItem.fromJson(e))
          .toList(),
      createdAt: json['created_at'],
    );
  }
}

class Technician {
  final int id;
  final String name;
  final String phone;
  final String role;

  Technician({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'role': role,
  };

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}

class Car {
  final int id;
  final Customer customer;
  final Make make;
  final ModelCar model;
  final String plateNo;
  final String chassisNo;
  final String madeYear;

  Car({
    required this.id,
    required this.customer,
    required this.make,
    required this.model,
    required this.plateNo,
    required this.chassisNo,
    required this.madeYear,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer': customer.toJson(),
    'make': make.toJson(),
    'model': model.toJson(),
    'plate_no': plateNo,
    'chassis_no': chassisNo,
    'made_year': madeYear,
  };

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      make: Make.fromJson(json['make']),
      model: ModelCar.fromJson(json['model']),
      plateNo: json['plate_no'],
      chassisNo: json['chassis_no'],
      madeYear: json['made_year'],
    );
  }
}

class Customer {
  final int id;
  final String name;
  final String phone;
  final String role;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'role': role,
  };

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}

class Make {
  final int id;
  final String name;

  Make({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory Make.fromJson(Map<String, dynamic> json) {
    return Make(id: json['id'], name: json['name']);
  }
}

class ModelCar {
  final int id;
  final String name;

  ModelCar({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory ModelCar.fromJson(Map<String, dynamic> json) {
    return ModelCar(id: json['id'], name: json['name']);
  }
}

class MaintenanceItem {
  final int id;
  final String unitPriceIncludeTax;
  final String unitPriceBeforeTax;
  final String? unitPrice;
  final String qty;
  final String discount;
  final String totalPriceBeforeTax;
  final String totalPriceIncludeTax;
  final String? totalPrice;
  final String taxAmount;
  final String status;
  final Product product;

  MaintenanceItem({
    required this.id,
    required this.unitPriceIncludeTax,
    required this.unitPriceBeforeTax,
    this.unitPrice,
    required this.qty,
    required this.discount,
    required this.totalPriceBeforeTax,
    required this.totalPriceIncludeTax,
    this.totalPrice,
    required this.taxAmount,
    required this.status,
    required this.product,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_price_include_tax': unitPriceIncludeTax,
      'unit_price_before_tax': unitPriceBeforeTax,
      'unit_price': unitPrice,
      'qty': qty,
      'discount': discount,
      'total_price_before_tax': totalPriceBeforeTax,
      'total_price_include_tax': totalPriceIncludeTax,
      'total_price': totalPrice,
      'tax_amount': taxAmount,
      'status': status,
      'product': product.toJson(),
    };
  }

  factory MaintenanceItem.fromJson(Map<String, dynamic> json) {
    return MaintenanceItem(
      id: json['id'],
      unitPriceIncludeTax: json['unit_price_include_tax'],
      unitPriceBeforeTax: json['unit_price_before_tax'],
      unitPrice: json['unit_price'],
      qty: json['qty'],
      discount: json['discount'],
      totalPriceBeforeTax: json['total_price_before_tax'],
      totalPriceIncludeTax: json['total_price_include_tax'],
      totalPrice: json['total_price'],
      taxAmount: json['tax_amount'],
      status: json['status'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String price;
  final ProductGroup group;
  final Unit uom;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.group,
    required this.uom,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'group': group.toJson(),
    'uom_id': uom.toJson(),
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      group: ProductGroup.fromJson(json['group']),
      uom: Unit.fromJson(json['uom_id']),
    );
  }
}

class ProductGroup {
  final int id;
  final String name;

  ProductGroup({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(id: json['id'], name: json['name']);
  }
}

class Unit {
  final int id;
  final String name;

  Unit({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(id: json['id'], name: json['name']);
  }
}

class Meta {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;

  Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  Map<String, dynamic> toJson() => {
    'total': total,
    'per_page': perPage,
    'current_page': currentPage,
    'last_page': lastPage,
  };

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
    );
  }
}

class Links {
  final String self;
  final String? next;
  final String? prev;

  Links({required this.self, this.next, this.prev});

  Map<String, dynamic> toJson() => {'self': self, 'next': next, 'prev': prev};

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(self: json['self'], next: json['next'], prev: json['prev']);
  }
}
