import 'package:ecommerce_app/views/widgets/profile_menu.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Profile',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/rb_174669.png',
                            width: 80, // diameter = 2 * radius
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text('Change Profile Picture')),
                    ],
                  ),
                ),
              ),
              Divider(
                  // indent: 5,
                  // endIndent: 5,
                  ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Profile Information',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ProfileMenuItem(
                  title: 'Name', value: 'Mohamed Mostafa', onPressed: () {}),
              ProfileMenuItem(
                  title: ' Username', value: 'Mohamed_dev', onPressed: () {}),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Text(
                'Personal Information',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              ProfileMenuItem(
                title: 'User ID',
                value: '43789',
                onPressed: () {},
                icon: Icons.copy,
              ),
              ProfileMenuItem(
                  title: 'E- mail',
                  value: 'mohamed.mostafa4321002gmail.com',
                  onPressed: () {}),
              ProfileMenuItem(title: 'Gender', value: 'Male', onPressed: () {}),
              ProfileMenuItem(
                  title: 'Date of birth',
                  value: '11 Nov, 2004',
                  onPressed: () {}),
              Divider(),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Close Account',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.red),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
