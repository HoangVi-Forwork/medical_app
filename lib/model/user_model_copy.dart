// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel_Copy {
  int? id;
  String? ten;
  String? email;
  String? password;
  String? setpassword;
  String? quyenhan;

  UserModel_Copy({
    this.id,
    this.ten,
    this.email,
    this.password,
    this.setpassword,
    this.quyenhan,
  });

  UserModel_Copy.fromJson(Map<String, dynamic> json) {
    id = json['id_taikhoan'];
    ten = json['ten'];
    email = json['email'];
    password = json['password'];
    setpassword = json['setpassword'];
    quyenhan = json['quyenhan'];
  }

  // @override
  // List<Object> get props => [];
}
