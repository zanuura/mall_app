class ProductModel {
  final String imagePath;
  final String title;
  final String salonName;
  final double price;
  final double? oldPrice;

  ProductModel({
    required this.imagePath,
    required this.title,
    required this.salonName,
    required this.price,
    this.oldPrice,
  });

  String get priceText => 'RM ${price.toStringAsFixed(2)}';
  String? get oldPriceText =>
      oldPrice != null ? 'RM ${oldPrice!.toStringAsFixed(2)}' : null;
  String? get discountPercentText {
    if (oldPrice != null && oldPrice! > price) {
      final discount = ((oldPrice! - price) / oldPrice!) * 100;
      return '${discount.round()}%';
    }
    return null;
  }
}

// Dummy Data
final List<ProductModel> products = [
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 50.00,
    oldPrice: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 50.00,
    oldPrice: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 50.00,
    oldPrice: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 100.00,
  ),
  ProductModel(
    imagePath: 'assets/Image.jpg',
    title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    salonName: 'Lorem Ipsum',
    price: 50.00,
    oldPrice: 100.00,
  ),
  // Tambahkan produk dummy lainnya
];
