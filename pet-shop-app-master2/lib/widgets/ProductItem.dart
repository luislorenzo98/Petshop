import 'package:flutter/material.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/models/ProductosCategoria.dart';
import 'package:pet_shop_app/provider/CartProvider.dart';
import 'package:provider/provider.dart';

import '../models/ProductoModel.dart';

class ProductItem extends StatelessWidget {
  final ProductoModel product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.31 + 60,
      width: MediaQuery.of(context).size.width * 0.5 - 30,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3 + 10,
              width: MediaQuery.of(context).size.width * 0.5 - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(3, 3),
                        color: black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5)
                  ]),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 20,
                        right: 20,
                        child: Container(
                          width: 100,
                          height: 120,
                          decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: Colors.deepOrange,
                                spreadRadius: 5,
                                blurRadius: 30)
                          ]),
                        ),
                      ),
                      Image(
                        image: NetworkImage('http://192.168.29.2/petshop/img/'+product.url_producto.toString()),
                        height: 180,
                      ),
                    ],
                  ),
                ),
                Text(
                  product.nombre!,
                  style: poppin.copyWith(
                      fontSize: 16, color: black, fontWeight: FontWeight.w400),
                ),
                Text(
                  '${(product.precio?.toInt())!.toStringAsFixed(2)}\€',
                  style: poppin.copyWith(
                      fontSize: 18, color: black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                cartProvider.addCart(product, 1);
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration:
                  const BoxDecoration(color: Colors.deepPurpleAccent, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '+',
                      style: poppin.copyWith(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class ProductItemCategorias extends StatelessWidget {
  final ProductosCategoria productC;
  const ProductItemCategorias({
    Key? key,
    required this.productC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.31 + 60,
      width: MediaQuery.of(context).size.width * 0.5 - 30,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3 + 10,
              width: MediaQuery.of(context).size.width * 0.5 - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(3, 3),
                        color: black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5)
                  ]),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 20,
                        right: 20,
                        child: Container(
                          width: 100,
                          height: 120,
                          decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: Colors.deepOrange,
                                spreadRadius: 5,
                                blurRadius: 30)
                          ]),
                        ),
                      ),
                      Image(
                        image: NetworkImage('http://192.168.29.2/petshop/img/'+ productC.url_producto.toString()),
                        height: 180,
                      ),
                    ],
                  ),
                ),
                Text(
                  productC.nombre!,
                  style: poppin.copyWith(
                      fontSize: 16, color: black, fontWeight: FontWeight.w400),
                ),
                Text(
                  '${(productC.precio)!.toStringAsFixed(2)}\€',
                  style: poppin.copyWith(
                      fontSize: 18, color: black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                cartProvider.addCart2(productC, 1);
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration:
                  const BoxDecoration(color: Colors.deepPurpleAccent, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '+',
                      style: poppin.copyWith(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
