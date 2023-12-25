class RecipeData {
  RecipeData({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory RecipeData.fromJson(Map<String, dynamic> json) => RecipeData(
    id: json["id"],
    name: json["name"],
  );

}