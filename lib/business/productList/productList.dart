import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../registerProducts/registerProducts.dart';
import 'widgets.dart/productsActionButton.dart';

class productList extends StatefulWidget {
  const productList({super.key});

  @override
  State<productList> createState() => _productListState();
}

class _productListState extends State<productList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "The Business",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => RegisterProduct(),
                  )
                );
              },
              icon: Icon(
                CupertinoIcons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 21),
              decoration: BoxDecoration(
                  color: Colors.cyan.shade700,
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 7.0,
                    )
                  ]),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      ),
                    ),
                    title: Text(
                      productList[index]['name'].toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${productList[index]['currency'].toString()} ${productList[index]['price'].toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "Per ${productList[index]['unit'].toString()}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  productsActionButtons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  late List<dynamic> productList;
  Future<void> readJSON() async {
    final String theFileWithJSONData =
        await rootBundle.rootBundle.loadString('assets/jsonFiles/productList.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      productList = capturedJSONData;
    });
  }
}
