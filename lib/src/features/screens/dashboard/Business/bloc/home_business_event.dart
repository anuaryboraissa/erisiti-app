part of 'home_business_bloc.dart';

@immutable
sealed class HomeBusinessEvent {}

final class SearchBusinessEvent extends HomeBusinessEvent {
  final String query;

  SearchBusinessEvent(this.query);
}
