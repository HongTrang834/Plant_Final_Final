import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IdentifyPlantScreen extends StatelessWidget {
  final String imagePath;
  final String raspberryPiUrl =
      "http://10.10.82.139:5001/receive_image"; // URL của server Raspberry Pi

  const IdentifyPlantScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plant Identification")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(imagePath)), // Hiển thị ảnh đã chụp
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _uploadImage(imagePath); // Gọi hàm upload ảnh khi nhấn nút
            },
            child: const Text("Upload Image"),
          ),
        ],
      ),
    );
  }

  // Hàm upload ảnh lên server Raspberry Pi
  Future<void> _uploadImage(String imagePath) async {
    try {
      if (!File(imagePath).existsSync()) {
        print("File does not exist at path: $imagePath");
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(raspberryPiUrl));

      // Đảm bảo tên phần file đúng như yêu cầu của server
      var multipartFile = await http.MultipartFile.fromPath('image', imagePath);
      request.files.add(multipartFile); // Thêm file vào request

      print("Sending request to $raspberryPiUrl...");
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var result = json.decode(responseData);
        print("Image uploaded successfully!");
        String _resultMessage = "Prediction: ${result['predicted_name']}";
        print(_resultMessage); // Hiển thị kết quả nhận diện
      } else {
        print("Request URL: $raspberryPiUrl");
        print('Error: ${response.statusCode}');
        var errorDetails = await response.stream.bytesToString();
        print('Error Details: $errorDetails');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
