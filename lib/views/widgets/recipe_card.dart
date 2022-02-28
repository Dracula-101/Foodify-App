import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RecipeCard extends StatelessWidget {
  final int id;
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;
  RecipeCard({
    required this.id,
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(id.toString());
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 19, color: HexColor("#ffffff")),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.center,
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(
                            rating,
                            style: TextStyle(
                                fontSize: 12, color: HexColor("#ffffff")),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          SizedBox(width: 9),
                          Text(
                            cookTime,
                            style: TextStyle(
                                fontSize: 12, color: HexColor("#ffffff")),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ));
  }
}
