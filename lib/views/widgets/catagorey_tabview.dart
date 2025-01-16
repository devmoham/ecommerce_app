import 'package:ecommerce_app/models/catagory_model.dart';
import 'package:flutter/material.dart';

class CatagoreyTabView extends StatelessWidget {
  const CatagoreyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: catagoreys.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  colors: [Colors.grey.shade300, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        catagoreys[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${catagoreys[index].prodcount} Product',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        catagoreys[index].imagUrl,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 250,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
