class SubmitSetting {
  SubmitSetting({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.description,
    required this.brand,
    required this.category,
  });

  int id;
  String title;
  String price;
  String stock;
  String description;
  String brand;
  String category;

  factory SubmitSetting.fromJson(Map<String, dynamic> json) => SubmitSetting(
        id: json['id'] as int,
        title: json['title'] as String,
        price: json['price'] as String,
        stock: json['stock'] as String,
        description: json['description'] as String,
        brand: json['brand'] as String,
        category: json['category'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'stock': stock,
        'description': description,
        'brand': brand,
        'category': category,
      };
}
