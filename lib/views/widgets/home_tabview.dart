import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/widgets/product_item.dart';
import 'package:ecommerce_app/views_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  @override
  Widget build(BuildContext context) {
    final CarouselSliderController _controller = CarouselSliderController();
    int _current = 0;
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoadding) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: state.dummyHomeCarouselItems.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        state.dummyHomeCarouselItems[index].imgUrl,
                        fit: BoxFit.fill,
                        height: isLandScape
                            ? size.height * 0.6
                            : size.height * 0.15,
                        width: double.infinity,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    autoPlay: true,

                    enlargeCenterPage: true,
                    aspectRatio: 18 / 8,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    // enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: _current,
                    count: state.dummyHomeCarouselItems.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 16,
                      dotColor: Colors.black26,
                      activeDotColor: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'New Arrivals',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()=> Navigator.of(context,rootNavigator: true).pushNamed(AppRoute.productDetailsRoute ,arguments:state.products[index].id ),
                      child: ProductItem(productitem: state.products[index]));
                  },
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
