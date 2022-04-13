String removeBgKey = "itagkENup4Fr747E4crTGrmV";
const String BASE_URL = "api.spoonacular.com";
const String Image_URL = "https://spoonacular.com/cdn/ingredients_250x250/";
List<String> apiKey = [
  "92741f886d064d45808dfbd157c066c1",
  "d9ec84e453654268984a928a88645819",
  "d8905056f5f34351bf953b33a8964733",
];
const items = 25;
List<dynamic> data = [
  "Cabbage",
  "Capsicum",
  "Garlic",
  "Beetroot",
  "Cauliflower",
  "Celery",
  "Chilli",
  "Cucumber",
  "Eggplant",
  "Fennel",
  "Ginger",
  "Lemon",
  "Lettuce",
  "Mushroom",
  "Onion",
  "Pea",
  "Pepper",
  "Potato",
  "Radish",
  "Rutabaga",
  "Sauerkraut",
  "Spinach",
  "Sweetcorn",
  "Tomato",
  "Turnip",
  "Yam"
];

List<String> deletedData = [];

void changeAPiKey() {
  apiKey.add(apiKey.removeAt(0));
}

const String imagenotfound =
    "https://bitsofco.de/content/images/2018/12/broken-1.png";

List<String> cuisines = [
  "American",
  "British",
  "Chinese",
  "European",
  "French",
  "Indian",
  "Italian",
  "Japanese",
  "Korean",
  "Mexican",
  "Spanish",
  "Thai",
  "Vietnamese",
];
