import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/constants/data/business.dart';
import 'package:meta/meta.dart';

part 'home_business_event.dart';
part 'home_business_state.dart';

class HomeBusinessBloc extends Bloc<HomeBusinessEvent, HomeBusinessState> {
  HomeBusinessBloc() : super(HomeBusinessInitial()) {
    on<HomeBusinessEvent>(homeBusinessEvent);
    on<SearchBusinessEvent>(searchBusinessEvent);
  }

  FutureOr<void> homeBusinessEvent(
      HomeBusinessEvent event, Emitter<HomeBusinessState> emit) {}

  FutureOr<void> searchBusinessEvent(
      SearchBusinessEvent event, Emitter<HomeBusinessState> emit) {
    List<Map> filteredItems = AvailableBusiness.businesses
        .where((element) => element['name']
            .toString()
            .toLowerCase()
            .contains(event.query.toLowerCase()))
        .toList();
    emit(SearchBusinessState(filteredItems));
  }
}
