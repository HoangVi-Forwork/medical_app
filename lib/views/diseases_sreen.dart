//! từ branch "dev", tạo ra một branch mới tên là: feature/creatListDiseaseScreen
//! sao đó copy từ đoạn code ở bên dưới này, tạo ra một file mới trong thư mục views với tên là diseases_sreen.dart rồi pass cái này

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListDiseaseScreen extends StatefulWidget {
  const ListDiseaseScreen({super.key});

  @override
  State<ListDiseaseScreen> createState() => _ListDiseaseScreenState();
}

class _ListDiseaseScreenState extends State<ListDiseaseScreen> {
  String selectedKhoa = 'Khoa Tim mạch Can thiệp';

  List<String> diseases = [
    'Ho',
    'Sổ mũi',
    'Tai biến',
    'Đau bụng',
    'Viêm họng',
    'Tiểu đường',
    'Sỏi thận',
    'Đau lưng',
    'Tiêm kích ốm',
    'Bệnh Parkinson',
    'Tim mạch',
    'Hen suyễn',
    'Bệnh cúm',
    'Viêm gan',
    'Gút',
    'Rối loạn tiền đình',
    'Bệnh giảm trí nhớ',
    'U xơ tử cung',
    'Loét dạ dày',
    'Bệnh tăng huyết áp',
    'Bệnh Nhiệt đới',
    'Cơ xương khớp',
    'Hô hấp - Hồi sức tim mạch',
    'Ngoại Niệu - Ghép thận',
    'Nội Thận - Miễn dịch ghép',
    'Cấp cứu Tổng hợp',
    'Hồi sức tích cực - Chống độc',
    'Gây mê - Hồi sức Ngoại',
    'Ngoại tổng quát',
    'Ngoại Chấn thương chỉnh hình',
    'Tai mũi họng',
    'Răng Hàm Mặt - Mắt',
    'Y học cổ truyền - Phục hồi chức năng',
    'Điều Trị Theo Yêu Cầu - Y Học Thể Thao',
    'Khám bệnh',
    'Khám và Điều trị theo yêu cầu',
    'Xét nghiệm',
    'Chẩn đoán hình ảnh',
    'Giải phẫu bệnh',
    'Đơn vị Nội soi',
    'Dinh dưỡng',
    'Kiểm soát nhiễm khuẩn',
    'Dược',
    'Ung bướu và Y học hạt nhân',
  ];

  List<String> randomImages = [
    'https://i.pinimg.com/564x/94/f9/a9/94f9a9ba726f02d1f31b93af34ed54fe.jpg',
    'https://i.pinimg.com/564x/dc/12/d5/dc12d54d41986093d93af47099cf56b3.jpg',
    'https://i.pinimg.com/564x/44/f3/cd/44f3cdc65693321df4629fa9e66df86e.jpg',
    'https://i.pinimg.com/564x/1f/1c/17/1f1c173d0e15c4fa8b8e35cead32a37d.jpg',
  ];

  List<String> departments = [
    'Khoa Tim mạch Can thiệp',
    'Khoa Tim mạch tổng quát',
    'Khoa Nhịp tim học',
    'Hồi sức tim mạch',
    'Khoa Phẫu thuật Tim - Lồng ngực mạch máu',
    'Khoa Nội Tiêu hóa',
    'Khoa Nội Thần kinh tổng quát',
    'Khoa Ngoại Thần kinh',
    'Khoa Nội tiết',
    'Khoa Bệnh lý mạch máu não',
    'Khoa Bệnh Nhiệt đới',
    'Khoa Cơ xương khớp',
    'Khoa Hô hấp - Hồi sức tim mạch',
    'Khoa Ngoại Niệu - Ghép thận',
    'Khoa Nội Thận - Miễn dịch ghép',
    'Khoa Cấp cứu Tổng hợp',
    'Khoa Hồi sức tích cực - Chống độc',
    'Khoa Gây mê - Hồi sức Ngoại',
    'Khoa Ngoại tổng quát',
    'Khoa Ngoại Chấn thương chỉnh hình',
    'Khoa Tai mũi họng',
    'Khoa Răng Hàm Mặt - Mắt',
    'Khoa Y học cổ truyền - Phục hồi chức năng',
    'Khoa Điều Trị Theo Yêu Cầu - Y Học Thể Thao',
    'Khoa Khám bệnh',
    'Khoa Khám và Điều trị theo yêu cầu',
    'Khoa Xét nghiệm',
    'Khoa Chẩn đoán hình ảnh',
    'Khoa Giải phẫu bệnh',
    'Đơn vị Nội soi',
    'Khoa Dinh dưỡng',
    'Khoa Kiểm soát nhiễm khuẩn',
    'Khoa Dược',
    'Khoa Ung bướu và Y học hạt nhân',
  ];

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bệnh'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedKhoa,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedKhoa = newValue!;
                  });
                },
                items: departments.map((khoa) {
                  return DropdownMenuItem(
                    value: khoa,
                    child: Text(khoa),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: diseases.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return DiseaseItem(
                    name: diseases[index],
                    image: randomImages[random.nextInt(randomImages.length)],
                    department: departments[random.nextInt(departments.length)],
                    ageGroup: 'Lứa tuổi dễ mắc phải nhất',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiseaseItem extends StatelessWidget {
  final String name;
  final String image;
  final String department;
  final String ageGroup;

  const DiseaseItem({
    required this.name,
    required this.image,
    required this.department,
    required this.ageGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Thuộc khoa: $department',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
