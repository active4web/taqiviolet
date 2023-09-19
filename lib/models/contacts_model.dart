class ContactsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<ContactsData>? data;

  ContactsModel({this.status, this.errNum, this.msg, this.data});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ContactsData>[];
      json['data'].forEach((v) {
        data!.add(new ContactsData.fromJson(v));
      });
    }
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['status'] = this.status;
//   data['errNum'] = this.errNum;
//   data['msg'] = this.msg;
//   if (this.data != null) {
//     data['data'] = this.data.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class ContactsData {
  int? iD;
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  String? address;
  String? details;
  String? replacement;
  String? judgments;
  String? phone;
  String? image;
  String? location;

  ContactsData(
      {this.iD,
      this.facebookLink,
      this.instagramLink,
      this.twitterLink,
      this.address,
      this.details,
      this.replacement,
      this.judgments,
      this.phone,
      this.image,
      this.location});

  ContactsData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    facebookLink = json['Facebook-link'];
    instagramLink = json['Instagram-link'];
    twitterLink = json['Twitter-link'];
    address = json['Address'];
    details = json['Details'];
    replacement = json['Replacement'];
    judgments = json['Judgments'];
    phone = json['Phone'];
    image = json['Image'];
    location = json['Location'];
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['ID'] = this.iD;
//   data['Facebook-link'] = this.facebookLink;
//   data['Instagram-link'] = this.instagramLink;
//   data['Twitter-link'] = this.twitterLink;
//   data['Address'] = this.address;
//   data['Details'] = this.details;
//   data['Replacement'] = this.replacement;
//   data['Judgments'] = this.judgments;
//   data['Phone'] = this.phone;
//   data['Image'] = this.image;
//   data['Location'] = this.location;
//   return data;
// }
}
