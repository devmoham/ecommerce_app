import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/widgets/counter_widget.dart';
import 'package:ecommerce_app/views_models/productdetails_cubit/product_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPageDetails extends StatelessWidget {
  final String productId;
  const ProductPageDetails({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) =>
          current is ProductDetailsLoadding || current is ProductDetailsLoaded,
      bloc: BlocProvider.of<ProductDetailsCubit>(context),
      builder: (context, state) {
        if (state is ProductDetailsLoadding) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back)),
              title: const Text('Product details'),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border))
              ],
            ),
            body: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: size.height * 0.50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.grey.shade300, Colors.white30])),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Image.network(
                          state.product.imagUrl,
                          height: size.height * 0.3,
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 400),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.product.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              BlocBuilder<ProductDetailsCubit,
                                      ProductDetailsState>(
                                  buildWhen: (previous, current) =>
                                      current is QuantityLoaded ||
                                      current is ProductDetailsLoaded,
                                  bloc: BlocProvider.of<ProductDetailsCubit>(
                                      context),
                                  builder: (context, state) {
                                    if (state is QuantityLoaded) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: CounterWidget(
                                            value: state.value,
                                            productId: productId,
                                            cubit: BlocProvider.of<
                                                ProductDetailsCubit>(context),
                                          ));
                                    } else if (state is ProductDetailsLoaded) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: CounterWidget(
                                            value: 1,
                                            productId: productId,
                                            cubit: BlocProvider.of<
                                                ProductDetailsCubit>(context),
                                          ));
                                    } else {
                                      return const SizedBox();
                                    }
                                  })
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade700,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('${state.product.rating} (320 Reviews)'),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Size',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            buildWhen: (previous, current) =>
                                current is ProductSelectedSize ||
                                current is ProductDetailsLoaded,
                            bloc: BlocProvider.of<ProductDetailsCubit>(context),
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: ProductSize.values
                                    .map((size) => Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 12),
                                          child: InkWell(
                                            onTap: () => BlocProvider.of<
                                                        ProductDetailsCubit>(
                                                    context)
                                                .selsctedSize(size),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color:
                                                    state is ProductSelectedSize &&
                                                            state.size == size
                                                        ? Colors.deepPurple
                                                        : Colors.grey.shade200,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  size.name,
                                                  style: TextStyle(
                                                    color:
                                                        state is ProductSelectedSize &&
                                                                state.size ==
                                                                    size
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Loreum Loreum Loreum Loreum Loreum Loreum\n'
                                'Loreum Loreum Loreum Loreum Loreum Loreum\n'
                                'Loreum Loreum Loreum Loreum Loreum Loreum\n'
                                'Loreum Loreum Loreum Loreum Loreum Loreum\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey.shade600),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                          text: '\$ ', // Normal text
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontSize: 30),
                                        ),
                                        TextSpan(
                                          text:
                                              '${state.product.price}', // Normal text

                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child: BlocBuilder<ProductDetailsCubit,
                                        ProductDetailsState>(
                                      bloc:
                                          BlocProvider.of<ProductDetailsCubit>(
                                              context),
                                      buildWhen: (previous, current) =>
                                          current is AddingToCart ||
                                          current is AddedToCart,
                                      builder: (context, state) {
                                        if (state is AddingToCart) {
                                          return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(50, 50),
                                                  backgroundColor:
                                                      Colors.deepPurpleAccent,
                                                  foregroundColor:
                                                      Colors.white),
                                              onPressed: null,
                                              child:
                                                  const CircularProgressIndicator
                                                      .adaptive());
                                        } else if (state is AddedToCart) {
                                          return const ElevatedButton(
                                              onPressed: null,
                                              child: Text('Added to cart'));
                                        } else {
                                          return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(50, 50),
                                                  backgroundColor:
                                                      Colors.deepPurpleAccent,
                                                  foregroundColor:
                                                      Colors.white),
                                              onPressed: () {
                                                if (BlocProvider.of<
                                                                ProductDetailsCubit>(
                                                            context)
                                                        .selectedsize !=
                                                    null) {
                                                  BlocProvider.of<
                                                              ProductDetailsCubit>(
                                                          context)
                                                      .addTocart(productId);
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please select size')));
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                      CupertinoIcons.bag),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'Add to Cart',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ));
                                        }
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                child: Text('something wrong'),
              ),
            ),
          );
        }
      },
    );
  }
}
