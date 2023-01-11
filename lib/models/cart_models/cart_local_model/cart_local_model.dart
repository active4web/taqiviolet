class CartLocalModel {
  List<CartProducts> cartProducts;
  CartLocalModel({this.cartProducts});
  CartLocalModel.fromJson(dynamic json) {
    if (json['cart_products'] != null) {
      cartProducts = <CartProducts>[];
      json['cart_products'].forEach((v) {
        cartProducts.add(new CartProducts.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartProducts != null) {
      data['cart_products'] = this.cartProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProducts {
  int price;
  int productId;
  int quantity;
  int isFav;
  bool withSmartFeature;
  int smartPrice;
  String productName;
  String productImage;
  CartProducts(
      {this.productId,
      this.productName,
      this.quantity,
      this.price,
      this.withSmartFeature,
      this.smartPrice,
      this.isFav,
      this.productImage});
  CartProducts.fromJson(dynamic json) {
    productName = json['product_name'];
    productId = json['product_id'];
    productImage = json['product_image'];
    quantity = json['product_quantity'];
    price = json['total_price'];
    isFav = json['favorite_key'];
    withSmartFeature = json['has_smart'];
    smartPrice = json['smart_price'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['product_quantity'] = this.quantity;
    data['total_price'] = this.price;
    data['favorite_key'] = this.isFav;
    data['has_smart'] = this.withSmartFeature;
    data['smart_price'] = this.smartPrice;
    return data;
  }
}
