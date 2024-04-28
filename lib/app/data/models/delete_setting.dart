class DeleteSetting {
  DeleteSetting({
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
    required this.isDeleted,
    required this.deletedOn,
  });

  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;
  bool isDeleted;
  DateTime deletedOn;

  factory DeleteSetting.fromJson(Map<String, dynamic> json) => DeleteSetting(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: json['price'] as int,
        discountPercentage: json['discountPercentage'] as double,
        rating: json['rating'] as double,
        stock: json['stock'] as int,
        brand: json['brand'] as String,
        category: json['category'] as String,
        thumbnail: json['thumbnail'] as String,
        images: json['images'] as List<String>,
        isDeleted: json['isDeleted'] as bool,
        deletedOn: json['deletedOn'] as DateTime,
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
        'isDeleted': isDeleted,
        'deletedOn': deletedOn,
      };
}
