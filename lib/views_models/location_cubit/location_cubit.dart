import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  String selectedLocationId = dummylocations.first.id;

  void addLocation(String location) {
    emit(LocationAdding());
    Future.delayed(Duration(seconds: 2), () {
      final splitedText = location.split(',');
      final locationItem = LocationItemModel(
          id: DateTime.now().toIso8601String(),
          city: splitedText[0],
          country: splitedText[1]);
      dummylocations.add(locationItem);
      emit(LocationAdded());
      emit(FetchedLocation(dummylocations));
    });
  }

  void fetchLocations() {
    emit(FetchingLocation());
    Future.delayed(Duration(seconds: 1), () {
      emit(FetchedLocation(dummylocations));
    });
  }

  void selectLocation(String id) {
    selectedLocationId = id;
    final chosenLocation = dummylocations
        .firstWhere((chosenlocation) => chosenlocation.id == selectedLocationId);
    emit(ChosenLocation(chosenLocation));
  }

    void confirmLocationMethod() {
    emit(ConfirmLocationLoading());
    Future.delayed(Duration(seconds: 1), () {

      var chosenLocationMethod = dummylocations
          .firstWhere((paymentCard) => paymentCard.id == selectedLocationId);
      var previousLocationMethod = dummylocations
          .firstWhere((paymentCard) => paymentCard.isChosen == true, orElse: () => dummylocations.first );

      chosenLocationMethod = chosenLocationMethod.copyWith(isChosen: true);
      previousLocationMethod = previousLocationMethod.copyWith(isChosen: false);

      var chosenIndex = dummylocations
          .indexWhere((paymentCard) => paymentCard.id == chosenLocationMethod.id);
      var previousIndex = dummylocations
          .indexWhere((paymentCard) => paymentCard.id == previousLocationMethod.id);

       dummylocations[chosenIndex] = chosenLocationMethod  ;
       dummylocations[previousIndex] = previousLocationMethod ;
      emit(ConfirmLocationSuccess());
    });
  }
}
