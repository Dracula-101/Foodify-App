String API_KEY = "d8905056f5f34351bf953b33a8964733";
String removeBgKey = "itagkENup4Fr747E4crTGrmV";
String other_api_key = "d9ec84e453654268984a928a88645819";
const String BASE_URL = "api.spoonacular.com";
final items = 25;
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
  String temp = API_KEY;
  API_KEY = other_api_key;
  other_api_key = temp;
}

final String imagenotfound =
    "https://bitsofco.de/content/images/2018/12/broken-1.png";
