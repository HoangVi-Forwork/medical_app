// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unnecessary_import, duplicate_import, depend_on_referenced_packages, unused_import, library_private_types_in_public_api
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart'; // For RepaintBoundary and RenderRepaintBoundary
import 'package:flutter/services.dart';
import 'package:flutter/services.dart'; // For ImageByteFormat
import 'package:medical_app/views/medical/qr_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the permission_handler package

import 'package:medical_app/widgets/colors.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // String selectedHospital = '';
  // String selectedDepartment = '';
  GlobalKey qrImageKey = GlobalKey();
  String phoneNumber = '';
  String fullName = '';
  String selectedHospital = 'Bệnh viện Chợ Rẫy';
  String selectedDepartment = 'Khoa Nội tiết';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String qrData = "";
  final qrdataFeed = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _showQRDialog() async {
    final random = math.Random();
    final randomCode = String.fromCharCodes(List.generate(10, (index) {
      final isLetter = random.nextBool();
      final codeUnit = isLetter
          ? (random.nextInt(26) + 65) // Random uppercase letter
          : (random.nextInt(10) + 48); // Random digit
      return codeUnit;
    }));
    setState(() {
      qrData =
          'Họ và tên: $fullName\nSố điện thoại: $phoneNumber\nNgày khám: ${selectedDate.toLocal()}\nMã sô: $randomCode';
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: const Text('Mã QR Đăng ký')),
          content: Container(
            width: 260,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QrImage(
                  key: qrImageKey,
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200.0, // Adjust the size of the QR code
                ),
                SizedBox(
                  height: 6,
                ),
                GestureDetector(
                  onTap: () async {
                    final boundary = qrImageKey.currentContext
                        ?.findRenderObject() as RenderRepaintBoundary?;

                    if (boundary != null) {
                      final image = await boundary.toImage();
                      final byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      final Uint8List qrImageBytes =
                          byteData!.buffer.asUint8List();

                      final directory = await getExternalStorageDirectory();
                      if (directory != null) {
                        final imagePath = '${directory.path}/qr_code.png';
                        final imageFile = File(imagePath);
                        await imageFile.writeAsBytes(qrImageBytes);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Mã QR đã được lưu thành công!')),
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              QrCodeScreen(imagePath: imagePath),
                        ));
                      } else {
                        final boundary = qrImageKey.currentContext
                            ?.findRenderObject() as RenderRepaintBoundary?;

                        if (boundary != null) {
                          final image = await boundary.toImage();
                          final byteData = await image.toByteData(
                              format: ImageByteFormat.png);
                          final Uint8List qrImageBytes =
                              byteData!.buffer.asUint8List();

                          final directory = await getExternalStorageDirectory();
                          if (directory != null) {
                            final imagePath = '${directory.path}/qr_code.png';
                            final imageFile = File(imagePath);
                            await imageFile.writeAsBytes(qrImageBytes);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Mã QR đã được lưu thành công!')),
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  QrCodeScreen(imagePath: imagePath),
                            ));
                          } else {
                            print('Trống');
                          }
                        } else {
                          // Xử lý khi boundary là null
                          print('boundary là null');
                        }
                      }
                    } else {
                      // Xử lý khi boundary là null
                    }
                  },
                  child: Icon(
                    Icons.download,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                height: 44,
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    'Đóng',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> saveQrImage(Uint8List qrImageData) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/qr_code.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(qrImageData);
    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Đăng ký lịch khám bệnh'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedHospital,
              onChanged: (newValue) {
                setState(() {
                  selectedHospital = newValue!;
                });
              },
              items: <String>[
                'Bệnh viện Chợ Rẫy',
                'Bệnh viện Bạch Mai',
                'Bệnh viện Việt Đức',
                'Bệnh viện Đại học Y Dược',
                'Bệnh viện Nhi Đồng 1',
                'Bệnh viện Nhi Đồng 2',
                'Bệnh viện Nguyễn Tri Phương',
                'Bệnh viện Trưng Vương',
                'Bệnh viện Thống Nhất',
                'Bệnh viện An Bình',
                'Bệnh viện Quận 2',
                'Bệnh viện Ung Bướu',
                'Bệnh viện Hùng Vương',
                'Bệnh viện Từ Dũ',
                'Bệnh viện 115',
                'Bệnh viện Đa Khoa Trung Ương',
                'Bệnh viện Mắt Sài Gòn',
                'Bệnh viện Tai Mũi Họng TP.HCM',
                'Bệnh viện Răng Hàm Mặt TP.HCM',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('Chọn bệnh viện'),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedDepartment,
              onChanged: (newValue) {
                setState(() {
                  selectedDepartment = newValue!;
                });
              },
              items: <String>[
                'Khoa Nội tiết',
                'Khoa Nhi',
                'Khoa Tai Mũi Họng',
                'Khoa Răng Hàm Mặt',
                'Khoa Tim Mạch',
                'Khoa Hô hấp',
                'Khoa Tiêu hóa',
                'Khoa Da Liễu',
                'Khoa Sản',
                'Khoa Ngoại Châm',
                'Khoa Chấn thương Chỉnh hình',
                'Khoa Tâm thần',
                'Khoa Urology',
                'Khoa Mắt',
                'Khoa Huyết học',
                'Khoa Nhiễm',
                'Khoa Thần kinh',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('Chọn khoa khám'),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                fullName = value;
              },
              decoration: const InputDecoration(
                labelText: 'Họ và tên',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Ngày khám',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Giờ khám',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        "${selectedTime.hour}:${selectedTime.minute}",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () {
                    _showQRDialog();
                  },
                  child: Center(
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
