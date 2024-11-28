import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/models/plants.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  const DetailPage({Key? key, required this.plantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;
    Plant currentPlant = _plantList[widget.plantId];

    return Scaffold(
      body: Stack(
        children: [
          // Hình ảnh chính ở trên
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ảnh chính
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      currentPlant.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 10), // Khoảng cách giữa ảnh chính và ảnh phụ
                // List các ảnh phụ
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            currentPlant.relatedImages[index],
                            width: 80,
                            height: 80,
                            //  fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Nội dung chính
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hiển thị tên cây
                      Text(
                        currentPlant.plantName,
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      // Hiển thị tên khoa học
                      Text(
                        currentPlant.plantScientificName,
                        style: TextStyle(
                          color: Constants.primaryColor.withOpacity(0.8),
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Hiển thị vùng phân bố
                      Text(
                        "Area: " + currentPlant.plantArea,
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Hiển thị thành phần hóa học
                      Text(
                        "Chemical Composition: " +
                            currentPlant.plantChemiscalCom,
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 16.0,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        currentPlant.decription,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          color: Constants.blackColor.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width,
        height: 150,
        child: Column(
          children: [
            // Nút Learn more
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: Constants.primaryColor.withOpacity(.3),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'Learn more about ' + currentPlant.plantName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 4 hình ảnh liên quan
            // SizedBox(
            //   height: 80,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 4,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(10),
            //           child: Image.asset(
            //             currentPlant.relatedImages[index],
            //             width: 80,
            //             height: 80,
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
