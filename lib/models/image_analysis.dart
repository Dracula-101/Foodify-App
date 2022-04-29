class ImageAnalysis {
  String? status;
  Nutrition? nutrition;
  Category? category;
  List<Recipes>? recipes;

  ImageAnalysis({this.status, this.nutrition, this.category, this.recipes});

  factory ImageAnalysis.fromJson(dynamic json) {
    return ImageAnalysis(
      status: json['status'],
      nutrition: json['nutrition'] != null
          ? Nutrition.fromJson(json['nutrition'])
          : null,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      recipes: json['recipes'] != null
          ? List<Recipes>.from(json['recipes'].map((x) => Recipes.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (nutrition != null) {
      data['nutrition'] = nutrition!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nutrition {
  int? recipesUsed;
  Calories? calories;
  Calories? fat;
  Calories? protein;
  Calories? carbs;

  Nutrition(
      {this.recipesUsed, this.calories, this.fat, this.protein, this.carbs});

  Nutrition.fromJson(Map<String, dynamic> json) {
    recipesUsed = json['recipesUsed'];
    calories =
        json['calories'] != null ? Calories.fromJson(json['calories']) : null;
    fat = json['fat'] != null ? Calories.fromJson(json['fat']) : null;
    protein =
        json['protein'] != null ? Calories.fromJson(json['protein']) : null;
    carbs = json['carbs'] != null ? Calories.fromJson(json['carbs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipesUsed'] = recipesUsed;
    if (calories != null) {
      data['calories'] = calories!.toJson();
    }
    if (fat != null) {
      data['fat'] = fat!.toJson();
    }
    if (protein != null) {
      data['protein'] = protein!.toJson();
    }
    if (carbs != null) {
      data['carbs'] = carbs!.toJson();
    }
    return data;
  }
}

class Calories {
  double? value;
  String? unit;
  ConfidenceRange95Percent? confidenceRange95Percent;
  double? standardDeviation;

  Calories(
      {this.value,
      this.unit,
      this.confidenceRange95Percent,
      this.standardDeviation});

  Calories.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = json['confidenceRange95Percent'] != null
        ? ConfidenceRange95Percent.fromJson(json['confidenceRange95Percent'])
        : null;
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    if (confidenceRange95Percent != null) {
      data['confidenceRange95Percent'] = confidenceRange95Percent!.toJson();
    }
    data['standardDeviation'] = standardDeviation;
    return data;
  }
}

class ConfidenceRange95Percent {
  double? min;
  double? max;

  ConfidenceRange95Percent({this.min, this.max});

  ConfidenceRange95Percent.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

class Category {
  String? name;
  double? probability;

  Category({this.name, this.probability});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['probability'] = probability;
    return data;
  }
}

class Recipes {
  int? id;
  String? title;
  String? imageType;
  String? url;

  Recipes({this.id, this.title, this.imageType, this.url});

  Recipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageType = json['imageType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imageType'] = imageType;
    data['url'] = url;
    return data;
  }
}
