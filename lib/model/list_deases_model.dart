// ignore_for_file: non_constant_identifier_names

// import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// class ListDiseasesModel {
//   final String id_benh;
//   final String tenbenh;
//   final String hinhanh;
//   final String trieuchung;
//   final String nguyennhan;
//   final String phongngua;
//   final String noidung;
//   final String id_loaibenh;
//   final String tenrieng;

//   ListDiseasesModel({
//     required this.id_benh,
//     required this.tenbenh,
//     required this.hinhanh,
//     required this.trieuchung,
//     required this.nguyennhan,
//     required this.phongngua,
//     required this.noidung,
//     required this.id_loaibenh,
//     required this.tenrieng,
//   });

//   ListDiseasesModel copyWith({
//     String? id_benh,
//     String? tenbenh,
//     String? hinhanh,
//     String? trieuchung,
//     String? nguyennhan,
//     String? phongngua,
//     String? noidung,
//     String? id_loaibenh,
//     String? tenrieng,
//   }) {
//     return ListDiseasesModel(
//       id_benh: id_benh ?? this.id_benh,
//       tenbenh: tenbenh ?? this.tenbenh,
//       hinhanh: hinhanh ?? this.hinhanh,
//       trieuchung: trieuchung ?? this.trieuchung,
//       nguyennhan: nguyennhan ?? this.nguyennhan,
//       phongngua: phongngua ?? this.phongngua,
//       noidung: noidung ?? this.noidung,
//       id_loaibenh: id_loaibenh ?? this.id_loaibenh,
//       tenrieng: tenrieng ?? this.tenrieng,
//     );
//   }

//   @override
//   List<Object> get props => [
//         id_benh,
//         tenbenh,
//         hinhanh,
//         trieuchung,
//         nguyennhan,
//         phongngua,
//         noidung,
//         id_loaibenh,
//         tenrieng,
//       ];
// }

// class Disease {
//   final int id_benh;
//   final String tenbenh;
//   final String hinhanh;
//   final String trieutrung;
//   final String nguyennhan;
//   final String phongngua;
//   final String noidung;
//   final int id_loaibenh;
//   final String tenrieng;

//   Disease({
//     required this.id_benh,
//     required this.tenbenh,
//     required this.hinhanh,
//     required this.trieutrung,
//     required this.nguyennhan,
//     required this.phongngua,
//     required this.noidung,
//     required this.id_loaibenh,
//     required this.tenrieng,
//   });

//   factory Disease.fromJson(Map<String, String> json) {
//     return Disease(
//       id_benh: json['id_benh'] as int,
//       tenbenh: json['tenbenh'] as String,
//       hinhanh: json['hinhanh'] as String,
//       trieutrung: json['trieutrung'] as String,
//       nguyennhan: json['nguyennhan'] as String,
//       phongngua: json['phongngua'] as String,
//       noidung: json['noidung'] as String,
//       id_loaibenh: json['id_loaibenh'] as int,
//       tenrieng: json['id_benh'] as String,
//     );
//   }
// }

class DiseaseModel {
  int idBenh;
  String tenBenh;
  String hinhAnh;
  String trieuTrung;
  String nguyenNhan;
  String phongNgua;
  String noiDung;
  int idLoaiBenh;
  String tenRieng;

  DiseaseModel({
    required this.idBenh,
    required this.tenBenh,
    required this.hinhAnh,
    required this.trieuTrung,
    required this.nguyenNhan,
    required this.phongNgua,
    required this.noiDung,
    required this.idLoaiBenh,
    required this.tenRieng,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      idBenh: json['id_benh'],
      tenBenh: json['tenbenh'],
      hinhAnh: json['hinhanh'],
      trieuTrung: json['trieutrung'],
      nguyenNhan: json['nguyennhan'],
      phongNgua: json['phongngua'],
      noiDung: json['noidung'],
      idLoaiBenh: json['id_loaibenh'],
      tenRieng: json['tenrieng'],
    );
  }
}
