import 'construction_link_model.dart';

class RecommendedProductsModel {
  bool? status;
  String? message;
  List<ProductList>? data;

  RecommendedProductsModel({this.status, this.message, this.data});

  RecommendedProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductList>[];
      json['data'].forEach((v) {
        data!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

