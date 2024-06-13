// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductsModel {
  String? productId;
  final String productName;
  final String category;
  final String productDescription;
  final String price;
  final String color;
  final String quantity;
  final String image;
  final String imageUrl;

  ProductsModel({
    this.productId,
    required this.productName,
    required this.category,
    required this.productDescription,
    required this.price,
    required this.color,
    required this.quantity,
    required this.image,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'category': category,
      'productDescription': productDescription,
      'price': price,
      'color': color,
      'quantity': quantity,
      'image': image,
      'imageUrl':imageUrl,
    };
  }

  factory ProductsModel.fromMap({required Map<String, dynamic> map,String? productId}) {
    return ProductsModel(
      productId: productId,
      productName: map['productName'] as String,
      category: map['category'] as String,
      productDescription: map['productDescription'] as String,
      price: map['price'] as String,
      color: map['color'] as String,
      quantity: map['quantity'] as String,
      image: map['image'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ProductsModel.fromJson(String source) => ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
