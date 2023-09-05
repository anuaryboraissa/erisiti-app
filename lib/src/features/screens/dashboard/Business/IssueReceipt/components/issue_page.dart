import 'package:erisiti/business/productList/helper.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/styles/animation.dart';

class IssueBody extends StatefulWidget {
  const IssueBody({super.key});

  @override
  State<IssueBody> createState() => _IssueBodyState();
}

class _IssueBodyState extends State<IssueBody>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;
  late AnimatedWidgetAction action;

  @override
  void initState() {
    super.initState();
    action = AnimatedWidgetAction(provider: this);
    Map animate = action.animate();
    animationController = animate['controller'];
    delayedAnimation = animate['delayed'];
    getProducts();
  }

  List items = [];
  getProducts() {
    ProductHelper.getProducts().then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  void dispose() {
    action.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform(
            transform:
                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    padding: const EdgeInsets.all(5),
                    hint: const Text("Business (service) type"),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    items: items
                        .map((e) => DropdownMenuItem(
                              value: e['name'],
                              child: Text(e['name']),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // widget.businessType(value!);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        // widget.businessName(value);
                      },
                      decoration: const InputDecoration(
                          hintText: "Business (Company) Name",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        // widget.registrationNumber(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Business Registration Number",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onChanged: (value) {
                        // widget.businessTerms(value);
                      },
                      decoration: const InputDecoration(
                          hintText: "Business terms (Optional)",
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
