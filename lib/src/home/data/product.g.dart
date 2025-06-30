// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String,
  price: Price.fromJson(json['price'] as Map<String, dynamic>),
  phone: json['phone'] as String,
  category: json['category'] as String,
  location: ProductLocation.fromJson(json['location'] as Map<String, dynamic>),
  condition: json['condition'] as String,
  quantity: (json['quantity'] as num).toInt(),
  images:
      (json['images'] as List<dynamic>)
          .map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
  videos: (json['videos'] as List<dynamic>).map((e) => e as String).toList(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  owner: json['owner'] as String?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'phone': instance.phone,
  'category': instance.category,
  'location': instance.location,
  'condition': instance.condition,
  'quantity': instance.quantity,
  'images': instance.images,
  'videos': instance.videos,
  'tags': instance.tags,
  'owner': instance.owner,
};

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
};

ProductLocation _$ProductLocationFromJson(Map<String, dynamic> json) =>
    ProductLocation(
      location: json['location'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$ProductLocationToJson(ProductLocation instance) =>
    <String, dynamic>{
      'location': instance.location,
      'details': instance.details,
    };

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) => ImageInfo(
  high: json['high'] as String?,
  med: json['med'] as String?,
  low: json['low'] as String?,
);

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
  'high': instance.high,
  'med': instance.med,
  'low': instance.low,
};
