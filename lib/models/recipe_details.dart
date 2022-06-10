class RecipeDetails {
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  // bool? sustainable;
  // double? weightWatcherSmartPodoubles;
  String? gaps;
  bool? lowFodmap;
  int? aggregateLikes;
  int? spoonacularScore;
  double? healthScore;
  // String? creditsText;
  // String? license;
  String? sourceName;
  double? pricePerServing;
  List<ExtendedIngredients>? extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  // String? imageType;
  Nutrition? nutrition;
  String? summary;
  List<dynamic>? cuisines;
  List<String>? dishTypes;
  List<dynamic>? diets;
  List<dynamic>? occasions;
  WinePairing? winePairing;
  String? instructions;
  List<dynamic>? analyzedInstructions;
  String? spoonacularSourceUrl;

  RecipeDetails(
      {this.vegetarian,
      this.vegan,
      this.glutenFree,
      this.dairyFree,
      this.veryHealthy,
      this.cheap,
      this.veryPopular,
      // this.sustainable,
      // this.weightWatcherSmartPodoubles,
      this.gaps,
      this.lowFodmap,
      this.aggregateLikes,
      this.spoonacularScore,
      this.healthScore,
      // this.creditsText,
      // this.license,
      this.sourceName,
      this.pricePerServing,
      this.extendedIngredients,
      this.id,
      this.title,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl,
      this.image,
      // this.imageType,
      this.nutrition,
      this.summary,
      this.cuisines,
      this.dishTypes,
      this.diets,
      this.occasions,
      this.winePairing,
      this.instructions,
      this.analyzedInstructions,
      this.spoonacularSourceUrl});

  RecipeDetails.fromJson(Map<String, dynamic> json) {
    vegetarian = json['vegetarian'];
    vegan = json['vegan'];
    glutenFree = json['glutenFree'];
    dairyFree = json['dairyFree'];
    veryHealthy = json['veryHealthy'];
    cheap = json['cheap'];
    veryPopular = json['veryPopular'];
    // sustainable = json['sustainable'];
    // weightWatcherSmartPodoubles = json['weightWatcherSmartPodoubles'];
    gaps = json['gaps'];
    lowFodmap = json['lowFodmap'];
    aggregateLikes = json['aggregateLikes'];
    spoonacularScore = json['weightWatcherSmartPoints'];
    healthScore = json['healthScore'];
    // creditsText = json['creditsText'];
    // license = json['license'];
    sourceName = json['sourceName'];
    pricePerServing = json['pricePerServing'];
    if (json['extendedIngredients'] != null) {
      extendedIngredients = <ExtendedIngredients>[];
      json['extendedIngredients'].forEach((v) {
        extendedIngredients!.add(ExtendedIngredients.fromJson(v));
      });
    }
    id = json['id'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
    image = json['image'];
    // imageType = json['imageType'];
    nutrition = json['nutrition'] != null
        ? Nutrition.fromJson(json['nutrition'])
        : null;
    summary = json['summary'];
    if (json['cuisines'] != null) {
      cuisines = <dynamic>[];
      json['cuisines'].forEach((v) {
        cuisines!.add(v);
      });
    }
    dishTypes = json['dishTypes'].cast<String>();
    if (json['diets'] != null) {
      diets = <dynamic>[];
      json['diets'].forEach((v) {
        diets!.add(v);
      });
    }
    if (json['occasions'] != null) {
      occasions = <dynamic>[];
      json['occasions'].forEach((v) {
        occasions!.add(v);
      });
    }
    winePairing = json['winePairing'] != null
        ? WinePairing.fromJson(json['winePairing'])
        : null;
    instructions = json['instructions'];
    if (json['analyzedInstructions'] != null) {
      analyzedInstructions = <dynamic>[];
      json['analyzedInstructions'].forEach((v) {
        analyzedInstructions!.add(v);
      });
    }
    spoonacularSourceUrl = json['spoonacularSourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vegetarian'] = vegetarian;
    data['vegan'] = vegan;
    data['glutenFree'] = glutenFree;
    data['dairyFree'] = dairyFree;
    data['veryHealthy'] = veryHealthy;
    data['cheap'] = cheap;
    data['veryPopular'] = veryPopular;
    // data['sustainable'] = sustainable;
    // data['weightWatcherSmartPodoubles'] = weightWatcherSmartPodoubles;
    data['gaps'] = gaps;
    data['lowFodmap'] = lowFodmap;
    data['aggregateLikes'] = aggregateLikes;
    data['weightWatcherSmartPoints'] = spoonacularScore;
    data['healthScore'] = healthScore;
    // data['creditsText'] = creditsText;
    // data['license'] = license;
    data['sourceName'] = sourceName;
    data['pricePerServing'] = pricePerServing;
    if (extendedIngredients != null) {
      data['extendedIngredients'] =
          extendedIngredients!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['title'] = title;
    data['readyInMinutes'] = readyInMinutes;
    data['servings'] = servings;
    data['sourceUrl'] = sourceUrl;
    data['image'] = image;
    // data['imageType'] = imageType;
    if (nutrition != null) {
      data['nutrition'] = nutrition!.toJson();
    }
    data['summary'] = summary;
    if (cuisines != null) {
      data['cuisines'] = cuisines!.map((v) => v.toJson()).toList();
    }
    data['dishTypes'] = dishTypes;
    if (diets != null) {
      data['diets'] = diets!.map((v) => v.toJson()).toList();
    }
    if (occasions != null) {
      data['occasions'] = occasions!.map((v) => v.toJson()).toList();
    }
    if (winePairing != null) {
      data['winePairing'] = winePairing!.toJson();
    }
    data['instructions'] = instructions;
    if (analyzedInstructions != null) {
      data['analyzedInstructions'] =
          analyzedInstructions!.map((v) => v.toJson()).toList();
    }
    data['spoonacularSourceUrl'] = spoonacularSourceUrl;
    return data;
  }

  static RecipeDetails recipesFromSnapshotDetails(dynamic snapshot) {
    return RecipeDetails(
      vegetarian: true,
      vegan: snapshot['vegan'],
      glutenFree: snapshot['glutenFree'],
      dairyFree: snapshot['dairyFree'],
      veryHealthy: snapshot['veryHealthy'],
      cheap: snapshot['cheap'],
      veryPopular: snapshot['veryPopular'],
      // sustainable: snapshot['sustainable'],
      // weightWatcherSmartPodoubles: snapshot['weightWatcherSmartPodoubles'],
      gaps: snapshot['gaps'],
      lowFodmap: snapshot['lowFodmap'],
      aggregateLikes: snapshot['aggregateLikes'],
      spoonacularScore: snapshot['weightWatcherSmartPoints'],
      // healthScore: snapshot['healthScore'] as double,
      // creditsText: snapshot['creditsText'],
      // license: snapshot['license'],
      sourceName: snapshot['sourceName'],
      pricePerServing: snapshot['pricePerServing'],
      extendedIngredients: snapshot['extendedIngredients'] != null
          ? (snapshot['extendedIngredients'] as List)
              .map((e) => ExtendedIngredients.fromJson(e))
              .toList()
          : null,
      id: snapshot['id'],
      title: snapshot['title'],
      readyInMinutes: snapshot['readyInMinutes'],
      servings: snapshot['servings'],
      sourceUrl: snapshot['sourceUrl'],
      image: snapshot['image'],
      // imageType: snapshot['imageType'],
      nutrition: snapshot['nutrition'] != null
          ? Nutrition.fromJson(snapshot['nutrition'])
          : null,
      summary: snapshot['summary'],
      cuisines: snapshot['cuisines'] != null
          ? (snapshot['cuisines'] as List).map((e) => e as String).toList()
          : null,
      dishTypes: snapshot['dishTypes'] != null
          ? (snapshot['dishTypes'] as List).map((e) => e as String).toList()
          : null,
      diets: snapshot['diets'] != null
          ? (snapshot['diets'] as List).map((e) => e as String).toList()
          : null,
      occasions: snapshot['occasions'],
      instructions: snapshot['instructions'],
      analyzedInstructions: snapshot['analyzedInstructions'] != null
          ? (snapshot['analyzedInstructions'] as List)
              .map((e) => AnalyzedInstructions.fromJson(e))
              .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'RecipeDetails{vegetarian: $vegetarian, vegan: $vegan, glutenFree: $glutenFree, dairyFree: $dairyFree, veryHealthy: $veryHealthy, cheap: $cheap, veryPopular: $veryPopular, gaps: $gaps, lowFodmap: $lowFodmap, aggregateLikes: $aggregateLikes, spoonacularScore: $spoonacularScore, healthScore: $healthScore, sourceName: $sourceName, pricePerServing: $pricePerServing, extendedIngredients: $extendedIngredients, id: $id, title: $title, readyInMinutes: $readyInMinutes, servings: $servings, sourceUrl: $sourceUrl, image: $image, nutrition: $nutrition, summary: $summary, cuisines: $cuisines, dishTypes: $dishTypes, diets: $diets}';
  }
}

class AnalyzedInstructions {
  String? name;
  List<Steps>? steps;

  AnalyzedInstructions({this.name, this.steps});

  AnalyzedInstructions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  int? number;
  String? step;
  List<Ingredients>? ingredients;
  List<Equipment>? equipment;

  Steps({this.number, this.step, this.ingredients, this.equipment});

  Steps.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    step = json['step'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
    if (json['equipment'] != null) {
      equipment = <Equipment>[];
      json['equipment'].forEach((v) {
        equipment!.add(Equipment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['step'] = step;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    if (equipment != null) {
      data['equipment'] = equipment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  int? id;
  String? name;
  String? localizedName;
  String? image;

  Ingredients({this.id, this.name, this.localizedName, this.image});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localizedName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['localizedName'] = localizedName;
    data['image'] = image;
    return data;
  }
}

class Equipment {
  int? id;
  String? image;
  String? name;
  String? instructions;

  Equipment({
    this.id,
    this.image,
    this.name,
    this.instructions,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        instructions: json['instructions'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'image': image,
        'name': name,
        'instructions': instructions,
      };
}

class ExtendedIngredients {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalName;
  double? amount;
  String? unit;
  List<String>? meta;
  Measures? measures;

  ExtendedIngredients(
      {this.id,
      this.aisle,
      this.image,
      this.consistency,
      this.name,
      this.nameClean,
      this.original,
      this.originalName,
      this.amount,
      this.unit,
      this.meta,
      this.measures});

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aisle = json['aisle'];
    image = json['image'];
    consistency = json['consistency'];
    name = json['name'];
    nameClean = json['nameClean'];
    original = json['original'];
    originalName = json['originalName'];
    amount = json['amount'];
    unit = json['unit'];
    meta = json['meta'].cast<String>();
    measures =
        json['measures'] != null ? Measures.fromJson(json['measures']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aisle'] = aisle;
    data['image'] = image;
    data['consistency'] = consistency;
    data['name'] = name;
    data['nameClean'] = nameClean;
    data['original'] = original;
    data['originalName'] = originalName;
    data['amount'] = amount;
    data['unit'] = unit;
    data['meta'] = meta;
    if (measures != null) {
      data['measures'] = measures!.toJson();
    }
    return data;
  }
}

class Measures {
  Us? us;
  Us? metric;

  Measures({this.us, this.metric});

  Measures.fromJson(Map<String, dynamic> json) {
    us = json['us'] != null ? Us.fromJson(json['us']) : null;
    metric = json['metric'] != null ? Us.fromJson(json['metric']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (us != null) {
      data['us'] = us!.toJson();
    }
    if (metric != null) {
      data['metric'] = metric!.toJson();
    }
    return data;
  }
}

class Us {
  double? amount;
  String? unitShort;
  String? unitLong;

  Us({this.amount, this.unitShort, this.unitLong});

  Us.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unitShort = json['unitShort'];
    unitLong = json['unitLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unitShort'] = unitShort;
    data['unitLong'] = unitLong;
    return data;
  }
}

class Nutrition {
  List<Nutrients>? nutrients;
  List<Properties>? properties;
  List<Flavonoids>? flavonoids;
  List<Ingredients2>? ingredients;
  CaloricBreakdown? caloricBreakdown;
  WeightPerServing? weightPerServing;

  Nutrition(
      {this.nutrients,
      this.properties,
      this.flavonoids,
      this.ingredients,
      this.caloricBreakdown,
      this.weightPerServing});

  Nutrition.fromJson(Map<String, dynamic> json) {
    if (json['nutrients'] != null) {
      nutrients = <Nutrients>[];
      json['nutrients'].forEach((v) {
        nutrients!.add(Nutrients.fromJson(v));
      });
    }
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(Properties.fromJson(v));
      });
    }
    if (json['flavonoids'] != null) {
      flavonoids = <Flavonoids>[];
      json['flavonoids'].forEach((v) {
        flavonoids!.add(Flavonoids.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Ingredients2>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients2.fromJson(v));
      });
    }
    caloricBreakdown = json['caloricBreakdown'] != null
        ? CaloricBreakdown.fromJson(json['caloricBreakdown'])
        : null;
    weightPerServing = json['weightPerServing'] != null
        ? WeightPerServing.fromJson(json['weightPerServing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nutrients != null) {
      data['nutrients'] = nutrients!.map((v) => v.toJson()).toList();
    }
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    if (flavonoids != null) {
      data['flavonoids'] = flavonoids!.map((v) => toJson()).toList();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    if (caloricBreakdown != null) {
      data['caloricBreakdown'] = caloricBreakdown!.toJson();
    }
    if (weightPerServing != null) {
      data['weightPerServing'] = weightPerServing!.toJson();
    }
    return data;
  }
}

class Flavonoids {
  String? name;
  double? amount;
  String? unit;

  Flavonoids({this.name, this.amount, this.unit});

  static Flavonoids fromJson(v) {
    return Flavonoids(
      name: v['name'],
      amount: v['amount'],
      unit: v['unit'],
    );
  }
}

class Nutrients {
  String? name;
  double? amount;
  String? unit;
  double? percentOfDailyNeeds;

  Nutrients({this.name, this.amount, this.unit, this.percentOfDailyNeeds});

  Nutrients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
    percentOfDailyNeeds = json['percentOfDailyNeeds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['unit'] = unit;
    data['percentOfDailyNeeds'] = percentOfDailyNeeds;
    return data;
  }
}

class Properties {
  String? name;
  double? amount;
  String? unit;

  Properties({this.name, this.amount, this.unit});

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['unit'] = unit;
    return data;
  }
}

class Ingredients2 {
  double? id;
  String? name;
  double? amount;
  String? unit;
  List<Nutrients>? nutrients;

  Ingredients2({this.id, this.name, this.amount, this.unit, this.nutrients});

  Ingredients2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
    if (json['nutrients'] != null) {
      nutrients = <Nutrients>[];
      json['nutrients'].forEach((v) {
        nutrients!.add(Nutrients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['unit'] = unit;
    if (nutrients != null) {
      data['nutrients'] = nutrients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaloricBreakdown {
  double? percentProtein;
  double? percentFat;
  double? percentCarbs;

  CaloricBreakdown({this.percentProtein, this.percentFat, this.percentCarbs});

  CaloricBreakdown.fromJson(Map<String, dynamic> json) {
    percentProtein = json['percentProtein'];
    percentFat = json['percentFat'];
    percentCarbs = json['percentCarbs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentProtein'] = percentProtein;
    data['percentFat'] = percentFat;
    data['percentCarbs'] = percentCarbs;
    return data;
  }
}

class WeightPerServing {
  double? amount;
  String? unit;

  WeightPerServing({this.amount, this.unit});

  WeightPerServing.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unit'] = unit;
    return data;
  }
}

class WinePairing {
  List<dynamic>? pairedWines;
  String? pairingText;
  List<dynamic>? productMatches;

  WinePairing({this.pairedWines, this.pairingText, this.productMatches});

  WinePairing.fromJson(Map<String, dynamic> json) {
    if (json['pairedWines'] != null) {
      pairedWines = <Null>[];
      json['pairedWines'].forEach((v) {
        pairedWines!.add(v);
      });
    }
    pairingText = json['pairingText'];
    if (json['productMatches'] != null) {
      productMatches = <Null>[];
      json['productMatches'].forEach((v) {
        productMatches!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pairedWines != null) {
      data['pairedWines'] = pairedWines!.map((v) => v.toJson()).toList();
    }
    data['pairingText'] = pairingText;
    if (productMatches != null) {
      data['productMatches'] = productMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
