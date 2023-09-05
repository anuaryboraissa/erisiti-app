// ignore_for_file: library_prefixes

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../productList/productList.dart';

class UserBusinessListWidget extends StatefulWidget {
  const UserBusinessListWidget({
    super.key,
  });

  @override
  State<UserBusinessListWidget> createState() => _UserBusinessListWidgetState();
}

class _UserBusinessListWidgetState extends State<UserBusinessListWidget> {
  @override
  void initState() {
    readJSON();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 7),
      itemCount: businessInfo.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: (){
              print("Pressed ${index + 1}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context) => productList(),
                )
              );
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index+1}. ${businessInfo[index]['name'].toString()}",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                Icon(
                  CupertinoIcons.forward,
                  color: Colors.white,
                )
              ],
            ),
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(21))),
              padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
              elevation: MaterialStatePropertyAll(7),
              alignment: AlignmentDirectional.topStart,
              backgroundColor: MaterialStatePropertyAll(Colors.cyan.shade700)
            ),
          ),
        );
      },
    );
  }

  List<dynamic> businessInfo = [];
  readJSON() {
    rootBundle.rootBundle
        .loadString('assets/jsonFiles/business.json')
        .then((value) {
      setState(() {
        businessInfo = json.decode(value);
      });
    });
  }
}
