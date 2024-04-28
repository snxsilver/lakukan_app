class Products {
  Products({
    required this.products,
    required this.total,
  });

  List<Product> products;
  int total;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        products: List<Product>.from(
            json["products"].map((item) => Product.fromJson(item))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((item) => item.toJson())),
        "total": total,
      };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  int id;
  String title;
  String description;
  dynamic price;
  double discountPercentage;
  double rating;
  dynamic stock;
  String brand;
  String category;
  String thumbnail;
  List<dynamic> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: (json['price'] is int)
            ? json['price'] as int
            : int.parse(json['price']),
        discountPercentage: json['discountPercentage'].toDouble() as double,
        rating: json['rating'].toDouble() as double,
        stock: (json['stock'] is int)
            ? json['stock'] as int
            : int.parse(json['stock']),
        brand: json['brand'] as String,
        category: json['category'] as String,
        thumbnail: json['thumbnail'] as String,
        images: json['images'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images,
      };
}
