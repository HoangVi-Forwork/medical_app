class DiseasesModel {
  int? idBenh;
  String? tenBenh;
  String? hinhAnh;
  String? trieuChung;
  String? nguyenNhan;
  String? phongNgua;
  String? noiDung;
  int? idLoaiBenh;
  String? tenRieng;

  DiseasesModel({
    this.idBenh,
    this.tenBenh,
    this.hinhAnh,
    this.trieuChung,
    this.nguyenNhan,
    this.phongNgua,
    this.noiDung,
    this.idLoaiBenh,
    this.tenRieng,
  });

  DiseasesModel.fromJson(Map<String, dynamic> json) {
    idBenh = json['idBenh'];
    tenBenh = json['tenbenh'];
    hinhAnh = json['hinhanh'];
    trieuChung = json['trieuchung'];
    nguyenNhan = json['nguyennhan'];
    phongNgua = json['phongngua'];
    noiDung = json['noidung'];
    idLoaiBenh = json['idLoaibenh'];
    tenRieng = json['tenrieng'];
  }
}
