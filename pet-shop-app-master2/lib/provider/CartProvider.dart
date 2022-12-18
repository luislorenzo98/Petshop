import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/ProductosCategoria.dart';
import 'package:pet_shop_app/models/CartModel.dart';


import '../models/ProductoModel.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductoModel product, int qunatity) {
    if (productExist(product)) {
      int index =
      _carts.indexWhere((element) => element.product!.id == product.id);
      _carts[index].quantity = _carts[index].quantity! + qunatity;
    } else {
      _carts.add(
          CartModel(id: _carts.length, product: product, quantity: qunatity, productC: null, url_producto: ''));
    }
    notifyListeners();
  }

  addCart2(ProductosCategoria productC, int qunatity) {
    if (productExist2(productC)) {
      int index =
      _carts.indexWhere((element) => element.product!.id == productC.id);
      _carts[index].quantity = _carts[index].quantity! + qunatity;
    } else {
      _carts.add(
          CartModel(id: _carts.length, productC: productC, quantity: qunatity, product: new ProductoModel(id: productC.id, descripcion: productC.descripcion, categoria: productC.categoria, nombre: productC.nombre, precio: productC.precio), url_producto: productC.url_producto ));
    }
    notifyListeners();
  }

  removeCart(int id) {
    _carts.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  productExist(ProductoModel product) {
    if (_carts.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
  productExist2(ProductosCategoria productC) {
    if (_carts.indexWhere((element) => element.product!.id == productC.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  totalPrice() {
    double total = 0;
    for (var element in _carts) {
      total += (element.quantity! * element.product!.precio!);
    }
    return total;
  }
}
