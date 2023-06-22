// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List<String> selectedDepartment = [
  //   'Khoa Tim mạch Can thiệp',
  //   'Khoa Tim mạch tổng quát',
  //   'Khoa Nhịp tim học',
  //   'Hồi sức tim mạch',
  //   'Khoa Phẫu thuật Tim - Lồng ngực mạch máu',
  //   'Khoa Nội Tiêu hóa',
  //   'Khoa Nội Thần kinh tổng quát',
  //   'Khoa Ngoại Thần kinh',
  //   'Khoa Nội tiết',
  //   'Khoa Bệnh lý mạch máu não',
  //   'Khoa Bệnh Nhiệt đới',
  //   'Khoa Cơ xương khớp',
  //   'Khoa Hô hấp - Hồi sức tim mạch',
  //   'Khoa Ngoại Niệu - Ghép thận',
  //   'Khoa Nội Thận - Miễn dịch ghép',
  //   'Khoa Cấp cứu Tổng hợp',
  //   'Khoa Hồi sức tích cực - Chống độc',
  //   'Khoa Gây mê - Hồi sức Ngoại',
  //   'Khoa Ngoại tổng quát',
  //   'Khoa Ngoại Chấn thương chỉnh hình',
  //   'Khoa Tai mũi họng',
  //   'Khoa Răng Hàm Mặt - Mắt',
  //   'Khoa Y học cổ truyền - Phục hồi chức năng',
  //   'Khoa Điều Trị Theo Yêu Cầu - Y Học Thể Thao',
  //   'Khoa Khám bệnh',
  //   'Khoa Khám và Điều trị theo yêu cầu',
  //   'Khoa Xét nghiệm',
  //   'Khoa Chẩn đoán hình ảnh',
  //   'Khoa Giải phẫu bệnh',
  //   'Đơn vị Nội soi',
  //   'Khoa Dinh dưỡng',
  //   'Khoa Kiểm soát nhiễm khuẩn',
  //   'Khoa Dược',
  //   'Khoa Ung bướu và Y học hạt nhân',
  //   'Nhà thuốc',
  //   'Phòng Tổ chức Cán bộ',
  //   'Phòng Kế hoạch Tổng hợp',
  //   'Phòng Điều dưỡng',
  //   'Phòng Chỉ đạo tuyến',
  //   'Phòng Tài chính Kế toán',
  //   'Phòng Hành chính Quản trị',
  //   'Phòng Vật tư - Thiết bị y tế',
  //   'Phòng Công nghệ thông tin',
  //   'Phòng Quản lý chất lượng',
  //   'Phòng Công tác xã hội'
  // ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: Center(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.grey),
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Nhập tìm kiếm",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
