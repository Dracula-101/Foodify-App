String cuisine = "";
bool isVegetarian = false;
bool isBoth = true;
bool isVegan = false;
bool isKetogenic = false;
bool isLactoVegetarian = false;
bool isOvoVegetarian = false;

String getEating() {
  if (isVegetarian) {
    return "vegetarian";
  } else if (isVegan) {
    return "vegan";
  } else if (isKetogenic) {
    return "ketogenic";
  } else if (isLactoVegetarian) {
    return "lacto-vegetarian";
  } else if (isOvoVegetarian) {
    return "ovo-vegetarian";
  } else {
    return "";
  }
}

Map<String, bool> cuisineCheck = {
  "african": false,
  "american": false,
  "british": false,
  "cajun": false,
  "caribbean": false,
  "chinese": false,
  "eastern European": false,
  "european": false,
  "french": false,
  "german": false,
  "greek": false,
  "indian": false,
  "irish": false,
  "italian": false,
  "japanese": false,
  "jewish": false,
  "korean": false,
  "latin American": false,
  "mediterranean": false,
  "mexican": false,
  "middle Eastern": false,
  "nordic": false,
  "southern": false,
  "spanish": false,
  "thai": false,
  "vietnamese": false,
};

List<String> cuisine1 = [
  "african",
  "american",
  "british",
  "cajun",
  "caribbean",
  "chinese",
  "eastern European",
  "european",
  "french",
  "german",
  "greek",
  "indian",
  "irish",
  "italian",
  "japanese",
  "jewish",
  "korean",
  "latin American",
  "mediterranean",
  "mexican",
  "middle Eastern",
  "nordic",
  "southern",
  "spanish",
  "thai",
  "vietnamese",
];

List<String> capitalCuisine = [
  "Not Choosen",
  "African",
  "American",
  "British",
  "Cajun",
  "Caribbean",
  "Chinese",
  "Eastern European",
  "European",
  "French",
  "German",
  "Greek",
  "Indian",
  "Irish",
  "Italian",
  "Japanese",
  "Jewish",
  "Korean",
  "Latin American",
  "Mediterranean",
  "Mexican",
  "Middle Eastern",
  "Nordic",
  "Southern",
  "Spanish",
  "Thai",
  "Vietnamese",
];

String makeCuisine = "Not Choosen";
