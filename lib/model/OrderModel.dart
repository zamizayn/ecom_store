import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartstore/model/AddressModel.dart';
import 'package:emartstore/model/OrderProductModel.dart';
import 'package:emartstore/model/ProductModel.dart';
import 'package:emartstore/model/TaxModel.dart';
import 'package:emartstore/model/User.dart';
import 'package:emartstore/model/VendorModel.dart';

class OrderModel {
  String authorID, payment_method;

  User author;

  User? driver;

  String? driverID;

  List<OrderProductModel> products;

  Timestamp createdAt;
  bool payment_shared = false;
  String vendorID;
  String sectionId;

  VendorModel vendor;

  String status;

  AddressModel address;

  String id;
  num? discount;
  String? couponCode;
  String? couponId, notes;

  // var extras = [];
  //String? extra_size;
  String? tipValue;
  String? adminCommission;
  String? adminCommissionType;
  final bool? takeAway;

  String? deliveryCharge;
  TaxModel? taxModel;
  Map<String, dynamic>? specialDiscount;

  String courierCompanyName;
  String courierTrackingId;

  String deliveryAddress() => '${this.address.line1} ${this.address.line2} ${this.address.city} '
      '${this.address.postalCode}';

  OrderModel(
      {address,
        author,
        this.driver,
        this.driverID,
        this.authorID = '',
        this.payment_method = '',
        createdAt,
        this.id = '',
        this.products = const [],
        this.status = '',
        this.discount = 0,
        this.payment_shared = false,
        this.couponCode = '',
        this.couponId = '',
        this.notes = '',
        vendor,
        /*this.extras = const [], this.extra_size,*/ this.tipValue,
        this.adminCommission,
        this.takeAway = false,
        this.adminCommissionType,
        this.deliveryCharge,
        this.vendorID = '',
        this.sectionId = '',
        this.courierCompanyName = '',
        this.courierTrackingId = '',
        this.specialDiscount,
        taxModel})
      : address = address ?? AddressModel(),
        author = author ?? User(),
        createdAt = createdAt ?? Timestamp.now(),
        vendor = vendor ?? VendorModel(),
        taxModel = taxModel;

  factory OrderModel.fromJson(Map<String, dynamic> parsedJson) {
    List<OrderProductModel> products = parsedJson.containsKey('products')
        ? List<OrderProductModel>.from((parsedJson['products'] as List<dynamic>).map((e) => OrderProductModel.fromJson(e))).toList()
        : [].cast<OrderProductModel>();

    num discountVal = 0;
    if (parsedJson['discount'] == null || parsedJson['discount'] == double.nan) {
      discountVal = 0;
    } else if (parsedJson['discount'] is String) {
      discountVal = double.parse(parsedJson['discount']);
    } else {
      discountVal = parsedJson['discount'];
    }
    return OrderModel(
      address: parsedJson.containsKey('address') ? AddressModel.fromJson(parsedJson['address']) : AddressModel(),
      author: parsedJson.containsKey('author') ? User.fromJson(parsedJson['author']) : User(),
      authorID: parsedJson['authorID'] ?? '',
      createdAt: parsedJson['createdAt'] ?? Timestamp.now(),
      id: parsedJson['id'] ?? '',
      products: products,
      status: parsedJson['status'] ?? '',
      discount: discountVal,
      couponCode: parsedJson['couponCode'] ?? '',
      couponId: parsedJson['couponId'] ?? '',
      notes: (parsedJson["notes"] != null && parsedJson["notes"].toString().isNotEmpty) ? parsedJson["notes"] : "",
      vendor: parsedJson.containsKey('vendor') ? VendorModel.fromJson(parsedJson['vendor']) : VendorModel(),
      vendorID: parsedJson['vendorID'] ?? '',
      sectionId: parsedJson['section_id'] ?? '',
      driver: parsedJson.containsKey('driver') ? User.fromJson(parsedJson['driver']) : null,
      driverID: parsedJson.containsKey('driverID') ? parsedJson['driverID'] : null,
      adminCommission: parsedJson["adminCommission"] ?? "",
      adminCommissionType: parsedJson["adminCommissionType"] ?? "",
      tipValue: parsedJson["tip_amount"] ?? "",
      takeAway: parsedJson["takeAway"] ?? false,
      payment_method: parsedJson['payment_method'] ?? '',
      payment_shared: parsedJson['payment_shared'] ?? true,
      taxModel: (parsedJson.containsKey('taxSetting') && parsedJson['taxSetting'] != null) ? TaxModel.fromJson(parsedJson['taxSetting']) : null,
      //extras: parsedJson["extras"]!=null?parsedJson["extras"]:[],
      // extra_size: parsedJson["extras_price"]!=null?parsedJson["extras_price"]:"",
      deliveryCharge: parsedJson["deliveryCharge"],
      courierCompanyName: parsedJson["courierCompanyName"]??'',
      courierTrackingId: parsedJson["courierTrackingId"]??'',
      specialDiscount: parsedJson["specialDiscount"] ?? {},

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'author': author.toJson(),
      'authorID': authorID,
      'payment_method': payment_method,
      'createdAt': createdAt,
      'id': id,
      'products': products.map((e) => e.toJson()).toList(),
      'status': status,
      'discount': discount,
      'couponCode': couponCode,
      'couponId': couponId,
      'notes': notes,
      'payment_shared': payment_shared,
      'vendor': vendor.toJson(),
      'vendorID': vendorID,
      'section_id': sectionId,
      'adminCommission': adminCommission,
      'adminCommissionType': adminCommissionType,
      "tip_amount": tipValue,
      if (taxModel != null) "taxSetting": taxModel!.toJson(),
      // "extras":this.extras,
      //"extras_price":this.extra_size,
      "takeAway": takeAway,
      "deliveryCharge": deliveryCharge,
      "specialDiscount": specialDiscount,
      "courierCompanyName": courierCompanyName,
      "courierTrackingId": courierTrackingId,

    };
  }
}