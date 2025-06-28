import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String title;
  final String description;
  final Price price;
  final String phone;
  final String category;
  final ProductLocation location;
  final String condition;
  final int quantity;
  final List<ImageInfo> images;
  final List<String> videos;
  final List<String> tags;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.phone,
    required this.category,
    required this.location,
    required this.condition,
    required this.quantity,
    required this.images,
    required this.videos,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Price {
  final int amount;
  final String currency;

  Price({required this.amount, required this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class ProductLocation {
  final String location;
  final String details;

  ProductLocation({required this.location, required this.details});

  factory ProductLocation.fromJson(Map<String, dynamic> json) =>
      _$ProductLocationFromJson(json);
  Map<String, dynamic> toJson() => _$ProductLocationToJson(this);
}

@JsonSerializable()
class ImageInfo {
  final String high;
  final String med;
  final String low;

  ImageInfo({required this.high, required this.med, required this.low});

  factory ImageInfo.fromJson(Map<String, dynamic> json) =>
      _$ImageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);
}
