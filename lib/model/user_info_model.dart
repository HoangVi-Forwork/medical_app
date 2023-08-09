// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserInfoModel {
  int? idInfo;
  String? phone;
  String? address;
  int? id;
  String? avata;
  int? sex;

  UserInfoModel(
    this.idInfo,
    this.phone,
    this.address,
    this.id,
    this.avata,
    this.sex,
  );

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    idInfo = json['id_thongtin'];
    phone = json['sdt'];
    address = json['diachi'];
    id = json['id_taikhoan'];
    avata = json['avata'];
    sex = json['gioitinh'];
  }
}

/**
  id_thongtin int AI PK 
  sdt varchar(225) 
  diachi varchar(225) 
  id_taikhoan int 
  avata varchar(300) 
  gioitinh int
*/