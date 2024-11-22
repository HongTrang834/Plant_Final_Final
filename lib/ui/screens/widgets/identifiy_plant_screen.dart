import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IdentifyPlantScreen extends StatelessWidget {
  final String imagePath;

  const IdentifyPlantScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plant Identification")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(imagePath)), // Display the captured image
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _identifyPlant(imagePath); // Pass the captured image's path
            },
            child: const Text("Identify Plant"),
          ),
        ],
      ),
    );
  }

  Future<void> _identifyPlant(String imagePath) async {
    const String apiUrl = 'https://plant.id/api/v3'; // Correct endpoint
    const String apiKey =
        'GFEsndnmxGkkMesR2QhSl0V1UW8PNree1s4K18jREN0JlW1Vxy'; // Replace with your API key

    try {
      if (!File(imagePath).existsSync()) {
        print("File does not exist at path: $imagePath");
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers['Authorization'] = 'Bearer $apiKey';
      request.files.add(await http.MultipartFile.fromPath('images', imagePath));
      request.fields['include-related-images'] = 'false';
      request.fields['organs'] = 'leaf'; // Optional: specify organ type

      print("Sending request to $apiUrl...");
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        String plantName = jsonResponse['suggestions'][0]['plant_name'];
        double confidence = jsonResponse['suggestions'][0]['probability'];
        print(
            'Plant identified: $plantName with ${(confidence * 100).toStringAsFixed(2)}% confidence');
      } else {
        print("Request URL: $apiUrl");
        print("Headers: ${request.headers}");
        print("Fields: ${request.fields}");
        print("Files: ${request.files}");

        print('Failed to identify plant. Error: ${response.statusCode}');
        var errorDetails = await response.stream.bytesToString();
        print('Error Details: $errorDetails');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
