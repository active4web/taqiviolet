class PartnerOrdersModel {
  bool? status;
  String? message;
  Data? data;

  PartnerOrdersModel({this.status, this.message, this.data});

  PartnerOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Statistics? statistics;
  Orders? orders;

  Data({this.statistics, this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Statistics {
  String? userCapital;
  String? totalOrders;
  String? expenses;
  String? remain;
  String? profit;
  String? productsQuantities;
  String? usersCount;
  String? visiters;

  Statistics(
      {this.userCapital,
        this.totalOrders,
        this.expenses,
        this.remain,
        this.profit,
        this.productsQuantities,
        this.usersCount,
        this.visiters});

  Statistics.fromJson(Map<String, dynamic> json) {
    userCapital = json['user_capital'];
    totalOrders = json['total_orders'];
    expenses = json['expenses'];
    remain = json['remain'];
    profit = json['profit'];
    productsQuantities = json['products_quantities'];
    usersCount = json['users_count'];
    visiters = json['visiters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_capital'] = this.userCapital;
    data['total_orders'] = this.totalOrders;
    data['expenses'] = this.expenses;
    data['remain'] = this.remain;
    data['profit'] = this.profit;
    data['products_quantities'] = this.productsQuantities;
    data['users_count'] = this.usersCount;
    data['visiters'] = this.visiters;
    return data;
  }
}

class Orders {
  List<Waiting>? waiting;
  List<Waiting>? current;
  List<Waiting>? holding;
  List<Waiting>? old;

  Orders({this.waiting, this.current, this.holding, this.old});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['waiting'] != null) {
      waiting = <Waiting>[];
      json['waiting'].forEach((v) {
        waiting!.add(new Waiting.fromJson(v));
      });
    }
    if (json['current'] != null) {
      current = <Waiting>[];
      json['current'].forEach((v) {
        current!.add(new Waiting.fromJson(v));
      });
    }
    if (json['holding'] != null) {
      holding = <Waiting>[];
      json['holding'].forEach((v) {
        holding!.add(new Waiting.fromJson(v));
      });
    }
    if (json['old'] != null) {
      old = <Waiting>[];
      json['old'].forEach((v) {
        old!.add(new Waiting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.waiting != null) {
      data['waiting'] = this.waiting!.map((v) => v.toJson()).toList();
    }
    if (this.current != null) {
      data['current'] = this.current!.map((v) => v.toJson()).toList();
    }
    if (this.holding != null) {
      data['holding'] = this.holding!.map((v) => v.toJson()).toList();
    }
    if (this.old != null) {
      data['old'] = this.old!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Waiting {
  int? id;
  String? codeOrder;
  double? total;
  String? status;
  String? createdAt;
  int? productsConut;

  Waiting({this.id, this.codeOrder, this.total, this.status, this.createdAt});

  Waiting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    productsConut=json['items_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_order'] = this.codeOrder;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}