// ignore_for_file: public_member_api_docs, sort_constructors_first
class DepartmentModel {
  int? idKhoa;
  String? tenKhoa;
  String? noiDung;

  DepartmentModel({
    required this.idKhoa,
    required this.tenKhoa,
    required this.noiDung,
  });

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    idKhoa = json['id_khoabenh'];
    tenKhoa = json['tenkhoa'];
    noiDung = json['noidung'];
  }
}
