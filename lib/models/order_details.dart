class OrderDetailsModel {
  bool status;
  String errNum;
  String msg;
  Data data;

  OrderDetailsModel({this.status, this.errNum, this.msg, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  OrderDetails orderDetails;
  List<ListProducts> listProducts;

  Data({this.orderDetails, this.listProducts});

  Data.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? new OrderDetails.fromJson(json['order_details'])
        : null;
    if (json['list_products'] != null) {
      listProducts = new List<ListProducts>();
      json['list_products'].forEach((v) {
        listProducts.add(new ListProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.toJson();
    }
    if (this.listProducts != null) {
      data['list_products'] = this.listProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int id;
  String codeOrder;
  String address;
  num promoCodeValue;
  int deliveryType;
  num deliveryCost;
  num subTotal;
  num total;
  String status;
  String paymentStatus;
  String paymentType;
  String username;
  String userphone;
  String orderDate;
  String deliveryDate;

  OrderDetails(
      {this.id,
      this.codeOrder,
      this.address,
      this.promoCodeValue,
      this.deliveryType,
      this.deliveryCost,
      this.subTotal,
      this.total,
      this.status,
      this.paymentStatus,
      this.paymentType,
      this.username,
      this.userphone,
      this.orderDate,
      this.deliveryDate});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    address = json['address'];
    promoCodeValue = json['promo_code_value'];
    deliveryType = json['delivery_type'];
    deliveryCost = json['delivery_cost'];
    subTotal = json['sub_total'];
    total = json['total'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    username = json['username'];
    userphone = json['userphone'];
    orderDate = json['order_date'];
    deliveryDate = json['delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_order'] = this.codeOrder;
    data['address'] = this.address;
    data['promo_code_value'] = this.promoCodeValue;
    data['delivery_type'] = this.deliveryType;
    data['delivery_cost'] = this.deliveryCost;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['username'] = this.username;
    data['userphone'] = this.userphone;
    data['order_date'] = this.orderDate;
    data['delivery_date'] = this.deliveryDate;
    return data;
  }
}

class ListProducts {
  String name;
  String image;
  int productId;
  num price;
  int productRate;
  int qty;

  ListProducts(
      {this.name,
      this.image,
      this.productId,
      this.price,
      this.productRate,
      this.qty});

  ListProducts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    productId = json['product_id'];
    price = json['price'];
    productRate = json['product_rate'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['product_rate'] = this.productRate;
    data['qty'] = this.qty;
    return data;
  }
}
