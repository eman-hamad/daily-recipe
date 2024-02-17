class Recipe {
  String? docId;
  String? meal_type;
  String? title;
  String? description;
  String? image;
  num? rating;
  int? calories;
  num? prep_time;
  bool? is_fresh;
  int? serving;
  List<String>? favorite_users_ids;
  List<String>? recently_viewd_users_ids;
  Map<String, String>? directions;
  List<String>? ingredients;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    calories = data['calories'];
    description = data['description'];
    directions = data['directions'] != null
        ? Map<String, String>.from(data['directions'])
        : null;
    image = data['image'];
    ingredients = data['ingredients'] != null
        ? List<String>.from(data['ingredients'].map((e) => e.toString()))
        : null;
    favorite_users_ids = data['favorite_users_ids'] != null
        ? List<String>.from(data['favorite_users_ids'].map((e) => e.toString()))
        : null;

    recently_viewd_users_ids = data['recently_viewd_users_ids'] != null
        ? List<String>.from(
            data['recently_viewd_users_ids'].map((e) => e.toString()))
        : null;
    rating = data['rating'];
    serving = data['serving'];
    title = data['title'];
    prep_time = data['prep_time'];
    meal_type = data['meal_type'];
    is_fresh = data['is_fresh'];
  }

  Map<String, dynamic> toJson() {
    return {
      "calories": calories,
      "description": description,
      "directions": directions,
      "image": image,
      "ingredients": ingredients,
      "rating": rating,
      "serving": serving,
      "title": title,
      "prep_time": prep_time,
      "meal_type": meal_type,
      "favorite_users_ids": favorite_users_ids,
      "recently_viewd_users_ids": recently_viewd_users_ids,
      "is_fresh": is_fresh
    };
  }
}
