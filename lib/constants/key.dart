String removeBgKey = "itagkENup4Fr747E4crTGrmV";
const String BASE_URL = "api.spoonacular.com";
const String Image_URL = "https://spoonacular.com/cdn/ingredients_250x250/";
List<String> apiKey = [
  "058fbfc698bd46d285d6e5f92ab16399",
  "3c3fa0f6ee414e9c8792a700087d1118",
  "d9ec84e453654268984a928a88645819",
  "92741f886d064d45808dfbd157c066c1",
  "d8905056f5f34351bf953b33a8964733",
  "d8856840f0b443d6b3d0d19dec1dfd27"
];

Map<String, String> labels = {
  'Apple': 'https://spoonacular.com/cdn/ingredients_250x250/apple.jpg',
  'Banana':
      'https://api.time.com/wp-content/uploads/2019/11/gettyimages-459761948.jpg?quality=85&w=1024&h=512&crop=1',
  'Beetroot':
      'https://i0.wp.com/kashmirlife.net/wp-content/uploads/2018/09/beetroot.jpg?resize=696%2C503&ssl=1',
  'Bell Pepper':
      'https://solidstarts.com/wp-content/uploads/Bell-Pepper_edited-scaled.jpg',
  'Cabbage': 'https://spoonacular.com/cdn/ingredients_250x250/cabbage.jpg',
  'Capsicum':
      'https://solidstarts.com/wp-content/uploads/Bell-Pepper_edited-scaled.jpg',
  'Carrot': 'https://i.ndtvimg.com/mt/cooks/2014-11/carrots.jpg',
  'Cauliflower':
      'https://spoonacular.com/cdn/ingredients_250x250/cauliflower.jpg',
  'Chili pepper':
      'https://img.freepik.com/free-photo/copy-space-chilli-peper_23-2148601208.jpg',
  'Corn':
      'https://www.seekpng.com/png/small/440-4407269_corn-png-transparent-images-single-corn-on-the.png',
  'Cucumber': 'https://spoonacular.com/cdn/ingredients_250x250/cucumber.jpg',
  'Eggplant': 'https://spoonacular.com/cdn/ingredients_250x250/eggplant.jpg',
  'Garlic': 'https://spoonacular.com/cdn/ingredients_250x250/garlic.jpg',
  'Ginger': 'https://spoonacular.com/cdn/ingredients_250x250/ginger.jpg',
  'Grapes':
      'https://www.bigbasket.com/media/uploads/p/xxl/20001428_2-fresho-grapes-green-with-seed.jpg',
  'Jalepeno':
      'https://www.acouplecooks.com/wp-content/uploads/2020/01/Pickled-Jalapenos-003.jpg',
  'Kiwi': 'https://solidstarts.com/wp-content/uploads/Kiwi_edited-scaled.jpg',
  'Lemon': 'https://spoonacular.com/cdn/ingredients_250x250/lemon.jpg',
  'Lettuce':
      'https://media.newyorker.com/photos/5b6b08d3a676470b4ea9b91f/1:1/w_1748,h_1748,c_limit/Rosner-Lettuce.jpg',
  'Mango': 'https://spoonacular.com/cdn/ingredients_250x250/mango.jpg',
  'Onion':
      'https://produits.bienmanger.com/36700-0w470h470_Organic_Red_Onion_From_Italy.jpg',
  'Orange': 'https://spoonacular.com/cdn/ingredients_250x250/orange.jpg',
  'Paprika': 'https://spoonacular.com/cdn/ingredients_250x250/paprika.jpg',
  'Pear': 'https://spoonacular.com/cdn/ingredients_250x250/pear.jpg',
  'Peas': 'https://spoonacular.com/cdn/ingredients_250x250/peas.jpg',
  'Pineapple': 'https://spoonacular.com/cdn/ingredients_250x250/pineapple.jpg',
  'Pomegranate':
      'https://www.washingtonpost.com/rf/image_1484w/2010-2019/WashingtonPost/2014/01/10/Production/Health/Images/bigstock-Half-of-pomegranate-on-a-white-12359999.jpg?t=20170517',
  'Potato':
      'https://www.macmillandictionary.com/external/slideshow/full/141151_full.jpg',
  'Radish':
      'https://media.istockphoto.com/photos/daikon-radishes-isolated-on-white-background-picture-id158690297?k=20&m=158690297&s=612x612&w=0&h=7Bw_dabX0LewKLAtnqBHHCt5nWYe0xAGjPqk6zg2Q1I=',
  'Soybeans':
      'https://www.azom.com/image.axd?picture=2018%2F7%2FImageForArticle_16061(1).jpg',
  'Spinach': 'https://spoonacular.com/cdn/ingredients_250x250/spinach.jpg',
  'Sweetcorn':
      'https://5.imimg.com/data5/SR/RO/MY-11629088/frozen-sweet-corn-500x500.jpg',
  'Sweet potato':
      'https://static.toiimg.com/thumb/51327325.cms?width=1200&height=900',
  'Tomato': 'https://spoonacular.com/cdn/ingredients_250x250/tomato.jpg',
  'Turnip': 'http://justfunfacts.com/wp-content/uploads/2019/12/turnips.png',
};

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

List<String> fruits = [
  "Apple",
  "Banana",
  "Grapes",
  "Kiwi",
  "Mango,"
      "Orange",
  "Pear",
  "Pineapple",
  "Pomegranate",
  "Watermelon"
];

List<String> vegetables = [
  "Beetroot",
  "Bell Pepper",
  "Cabbage",
  "Capsicum",
  "Carrot",
  "Cauliflower",
  "Chili pepper",
  "Corn",
  "Cucumber",
  "Eggplant",
  "Garlic",
  "Ginger",
  "Jalepeno",
  "Lemon",
  "Lettuce",
  "Onion",
  "Paprika",
  "Peas",
  "Potato",
  "Radish",
  "Soybeans",
  "Spinach",
  "Sweetcorn",
  "Sweet potato",
  "Tomato",
  "Turnip",
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

List<String> classes = [
  "  agnolotti",
  "ahi_tuna",
  "antipasto_salad",
  "apple_cake",
  "babka",
  "baked_apple",
  "baked_beans",
  "baked_potato",
  "baked_salmon",
  "baklava",
  "beef_ribs",
  "beef_stew",
  "beef_stroganoff",
  "beer",
  "bibimbap",
  "biscotti",
  "brisket",
  "brownies",
  "burger",
  "burrito",
  "calzone",
  "caprese_salad",
  "cheesecake",
  "chicken_nuggets",
  "chicken_wings",
  "chili",
  "chow_mein",
  "chowder",
  "churros",
  "coffee",
  "coleslaw",
  "cookies",
  "creme_brulee",
  "crepes",
  "cupcakes",
  "donut",
  "falafel",
  "fish_and_chips",
  "french_toast",
  "fruit_salad",
  "gyros",
  "ice_cream",
  "lasagne",
  "lobster_roll",
  "macarons",
  "nachos",
  "omelet",
  "paella",
  "pancakes",
  "sushi",
];
