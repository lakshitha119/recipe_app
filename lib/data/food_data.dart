// "fdcId": 2625684,
//       "name": "CACIO E PEPE RAVIOLI, CACIO E PEPE",
//       "brandName": "GOOD & GATHER",
//       "brandOwner": "Target Stores",
//       "category": "Pasta by Shape & Type"

class FoodData {
  FoodData(
      {required this.fdcId,
      required this.name,
      required this.category,
      required this.brandName});

  int fdcId;
  String name;
  String category;
  String brandName;

  factory FoodData.fromJson(Map<String, dynamic> json) => FoodData(
      fdcId: json["fdcId"],
      name: json["name"],
      category: json["category"],
      brandName: json["brandName"] == null ? "N/A" : json["brandName"]);
}
