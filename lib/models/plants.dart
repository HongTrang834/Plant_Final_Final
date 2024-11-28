class Plant {
  final int plantId;
  final String plantName;
  final String plantScientificName;
  final String plantArea;
  final String plantChemiscalCom;
  final String imageURL;
  bool isFavorated;
  final List<String> relatedImages;
  final String decription;

  Plant(
      {required this.plantId,
      required this.plantName,
      required this.plantScientificName,
      required this.plantArea,
      required this.plantChemiscalCom,
      required this.imageURL,
      required this.isFavorated,
      required this.relatedImages,
      required this.decription});

  //List of Plants data
  static List<Plant> plantList = [
    Plant(
      plantId: 0,
      plantName: "Aloe Vera",
      plantScientificName: "Aloe barbadensis miller",
      plantArea: "Tropical and Subtropical regions",
      plantChemiscalCom:
          "Contains vitamins, enzymes, minerals, sugars, lignin, saponins, salicylic acids",
      imageURL: 'assets/images/plant-one.png',
      isFavorated: true,
      relatedImages: [
        'assets/images/plant-four.png',
        'assets/images/plant-five.png',
        'assets/images/plant-six.png',
        'assets/images/plant-seven.png',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 1,
      plantName: "Basil",
      plantScientificName: "Ocimum basilicum",
      plantArea: "Worldwide in temperate climates",
      plantChemiscalCom: "Rich in essential oils, flavonoids, and polyphenols",
      imageURL: 'assets/images/plant-two.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 2,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-three.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 3,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-one.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 4,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-four.png',
      isFavorated: true,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 5,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-five.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 6,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-six.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 7,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-seven.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/aloe_vera_1.jfif',
        'assets/images/aloe_vera_2.jfif',
        'assets/images/aloe_vera_3.jfif',
        'assets/images/aloe_vera_4.jfif',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
    Plant(
      plantId: 8,
      plantName: 'Sanseviera',
      plantScientificName: 'Sanseviera',
      plantArea: 'Vietnam',
      plantChemiscalCom: 'A, B',
      imageURL: 'assets/images/plant-eight.png',
      isFavorated: false,
      relatedImages: [
        'assets/images/plant_four.png',
        'assets/images/plant_five.png',
        'assets/images/plant_six.png',
        'assets/images/plant_seven.png',
      ],
      decription:
          'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
          'even the harshest weather condition.',
    ),
  ];

  //Get the favorated items
  static List<Plant> getFavoritedPlants() {
    List<Plant> _travelList = Plant.plantList;
    return _travelList.where((element) => element.isFavorated == true).toList();
  }
}
