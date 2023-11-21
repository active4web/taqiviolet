class CartLocalModel {
  List<CartProducts>? cartProducts;
  CartLocalModel({this.cartProducts});

  CartLocalModel.fromJson(dynamic json) {
    if (json['product_list'] != null) {
      cartProducts = <CartProducts>[];
      json['product_list'].forEach((v) {
        cartProducts!.add(new CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final cartProducts = this.cartProducts;
    if (cartProducts != null) {
      data['product_list'] = cartProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProducts {
  dynamic price;
  dynamic productId;
  int? quantity;
  dynamic isFav;
  bool? withSmartFeature;
  dynamic smartPrice;
  dynamic productName;
  dynamic productImage;
  dynamic onePiecePrice;
  dynamic features;

  dynamic oneProdctPrice;

  CartProducts(
      {this.productId,
      this.productName,
      this.quantity,
      this.price,
      this.withSmartFeature,
      this.smartPrice,
      this.isFav,
      this.productImage,
      this.onePiecePrice,
      this.features,
        this.oneProdctPrice
      });

  CartProducts.fromJson(dynamic json)  {
    productName = json['product_name'];
    productId = json['prod_id'];
    productImage = json['product_image'];
    quantity = json['prod_qty'];
    price = json['total_price'];
    isFav = json['favorite_key'];
    withSmartFeature = json['has_smart'];
    smartPrice = json['smart_price'];
    onePiecePrice = json['prod_price'];
    features = json['prod_fearture'];
    oneProdctPrice = json['one_prodct_price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['prod_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['prod_qty'] = this.quantity;
    data['total_price'] = this.price;
    data['favorite_key'] = this.isFav;
    data['has_smart'] = this.withSmartFeature;
    data['smart_price'] = this.smartPrice;
    data['prod_price'] = this.onePiecePrice;
    data['prod_fearture'] = this.features;
    data['one_prodct_price'] = this.oneProdctPrice;
    return data;
  }
}
