import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // image_picker 플러그인 임포트
import 'home_page.dart';

class StoreRegisterPage extends StatefulWidget {
  const StoreRegisterPage({super.key});

  @override
  StoreRegisterPageState createState() => StoreRegisterPageState();
}

class StoreRegisterPageState extends State<StoreRegisterPage> {
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController storeLocationController = TextEditingController();
  final TextEditingController storePhoneController = TextEditingController();
  final TextEditingController businessNumberController = TextEditingController();
  final TextEditingController ownerPhoneController = TextEditingController();
  final TextEditingController storeTypeController = TextEditingController();
  final TextEditingController avgPriceController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  final TextEditingController storeFeaturesController = TextEditingController();

  File? menuFile;
  File? layoutFile;

  String profileImage = 'assets/images/default_profile.jpg';

  void updateProfileImage() {
    setState(() {
      profileImage = 'assets/images/setting_profile.png';
    });
  }

  Future<void> pickMenuFile() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        menuFile = File(pickedFile.path);
      });
    }
  }

  Future<void> pickLayoutFile() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        layoutFile = File(pickedFile.path);
      });
    }
  }

  void registerStore() {
    String storeName = storeNameController.text;
    String ownerName = ownerNameController.text;
    String storeLocation = storeLocationController.text;
    String storePhone = storePhoneController.text;
    String businessNumber = businessNumberController.text;
    String ownerPhone = ownerPhoneController.text;
    String storeType = storeTypeController.text;
    String avgPrice = avgPriceController.text;
    String maxCapacity = maxCapacityController.text;
    String storeFeatures = storeFeaturesController.text;

    if (storeName.isEmpty ||
        ownerName.isEmpty ||
        storeLocation.isEmpty ||
        storePhone.isEmpty ||
        businessNumber.isEmpty ||
        ownerPhone.isEmpty ||
        storeType.isEmpty ||
        avgPrice.isEmpty ||
        maxCapacity.isEmpty ||
        storeFeatures.isEmpty) {
      _showError("모든 필드를 채워 주세요.");
    } else {
      // 모든 입력이 완료된 경우, DB에 저장하는 부분 구현 필요
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(userInfo: {})),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // 전화번호 및 가격 형식 자동 추가 함수
  String formatPhoneNumber(String text) {
    if (text.length >= 11) {
      return '${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7, 11)}';
    }
    return text;
  }

  String formatCurrency(String text) {
    return '약 ${text.replaceAll(RegExp(r'[^\d]'), '')}원';
  }

  String formatCapacity(String text) {
    return '${text.replaceAll(RegExp(r'[^\d]'), '')}명';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: updateProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(profileImage),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: updateProfileImage,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "매장 정보",
                    style:
                    TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: storeNameController,
                    decoration: const InputDecoration(
                      labelText: "매장 이름",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: ownerNameController,
                    decoration: const InputDecoration(
                      labelText: "점주님 성함",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: storeLocationController,
                    decoration: const InputDecoration(
                      labelText: "매장 위치",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: storePhoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (text) {
                      storePhoneController.value = TextEditingValue(
                        text: formatPhoneNumber(text),
                        selection: TextSelection.collapsed(
                            offset: formatPhoneNumber(text).length),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "매장 번호",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: businessNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "사업자 번호",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: ownerPhoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (text) {
                      ownerPhoneController.value = TextEditingValue(
                        text: formatPhoneNumber(text),
                        selection: TextSelection.collapsed(
                            offset: formatPhoneNumber(text).length),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "점주님 번호",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: storeTypeController,
                    decoration: const InputDecoration(
                      labelText: "매장 유형",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: avgPriceController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      avgPriceController.value = TextEditingValue(
                        text: formatCurrency(text),
                        selection:
                        TextSelection.collapsed(offset: formatCurrency(text).length),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "평균 요리 가격",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: pickMenuFile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('메뉴 파일 첨부'),
                          menuFile != null
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.upload_file, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: pickLayoutFile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('레이아웃 파일 첨부'),
                          layoutFile != null
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.upload_file, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: maxCapacityController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      maxCapacityController.value = TextEditingValue(
                        text: formatCapacity(text),
                        selection:
                        TextSelection.collapsed(offset: formatCapacity(text).length),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "최대 수용 인원",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: storeFeaturesController,
                    decoration: const InputDecoration(
                      labelText: "매장 특징",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(userInfo: {})),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text("취소"),
                      ),
                      ElevatedButton(
                        onPressed: registerStore,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: const Text("신청"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}