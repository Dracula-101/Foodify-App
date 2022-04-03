String cuisine = 'indian';
bool isVegetarian = false;

String getVeg() {
  if (isVegetarian) {
    return 'vegetarian';
  } else {
    return 'non-vegetarian';
  }
}
