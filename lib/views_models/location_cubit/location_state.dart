part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationAdding extends LocationState {}

final class LocationAdded extends LocationState {}

final class LocationFailure extends LocationState {
  final String massge;
  LocationFailure(this.massge);
}

final class FetchingLocation extends LocationState {}

final class FetchedLocation extends LocationState {
  final List<LocationItemModel> locations;
  FetchedLocation(this.locations);
}

final class FetchLocationError extends LocationState {
  final String massge;
  FetchLocationError(this.massge);
}

final class ChosenLocation extends LocationState {
  final LocationItemModel location;
  ChosenLocation(this.location);
}

final class ConfirmLocationLoading extends LocationState {}

final class ConfirmLocationSuccess extends LocationState {}

final class ConfirmLocationfailure extends LocationState {
  final String massage;
  ConfirmLocationfailure(this.massage);
}