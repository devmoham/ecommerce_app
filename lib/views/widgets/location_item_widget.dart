import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:flutter/material.dart';

class LocationItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color borderColor;
  final LocationItemModel location;
  const LocationItemWidget(
      {super.key,
      this.borderColor = Colors.grey,
      required this.location,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location.city),
                  Text('${location.city}, ${location.country}'),
                ],
              ),
              Stack(alignment: Alignment.center, children: [
                CircleAvatar(
                  backgroundColor: borderColor,
                  radius: 40,
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    location.imgUrl,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
