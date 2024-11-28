import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant/constants.dart';
import 'package:plant/models/plants.dart';
import 'package:plant/ui/screens/detail_page.dart';

class PlantWidget extends StatelessWidget {
  const PlantWidget({
    Key? key,
    required this.index,
    required this.plantList,
  }) : super(key: key);

  final int index;
  final List<Plant> plantList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: DetailPage(
                plantId: plantList[index].plantId,
              ),
              type: PageTransitionType.bottomToTop),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(40),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.8),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 80.0,
                    child: Image.asset(plantList[index].imageURL),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plantList[index].plantName,
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
            )
          ],
        ),
      ),
    );
  }
}
