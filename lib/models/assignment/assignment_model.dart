class AssignmentModel {
  bool? status;
  String? message;
  List<Data>? data;

  AssignmentModel({this.status, this.message, this.data});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? image;
  int? productId;
  String? productName;
  double? productMainprice;
  double? tax;
  int? insurance;
  int? zakat;
  double? profitProduct;
  int? visaPercentage;
  int? advertisingAndDevelopment;
  double? total;
  double? netProfit;
  int? client;
  double? company;
  int? productOldPrice;
  double? productCurrentPrice;
  String? productQuantity;
  int? productQuantityOriginal;
  Null? productSerialNo;
  int? productQuantitySold;
  List<String>? featureName;
  List<String>? featureDescription;

  Data(
      {this.image,
        this.productId,
        this.productName,
        this.productMainprice,
        this.tax,
        this.insurance,
        this.zakat,
        this.profitProduct,
        this.visaPercentage,
        this.advertisingAndDevelopment,
        this.total,
        this.netProfit,
        this.client,
        this.company,
        this.productOldPrice,
        this.productCurrentPrice,
        this.productQuantity,
        this.productQuantityOriginal,
        this.productSerialNo,
        this.productQuantitySold,
        this.featureName,
        this.featureDescription});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    productId = json['product_id'];
    productName = json['product_name'];
    productMainprice = json['product_mainprice'];
    tax = json['tax'];
    insurance = json['insurance'];
    zakat = json['zakat'];
    profitProduct = json['profit_product'];
    visaPercentage = json['visa_percentage'];
    advertisingAndDevelopment = json['advertising_and_development'];
    total = json['total'];
    netProfit = json['net_profit'];
    client = json['client'];
    company = json['company'];
    productOldPrice = json['product_old_price'];
    productCurrentPrice = json['product_current_price'];
    productQuantity = json['product_quantity'];
    productQuantityOriginal = json['product_quantity_original'];
    productSerialNo = json['product_serial_no'];
    productQuantitySold = json['product_quantity_sold'];
    featureName = json['feature_name'].cast<String>();
    featureDescription = json['feature_description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_mainprice'] = this.productMainprice;
    data['tax'] = this.tax;
    data['insurance'] = this.insurance;
    data['zakat'] = this.zakat;
    data['profit_product'] = this.profitProduct;
    data['visa_percentage'] = this.visaPercentage;
    data['advertising_and_development'] = this.advertisingAndDevelopment;
    data['total'] = this.total;
    data['net_profit'] = this.netProfit;
    data['client'] = this.client;
    data['company'] = this.company;
    data['product_old_price'] = this.productOldPrice;
    data['product_current_price'] = this.productCurrentPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_quantity_original'] = this.productQuantityOriginal;
    data['product_serial_no'] = this.productSerialNo;
    data['product_quantity_sold'] = this.productQuantitySold;
    data['feature_name'] = this.featureName;
    data['feature_description'] = this.featureDescription;
    return data;
  }
}