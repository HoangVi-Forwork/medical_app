import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class ListDiseasesModel {
  final String id_benh;
  final String tenbenh;
  final String hinhanh;
  final String trieuchung;
  final String nguyennhan;
  final String phongngua;
  final String noidung;
  final String id_loaibenh;
  final String tenrieng;

  ListDiseasesModel({
    required this.id_benh,
    required this.tenbenh,
    required this.hinhanh,
    required this.trieuchung,
    required this.nguyennhan,
    required this.phongngua,
    required this.noidung,
    required this.id_loaibenh,
    required this.tenrieng,
  });

  ListDiseasesModel copyWith({
    String? id_benh,
    String? tenbenh,
    String? hinhanh,
    String? trieuchung,
    String? nguyennhan,
    String? phongngua,
    String? noidung,
    String? id_loaibenh,
    String? tenrieng,
  }) {
    return ListDiseasesModel(
      id_benh: id_benh ?? this.id_benh,
      tenbenh: tenbenh ?? this.tenbenh,
      hinhanh: hinhanh ?? this.hinhanh,
      trieuchung: trieuchung ?? this.trieuchung,
      nguyennhan: nguyennhan ?? this.nguyennhan,
      phongngua: phongngua ?? this.phongngua,
      noidung: noidung ?? this.noidung,
      id_loaibenh: id_loaibenh ?? this.id_loaibenh,
      tenrieng: tenrieng ?? this.tenrieng,
    );
  }

  @override
  List<Object> get props => [
        id_benh,
        tenbenh,
        hinhanh,
        trieuchung,
        nguyennhan,
        phongngua,
        noidung,
        id_loaibenh,
        tenrieng,
      ];
}
