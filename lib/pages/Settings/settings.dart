import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/constants/parameters.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_toggle_type.dart';

import '../../constants/key.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var newCuisine = cuisineCheck.entries.toList();
  List<String> addCuisine = [];
  String cuisineLatest = "Not Choosen";
  String toCapitalized(String name) => name.isNotEmpty
      ? '${name[0].toUpperCase()}${name.substring(1).toLowerCase()}'
      : '';

  List<String> addDiet = ["Veg", "Non-Veg", "Both"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      Container(
        padding: const EdgeInsets.all(10),
        child: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: "lorabold700",
            color: Colors.black54,
            fontSize: 30,
            // decorationThickness: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Diet Settings",
                  style: TextStyle(
                    fontFamily: "lorabold700",
                    color: Colors.black54,
                    fontSize: 20,
                    // decorationThickness: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isVegetarian = true;
                    isBoth = false;
                    isVegan = false;
                    isKetogenic = false;
                    isLactoVegetarian = false;
                    isOvoVegetarian = false;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: isVegetarian
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.greenAccent.withOpacity(0.3),
                            border:
                                Border.all(color: Colors.greenAccent, width: 3))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                    child: const Text('Veg',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54))),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isBoth = true;
                    isVegetarian = false;
                    isVegan = false;
                    isKetogenic = false;
                    isLactoVegetarian = false;
                    isOvoVegetarian = false;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: isBoth
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.redAccent.withOpacity(0.3),
                            border:
                                Border.all(color: Colors.redAccent, width: 3))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                    child: const Text('Non-Veg and Veg',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54))),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isBoth = false;
                    isVegetarian = false;
                    isVegan = true;
                    isKetogenic = false;
                    isLactoVegetarian = false;
                    isOvoVegetarian = false;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: isVegan
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.yellowAccent.withOpacity(0.3),
                            border: Border.all(color: Colors.yellow, width: 3))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                    child: const Text('Vegan',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54))),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isBoth = false;
                    isVegetarian = false;
                    isVegan = false;
                    isKetogenic = true;
                    isLactoVegetarian = false;
                    isOvoVegetarian = false;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: isKetogenic
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent.withOpacity(0.3),
                            border:
                                Border.all(color: Colors.blueAccent, width: 3))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                    child: const Text('Ketogenic',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54))),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isBoth = false;
                    isVegetarian = false;
                    isKetogenic = false;
                    isLactoVegetarian = true;
                    isOvoVegetarian = false;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: isLactoVegetarian
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.orangeAccent.withOpacity(0.3),
                            border: Border.all(
                                color: Colors.orangeAccent, width: 3))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                    child: const Text('Lacto Vegetarian',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54))),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isBoth = false;
                    isVegetarian = false;
                    isKetogenic = false;
                    isLactoVegetarian = false;
                    isOvoVegetarian = true;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: isOvoVegetarian
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.indigoAccent.withOpacity(0.3),
                            border: Border.all(
                                color: Colors.indigoAccent, width: 3))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                    child: const Text('Ovo Vegetarian',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54))),
              ),
            ],
          )),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Specialize Cuisine',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  )
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: GFDropdown(
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(15),
                  border: const BorderSide(color: Colors.black12, width: 1),
                  dropdownButtonColor: Colors.white,
                  value: cuisineLatest,
                  onChanged: (newValue) {
                    cuisineLatest = newValue.toString();
                    setState(() {
                      makeCuisine = cuisineLatest[0].toLowerCase() +
                          cuisineLatest.substring(1, cuisineLatest.length);
                    });
                    print(makeCuisine);
                    if (makeCuisine != "Not Choosen") {
                      cuisine = makeCuisine;
                    } else {
                      cuisine = "";
                    }
                  },
                  items: capitalCuisine
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    FontAwesomeIcons.triangleExclamation,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Warning!!",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'The API might not give correct results due the lack of the data.Hope you will get the results as per your preference.',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      )
    ])));
  }
}
