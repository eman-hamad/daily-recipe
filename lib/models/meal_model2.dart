class MyMeal {
  String? docId;
  String? meal_type;

  String? title;
  String? description;
  String? image;
  double? rating;
  int? calories;
  int? prep_time;
  
  int? serving;

  MyMeal();

  MyMeal.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    meal_type = data['meal_type'];

    image = data['image'];
    rating = data['rating'];
    calories = data['calories'];
    prep_time = data['prep_time'];
    serving = data['serving'];
    title = data['title'];
    description = data['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      // "id ": docId,
      "meal_type": meal_type,
      "rating": rating,
      "calories": calories,
      "prep_time": prep_time,
       "serving": serving,
      "description": description
    };
  }
}
