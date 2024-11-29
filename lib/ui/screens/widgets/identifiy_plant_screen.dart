import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IdentifyPlantScreen extends StatelessWidget {
  final String imagePath;
  final String raspberryPiUrl =
      "http://10.10.82.139:5001/receive_image"; // URL của server Raspberry Pi
  final String raspberryPiResultUrl =
      "http://10.10.9.69:5000/api/plant-info"; // URL để gửi lại predicted_name

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
              await _uploadImageAndHandleResponse(
                  imagePath); // Gọi hàm upload ảnh
            },
            child: const Text("Identify"),
          ),
        ],
      ),
    );
  }

  // Hàm upload ảnh và xử lý phản hồi từ server
  Future<void> _uploadImageAndHandleResponse(String imagePath) async {
    try {
      if (!File(imagePath).existsSync()) {
        print("File does not exist at path: $imagePath");
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(raspberryPiUrl));
      var multipartFile = await http.MultipartFile.fromPath('image', imagePath);
      request.files.add(multipartFile); // Thêm file vào request

      print("Sending image to $raspberryPiUrl...");
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var result = json.decode(responseData);
        print("Image uploaded successfully!");
        String predictedName = result['predicted_name'];
        // String predictedName = 'Lá chanh';
        print("Prediction: $predictedName");

        // Gửi lại predicted_name tới server
        await _sendPrediction(predictedName);
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

  // Hàm gửi predicted_name tới server
  Future<void> _sendPrediction(String predictedName) async {
    try {
      // Tạo payload JSON hoặc FormData (nếu server yêu cầu)
      var payload = {'predicted_name': predictedName};

      print("Sending predicted_name to $raspberryPiResultUrl...");
      var response = await http.post(
        Uri.parse(raspberryPiResultUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        print("Prediction sent successfully!");
        print("Server Response: ${response.body}");
      } else {
        print("Error sending prediction: ${response.statusCode}");
        print("Error Details: ${response.body}");
      }
    } catch (e) {
      print('Error occurred while sending prediction: $e');
    }
  }
}
