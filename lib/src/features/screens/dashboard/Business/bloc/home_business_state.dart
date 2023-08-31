part of 'home_business_bloc.dart';

@immutable
sealed class HomeBusinessState {}

final class HomeBusinessInitial extends HomeBusinessState {}

final class SearchBusinessState extends HomeBusinessState {
  final List<Map> businesses;

  SearchBusinessState(this.businesses);
}
