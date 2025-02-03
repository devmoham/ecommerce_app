import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productitem;

  const ProductItem({super.key, required this.productitem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Stack(children: [
                Image.network(
                  productitem.imagUrl,
                  height: 120,
                  width: 190,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 10,
                  left: 150,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white54),
                      height: 33,
                      width: 33,
                      child: const Icon(Icons.favorite_border),
                    ),
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            productitem.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            productitem.catagory,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 12, color: Colors.grey),
          ),
          Text(
            '${productitem.price} \$',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
