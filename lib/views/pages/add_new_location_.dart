import 'package:ecommerce_app/views/widgets/location_item_widget.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views_models/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewLocation extends StatefulWidget {
  const AddNewLocation({super.key});

  @override
  State<AddNewLocation> createState() => _AddNewLocationState();
}

class _AddNewLocationState extends State<AddNewLocation> {
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LocationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your location',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Let\'s find an unforgettable event. Choose a location below to get start:',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: const Icon(Icons.location_on),
                      prefixIconColor: Colors.grey,
                      suffixIcon: BlocConsumer<LocationCubit, LocationState>(
                        bloc: cubit,
                        listenWhen: (previous, current) =>
                            current is LocationAdded ||
                            current is ConfirmLocationSuccess,
                        listener: (context, state) {
                          if (state is LocationAdded) {
                            return locationController.clear();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        buildWhen: (previous, current) =>
                            current is LocationAdding ||
                            current is LocationAdded ||
                            current is LocationFailure,
                        builder: (context, state) {
                          if (state is LocationAdding) {
                            return const CircularProgressIndicator();
                          }
                          return IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cubit.addLocation(locationController.text);
                            },
                          );
                        },
                      ),
                      suffixIconColor: Colors.grey,
                      hintText: 'write your location',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey[700]),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ))),
              const SizedBox(
                height: 34,
              ),
              Text(
                'Select Location',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 14,
              ),
              BlocBuilder<LocationCubit, LocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is FetchingLocation ||
                    current is FetchedLocation ||
                    current is FetchLocationError,
                builder: (context, state) {
                  if (state is FetchingLocation) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is FetchedLocation) {
                    final locations = state.locations;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 5),
                          child: BlocBuilder<LocationCubit, LocationState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is ChosenLocation,
                            builder: (context, state) {
                              if (state is ChosenLocation) {
                                final chosenLocation = state.location;
                                return LocationItemWidget(
                                    onTap: () {
                                      cubit.selectLocation(location.id);
                                    },
                                    borderColor:
                                        chosenLocation.id == location.id
                                            ? Colors.deepPurple.shade400
                                            : Colors.grey.shade300,
                                    location: location);
                              }
                              return LocationItemWidget(
                                  onTap: () {
                                    cubit.selectLocation(location.id);
                                  },
                                  location: location);
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is FetchLocationError) {
                    return Center(
                      child: Text(state.massge),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(
                height: 60,
              ),
              BlocBuilder<LocationCubit, LocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is ConfirmLocationLoading ||
                    current is ConfirmLocationSuccess ||
                    current is ConfirmLocationfailure,
                builder: (context, state) {
                  if (state is ConfirmLocationLoading) {
                    return MainButton(
                      height: 45,
                      isLoading: true,
                      onTap: null,
                    );
                  }
                  return MainButton(
                    height: 45,
                    text: 'Confirm Address',
                    onTap: () {
                      cubit.confirmLocationMethod();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
