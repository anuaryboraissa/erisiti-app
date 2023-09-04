import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/components/business_page.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/components/top_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/styles/style.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({super.key});

  @override
  State<RegisterBusiness> createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  bool addBusiness = true;

  List<String> businesses = [];
  String businessName = "";

  @override
  Widget build(BuildContext context) {
    // print("length ${businesses.length}");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BusinessTopBar(),
              contentHolder(),
              if (addBusiness)
                RegisterBody(
                  addBusiness: (bool added) {
                    setState(() {
                      addBusiness = added;
                    });
                  },
                  businessName: (String businessName) {
                    this.businessName = businessName;
                  },
                )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: ApplicationStyles.realAppColor),
              onPressed: addBusiness
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterBusiness(),
                      ));
                    },
              child: const Text("Continue")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ApplicationStyles.realAppColor,
          onPressed: () {
            setState(() {
              if (businessName.isNotEmpty && addBusiness) {
                businesses.add(businessName);
              }
              if (addBusiness) {
                businessName = "";
              }
              addBusiness = !addBusiness;
            });
          },
          child: Icon(
            addBusiness ? Icons.check : Icons.add,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget contentHolder() {
    return Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        height: businesses.isEmpty ? 0 : 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: GridView.builder(
          itemCount: businesses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index) {
            return businessCard(businesses[index]);
          },
        ));
  }

  Widget businessCard(String business) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        // color: ApplicationStyles.realAppColor
      ),
      child: Center(
        child: Text(
          business,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
