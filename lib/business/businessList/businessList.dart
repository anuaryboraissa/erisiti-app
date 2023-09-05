import 'package:erisiti/business/businessList/widget/userBusinessListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessList extends StatelessWidget {
  const BusinessList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "My Business",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              )),
          TextButton(
            onPressed: () {},
            child: const Text(
              "issue",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: const UserBusinessListWidget(),
    );
  }
}
