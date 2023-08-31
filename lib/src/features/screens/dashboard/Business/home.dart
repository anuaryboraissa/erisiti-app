import 'package:erisiti/src/features/screens/dashboard/Business/components/body.dart';

import 'components/topBar.dart';
import 'package:flutter/material.dart';

class BusinessHome extends StatefulWidget {
  const BusinessHome({super.key});

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeBusinessTopBar(
                  size: size,
                ),
                HomeBusinessBody(size: size)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
