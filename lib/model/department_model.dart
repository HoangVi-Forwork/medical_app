// ignore_for_file: public_member_api_docs, sort_constructors_first
class DepartmentModel {
  int? idKhoa;
  String? tenKhoa;
  String? makhoa;

  DepartmentModel({
    required this.idKhoa,
    required this.tenKhoa,
    required this.makhoa,
  });

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    idKhoa = json['idKhoabenh'];
    tenKhoa = json['tenkhoa'];
    makhoa = json['Makhoa'];
  }
}
