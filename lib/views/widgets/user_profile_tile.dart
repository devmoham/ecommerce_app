import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:flutter/material.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor:
            Colors.white, // Optional, in case you want a background color
        child: ClipOval(
          child: Image.asset(
            'assets/images/rb_174669.png',
            width: 60, // diameter = 2 * radius
            height: 60,
            fit: BoxFit
                .contain, 
          ),
        ),
      ),
      title: Text(
        'Mohamed Mostafa',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
      ),
      subtitle: Text(
        'mohamed.mostafa432100@gmail.com',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoute.profileRoute);
        },
        child: Image.asset(
          'assets/images/edit-button.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
