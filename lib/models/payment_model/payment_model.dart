class PaymentModel {
  dynamic? tranTotal;
  BillingDetailsData? billingDetails;
  PaymentResult? paymentResult;
  dynamic? transactionReference;
  dynamic? cartCurrency;
  dynamic? cartDescription;
  dynamic? cartID;
  dynamic? tranCurrency;
  dynamic? payResponseReturn;
  bool? isPending;
  bool? isOnHold;
  dynamic? token;
  dynamic? transactionType;
  bool? isAuthorized;
  dynamic? trace;
  dynamic? cartAmount;
  BillingDetailsData? shippingDetails;
  dynamic? merchantId;
  dynamic? profileId;
  bool? isProcessed;
  dynamic? serviceId;
  PaymentInfo? paymentInfo;

  PaymentModel(
      {this.tranTotal,
        this.billingDetails,
        this.paymentResult,
        this.transactionReference,
        this.cartCurrency,
        this.cartDescription,
        this.cartID,
        this.tranCurrency,
        this.payResponseReturn,
        this.isPending,
        this.isOnHold,
        this.token,
        this.transactionType,
        this.isAuthorized,
        this.trace,
        this.cartAmount,
        this.shippingDetails,
        this.merchantId,
        this.profileId,
        this.isProcessed,
        this.serviceId,
        this.paymentInfo});

  PaymentModel.fromJson(Map<dynamic, dynamic> json) {
    tranTotal = json['tran_total'];
    billingDetails = json['billingDetails'] != null
        ? new BillingDetailsData.fromJson(json['billingDetails'])
        : null;
    paymentResult = json['paymentResult'] != null
        ? new PaymentResult.fromJson(json['paymentResult'])
        : null;
    transactionReference = json['transactionReference'];
    cartCurrency = json['cartCurrency'];
    cartDescription = json['cartDescription'];
    cartID = json['cartID'];
    tranCurrency = json['tran_currency'];
    payResponseReturn = json['payResponseReturn'];
    isPending = json['isPending'];
    isOnHold = json['isOnHold'];
    token = json['token'];
    transactionType = json['transactionType'];
    isAuthorized = json['isAuthorized'];
    trace = json['trace'];
    cartAmount = json['cartAmount'];
    shippingDetails = json['shippingDetails'] != null
        ? new BillingDetailsData.fromJson(json['shippingDetails'])
        : null;
    merchantId = json['merchantId'];
    profileId = json['profileId'];
    isProcessed = json['isProcessed'];
    serviceId = json['serviceId'];
    paymentInfo = json['paymentInfo'] != null
        ? new PaymentInfo.fromJson(json['paymentInfo'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['tran_total'] = this.tranTotal;
    if (this.billingDetails != null) {
      data['billingDetails'] = this.billingDetails!.toJson();
    }
    if (this.paymentResult != null) {
      data['paymentResult'] = this.paymentResult!.toJson();
    }
    data['transactionReference'] = this.transactionReference;
    data['cartCurrency'] = this.cartCurrency;
    data['cartDescription'] = this.cartDescription;
    data['cartID'] = this.cartID;
    data['tran_currency'] = this.tranCurrency;
    data['payResponseReturn'] = this.payResponseReturn;
    data['isPending'] = this.isPending;
    data['isOnHold'] = this.isOnHold;
    data['token'] = this.token;
    data['transactionType'] = this.transactionType;
    data['isAuthorized'] = this.isAuthorized;
    data['trace'] = this.trace;
    data['cartAmount'] = this.cartAmount;
    if (this.shippingDetails != null) {
      data['shippingDetails'] = this.shippingDetails!.toJson();
    }
    data['merchantId'] = this.merchantId;
    data['profileId'] = this.profileId;
    data['isProcessed'] = this.isProcessed;
    data['serviceId'] = this.serviceId;
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.toJson();
    }
    return data;
  }
}

class BillingDetailsData {
  dynamic? addressLine;
  dynamic? city;
  dynamic? countryCode;
  dynamic? email;
  dynamic? name;
  dynamic? phone;
  dynamic? zip;

  BillingDetailsData(
      {this.addressLine,
        this.city,
        this.countryCode,
        this.email,
        this.name,
        this.phone,
        this.zip});

  BillingDetailsData.fromJson(Map<dynamic, dynamic> json) {
    addressLine = json['addressLine'];
    city = json['city'];
    countryCode = json['countryCode'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    zip = json['zip'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['addressLine'] = this.addressLine;
    data['city'] = this.city;
    data['countryCode'] = this.countryCode;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['zip'] = this.zip;
    return data;
  }
}

class PaymentResult {
  dynamic? responseCode;
  dynamic? responseMessage;
  dynamic? responseStatus;
  dynamic? transactionTime;

  PaymentResult(
      {this.responseCode,
        this.responseMessage,
        this.responseStatus,
        this.transactionTime});

  PaymentResult.fromJson(Map<dynamic, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    responseStatus = json['responseStatus'];
    transactionTime = json['transactionTime'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['responseStatus'] = this.responseStatus;
    data['transactionTime'] = this.transactionTime;
    return data;
  }
}

class PaymentInfo {
  dynamic? cardScheme;
  dynamic? cardType;
  dynamic? expiryMonth;
  dynamic? expiryYear;
  dynamic? paymentDescription;
  dynamic? paymentMethod;

  PaymentInfo(
      {this.cardScheme,
        this.cardType,
        this.expiryMonth,
        this.expiryYear,
        this.paymentDescription,
        this.paymentMethod});

  PaymentInfo.fromJson(Map<dynamic, dynamic> json) {
    cardScheme = json['cardScheme'];
    cardType = json['cardType'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    paymentDescription = json['paymentDescription'];
    paymentMethod = json['payment_method'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['cardScheme'] = this.cardScheme;
    data['cardType'] = this.cardType;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;
    data['paymentDescription'] = this.paymentDescription;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}