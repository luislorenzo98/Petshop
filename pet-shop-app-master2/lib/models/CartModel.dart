import 'package:pet_shop_app/models/ProductosCategoria.dart';

import 'ProductoModel.dart';
import 'ProductosCategoria.dart';


class CartModel {
  int? id;
  ProductoModel? product;
  ProductosCategoria? productC;
  int? quantity;
  String? url_producto;

  CartModel({
    required this.id,
    required this.product,
    required this.productC,
    required this.quantity,
    required this.url_producto,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    product = ProductoModel.fromJson(json['product']);
    productC = ProductosCategoria.fromJson(json['productC']);
    quantity = int.parse(json['quantity']);
    url_producto = (json['url_producto']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'productC': productC,
      'quantity': quantity,
      'url_producto': url_producto,
    };
  }

  double getTotalPrice() {
    return product!.precio! * quantity!;
  }
}
