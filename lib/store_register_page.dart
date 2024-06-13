import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // image_picker 플러그인 임포트
import 'home_page.dart';
import 'database_helper.dart';

class StoreRegisterPage extends StatefulWidget {
  const StoreRegisterPage({super.key});

  @override
  StoreRegisterPageState createState() => StoreRegisterPageState();
}

class StoreRegisterPageState extends State<StoreRegisterPage> {
  // 매장 정보를 입력받을 텍스트 컨트롤러들
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController storeLocationController = TextEditingController();
  final TextEditingController storePhoneController = TextEditingController();
  final TextEditingController businessNumberController =
  TextEditingController();
  final TextEditingController ownerPhoneController = TextEditingController();
  final TextEditingController storeTypeController = TextEditingController();
  final TextEditingController avgPriceController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  final TextEditingController storeFeaturesController = TextEditingController();

  File? menuFile; // 메뉴 파일
  File? layoutFile; // 레이아웃 파일

  Map<String, dynamic> userInfo = {}; // 사용자 정보

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 이전 페이지에서 전달된 사용자 정보 가져오기
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      userInfo = arguments;
    }
  }

  String profileImage = 'assets/images/default_profile.jpeg'; // 프로필 이미지 경로

  void updateProfileImage() {
    setState(() {
      profileImage = 'assets/images/setting_profile.png'; // 프로필 이미지 변경
    });
  }

  Future<void> pickMenuFile() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택
    if (pickedFile != null) {
      setState(() {
        menuFile = File(pickedFile.path); // 선택한 이미지를 menuFile에 저장
      });
    }
  }

  Future<void> pickLayoutFile() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택
    if (pickedFile != null) {
      setState(() {
        layoutFile = File(pickedFile.path); // 선택한 이미지를 layoutFile에 저장
      });
    }
  }

  void registerStore() async {
    // 입력된 매장 정보 가져오기
    String storeName = storeNameController.text;
    String ownerName = ownerNameController.text;
    String storeLocation = storeLocationController.text;
    String storePhone =
    storePhoneController.text.replaceAll(RegExp(r'[^\d]'), ''); // 숫자만 추출
    String businessNumber = businessNumberController.text
        .replaceAll(RegExp(r'[^\d]'), ''); // 숫자만 추출
    String ownerPhone =
    ownerPhoneController.text.replaceAll(RegExp(r'[^\d]'), ''); // 숫자만 추출
    String storeType = storeTypeController.text;
    String avgPrice =
    avgPriceController.text.replaceAll(RegExp(r'[^\d]'), ''); // 숫자만 추출
    String maxCapacity =
    maxCapacityController.text.replaceAll(RegExp(r'[^\d]'), ''); // 숫자만 추출
    String storeFeatures = storeFeaturesController.text;

    // 유효성 검사
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
      _showError("모든 필드를 채워 주세요."); // 오류 메시지 표시
    } else {
      // 매장 정보를 Map 형태로 저장
      Map<String, dynamic> store = {
        'storeName': storeName,
        'ownerName': ownerName,
        'storeLocation': storeLocation,
        'storePhone': storePhone,
        'businessNumber': businessNumber,
        'ownerPhone': ownerPhone,
        'storeType': storeType,
        'avgPrice': int.parse(avgPrice),
        'maxCapacity': int.parse(maxCapacity),
        'storeFeatures': storeFeatures,
      };

      try {
        await DatabaseHelper().insertStore(store); // 데이터베이스에 매장 정보 저장
        if (userInfo.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(userInfo: userInfo)), // 사용자 정보와 함께 홈 페이지로 이동
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(userInfo: {})), // 빈 사용자 정보와 함께 홈 페이지로 이동
          );
        }
      } catch (e) {
        print('Error: $e');
        _showError("매장 등록에 실패했습니다. 다시 시도해 주세요."); // 오류 메시지 표시
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)), // 오류 메시지를 스낵바로 표시
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
          onPressed: () => Navigator.pop(context), // 뒤로 가기 버튼 클릭 시 이전 페이지로 이동
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: updateProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(profileImage), // 프로필 이미지 표시
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: updateProfileImage, // 프로필 이미지 수정 버튼
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
                        text: formatPhoneNumber(text), // 전화번호 형식 자동 추가
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
                        text: formatPhoneNumber(text), // 전화번호 형식 자동 추가
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
                        text: formatCurrency(text), // 가격 형식 자동 추가
                        selection: TextSelection.collapsed(
                            offset: formatCurrency(text).length),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('메뉴 파일 첨부'),
                          menuFile != null
                              ? const Icon(Icons.check, color: Colors.green) // 메뉴 파일이 선택되었을 때 체크 아이콘 표시
                              : const Icon(Icons.upload_file,
                              color: Colors.grey), // 메뉴 파일이 선택되지 않았을 때 업로드 아이콘 표시
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: pickLayoutFile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('레이아웃 파일 첨부'),
                          layoutFile != null
                              ? const Icon(Icons.check, color: Colors.green) // 레이아웃 파일이 선택되었을 때 체크 아이콘 표시
                              : const Icon(Icons.upload_file,
                              color: Colors.grey), // 레이아웃 파일이 선택되지 않았을 때 업로드 아이콘 표시
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
                        text: formatCapacity(text), // 인원 수 형식 자동 추가
                        selection: TextSelection.collapsed(
                            offset: formatCapacity(text).length),
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
                            MaterialPageRoute(
                                builder: (context) => HomePage(userInfo: {})), // 사용자 정보를 빈 객체로 설정하여 홈 페이지로 이동
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text("취소"),
                      ),
                      ElevatedButton(
                        onPressed: registerStore, // 매장 등록 버튼
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
