// ignore_for_file: public_member_api_docs, sort_constructors_first
class CatagoreyItem {
  final String name;
  final String imagUrl;
  final String prodcount;

  CatagoreyItem({
    required this.name,
    required this.imagUrl,
    required this.prodcount,
  });
}

List<CatagoreyItem> catagoreys = [
  CatagoreyItem(
      name: 'New Arrivals',
      imagUrl: 'assets/images/catagories/t-shirt-.png',
      prodcount: '208'),
  CatagoreyItem(
      name: 'Clothes',
      imagUrl: 'assets/images/catagories/Polo-Black-PNG-Free-File-Download.png',
      prodcount: '358'),
  CatagoreyItem(
      name: 'Bags',
      imagUrl:
          'assets/images/catagories/jokta3eqk4qoo8ccrvgfps5t2e-05f50dc3eefb990a207120b52cbe94fa.png',
      prodcount: '160'),
  CatagoreyItem(
      name: 'Shoes',
      imagUrl:
          'assets/images/catagories/jeans-t-shirt-shoulder-denim-sleeve-jeans-77b19fd2eb02c454fdfe17daf2e30e15.png',
      prodcount: '230'),
  CatagoreyItem(
      name: 'Elecrtonics',
      imagUrl: 'assets/images/catagories/laptop.png',
      prodcount: '150'),
  CatagoreyItem(
      name: 'Accessories',
      imagUrl: 'assets/images/catagories/u77v1hhjettravshgkmdkus43l.png',
      prodcount: '240')
];
