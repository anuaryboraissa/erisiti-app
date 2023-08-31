import 'package:erisiti/src/constants/data/business.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/bloc/home_business_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/components/business_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeBusinessBody extends StatefulWidget {
  const HomeBusinessBody({super.key, required this.size});
  final Size size;

  @override
  State<HomeBusinessBody> createState() => _HomeBusinessBodyState();
}

class _HomeBusinessBodyState extends State<HomeBusinessBody> {
  HomeBusinessBloc homeBusinessBloc = HomeBusinessBloc();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: BlocBuilder<HomeBusinessBloc, HomeBusinessState>(
        bloc: homeBusinessBloc,
        builder: (context, state) {
          return SizedBox(
            height: widget.size.height * .78,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    homeBusinessBloc.add(SearchBusinessEvent(value));
                  },
                  decoration: InputDecoration(
                      hintText: "Search your business here!",
                      contentPadding: const EdgeInsets.all(20),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 60),
                  itemCount: (state is SearchBusinessState)
                      ? state.businesses.length
                      : AvailableBusiness.businesses.length,
                  itemBuilder: (context, index) {
                    Map item = (state is SearchBusinessState)
                        ? state.businesses[index]
                        : AvailableBusiness.businesses[index];
                    return BusinessCard(
                      image: item['image'],
                      title: item['name'],
                      description: item['description'],
                      size: widget.size,
                      itemId: item['id'].toString(),
                      callback: (String itemID) {
                        Fluttertoast.showToast(msg: "Item Clicked $itemID");
                      },
                    );
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
