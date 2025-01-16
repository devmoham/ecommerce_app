import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/pages/custom_cliper-container.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views/widgets/primary_header_container.dart';
import 'package:ecommerce_app/views/widgets/settings_menu_tile.dart';
import 'package:ecommerce_app/views/widgets/user_profile_tile.dart';
import 'package:ecommerce_app/views_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
                clipper: CustomCurvedEdges(),
                child: PrimaryHeaderContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 30),
                        child: Text(
                          'Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      UserProfileTile(),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    child: Text(
                      'Account Settings',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SettingsMenuTile(
                      icon: Icons.location_city_rounded,
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address'),
                  SettingsMenuTile(
                      icon: CupertinoIcons.cart,
                      title: 'My Cart',
                      subTitle: 'Add,remove products and move to checkout'),
                  SettingsMenuTile(
                      icon: CupertinoIcons.bag,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders'),
                  SettingsMenuTile(
                      icon: Icons.location_city_outlined,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account'),
                  SettingsMenuTile(
                      icon: CupertinoIcons.gift,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons'),
                  SettingsMenuTile(
                      icon: CupertinoIcons.bell,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notificaton message'),
                  SettingsMenuTile(
                      icon: CupertinoIcons.folder_badge_plus,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    child: Text(
                      'App Settings',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SettingsMenuTile(
                      icon: CupertinoIcons.arrow_down_to_line,
                      title: 'Load Data',
                      subTitle: 'Upload data to your Cloud Firebase'),
                  SettingsMenuTile(
                    icon: CupertinoIcons.location_solid,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  SettingsMenuTile(
                    icon:
                        CupertinoIcons.person_crop_circle_fill_badge_checkmark,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SettingsMenuTile(
                    icon: CupertinoIcons.photo,
                    title: 'HD Image Quailty',
                    subTitle: 'Set image quailty to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              current is AuthLoggedOut || current is AuthLogOutError,
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                AppRoute.loginRoute,
                (route) => false,
              );
            } else if (state is AuthLogOutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMassage),
                ),
              );
            }
          },
          buildWhen: (previous, current) => current is AuthLoggingOut,
          builder: (context, state) {
            if (state is AuthLoggingOut) {
              return MainButton(
                isLoading: true,
              );
            }
            return MainButton(
              text: 'Logout',
              onTap: () async => await cubit.logOut(),
            );
          },
        ),),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
