class NewsModel {
  int? idTintuc;
  String? tieuDe;
  String? hinhAnh;
  String? gioiThieu;
  String? noiDung;
  int? idLoaiTinTuc;
  String? thoiGian;
  NewsModel({
    this.idTintuc,
    this.tieuDe,
    this.hinhAnh,
    this.gioiThieu,
    this.noiDung,
    this.idLoaiTinTuc,
    this.thoiGian,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    idTintuc = json['idTintuc'];
    tieuDe = json['tentintuc'];
    hinhAnh = json['hinhanh'];
    gioiThieu = json['gioithieu'];
    noiDung = json['noidung'];
    idLoaiTinTuc = json['idLoaitintuc'];
    thoiGian = json['thoigian'];
  }
}
