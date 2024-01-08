class Meal {
  // int? id;
  String? meal_type;
  String? type;
  String? title;
  String? description;
  String? image;
  String? rating;
  String? calories;
  String? prep_time;
  String? serving;

  Meal();

  Meal.fromJson(Map<String, dynamic> data) {
   // id = data['id'];
    meal_type = data['meal_type'];
    type = data['type'];
    image = data['image'];
    rating = data['rating'];
    calories = data['calories'];
    prep_time = data['image'];
    serving = data['serving'];
    title = data['title'];
    description = data['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
     // "id ": id,
      "meal_type": meal_type,
      "type": type,
      "rating": rating,
      "calories": calories,
      "prep_time": image,
      "serving": serving,
      "description": description
    };
  }
}
