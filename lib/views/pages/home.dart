import 'package:ecommerce_app/views/widgets/catagorey_tabview.dart';
import 'package:ecommerce_app/views/widgets/home_tabview.dart';
import 'package:ecommerce_app/views_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabBarcontroller = TabController(length: 2, vsync: this);
  }

  late final TabController _tabBarcontroller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
          final cubit = HomeCubit();
          cubit.getHomeData();
          return cubit;
        },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TabBar(
                  unselectedLabelColor: Colors.grey,
                  controller: _tabBarcontroller,
                  tabs: const [
                    Tab(
                      text: 'home',
                    ),
                    Tab(
                      text: 'Catagory',
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabBarcontroller,
                    children: const [HomeTabView(), CatagoreyTabView()]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
