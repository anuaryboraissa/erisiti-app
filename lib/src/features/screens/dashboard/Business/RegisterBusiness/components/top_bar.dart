import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';

class BusinessTopBar extends StatelessWidget {
  const BusinessTopBar({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 8, top: title == "Business" ? 0 : 10),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                child: Text(
                  "Information",
                  style: TextStyle(
                      fontSize: title == "Business" ? 18 : 15,
                      color: ApplicationStyles.realAppColor),
                ),
              ),
              if (title == "Business")
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 18),
                  child: Text(
                    "Register to continue",
                    // style: TextStyle(
                    //     fontSize: 18, color: ApplicationStyles.realAppColor),
                  ),
                )
            ],
          ),
          Image.asset(
            image,
            height: size.height * .18,
            width: size.width * .45,
          )
        ],
      ),
    );
  }
}
