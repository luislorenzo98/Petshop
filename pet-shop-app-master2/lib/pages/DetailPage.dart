import 'package:flutter/material.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/models/ProductoModel.dart';
import 'package:pet_shop_app/models/ProductosCategoria.dart';
import 'package:pet_shop_app/provider/CartProvider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {


  final ProductoModel product;
  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    void _toggleFavorite() {
      setState(() {
        if (_isFavorited) {
          _favoriteCount -= 1;
          _isFavorited = false;
          marcarComoFavorito(widget.product.id);
        } else {
          _favoriteCount += 1;
          _isFavorited = true;
        }
      });
    }
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: black.withOpacity(0.7),
            size: 18,
          ),
        ),
      ),
      backgroundColor: white,
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 - 10,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.2,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.deepPurpleAccent,
                              offset: Offset.zero,
                              blurRadius: 100,
                              spreadRadius: 0)
                        ],
                      ),
                    ),
                  ),
                  Image(
                    image: NetworkImage('http://192.168.29.2/petshop/img/'+ widget.product.url_producto.toString()),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.nombre!,
                  style: poppin.copyWith(
                      fontSize: 18, color: black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.product.descripcion!,
                  maxLines: 4,
                  style: poppin.copyWith(
                      height: 1.5, fontSize: 14, color: black.withOpacity(0.5)),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: const Icon(Icons.add, color: grey)),
                          const SizedBox(width: 20),
                          Text(
                            '$quantity',
                            style: poppin,
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: const Icon(Icons.remove, color: grey)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${(quantity * widget.product.precio!).toStringAsFixed(2)}\€',
                      style: poppin.copyWith(
                          fontSize: 32,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                marcarComoFavorito(widget.product.id);
              },

              child: IconButton(
                icon: (_isFavorited ? Icon(Icons.favorite_border) : Icon(Icons.favorite)),
                color: Colors.red[500],
                onPressed: _toggleFavorite,
              ),
            ),
            const SizedBox(width: 25),
            GestureDetector(
              onTap: () {
                cartProvider.addCart(widget.product, quantity);
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart_outlined, color: white),
                      const SizedBox(width: 10),
                      Text(
                        'Añadir al carrito',
                        style: poppin.copyWith(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}


class DetailPageCategoria extends StatefulWidget {
  final ProductosCategoria productC;
  const DetailPageCategoria({Key? key, required this.productC}) : super(key: key);

  @override
  State<DetailPageCategoria> createState() => _DetailPageCategoriaState();
}

class _DetailPageCategoriaState extends State<DetailPageCategoria> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: black.withOpacity(0.7),
            size: 18,
          ),
        ),
      ),
      backgroundColor: white,
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 - 10,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.2,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.orange,
                              offset: Offset.zero,
                              blurRadius: 100,
                              spreadRadius: 0)
                        ],
                      ),
                    ),
                  ),
                  Image(
                    image: NetworkImage('http://192.168.29.2/petshop/img/'+ widget.productC.url_producto.toString()),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productC.nombre!,
                  style: poppin.copyWith(
                      fontSize: 18, color: black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.productC.descripcion!,
                  maxLines: 4,
                  style: poppin.copyWith(
                      height: 1.5, fontSize: 14, color: Colors.black38),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: const Icon(Icons.add, color: grey)),
                          const SizedBox(width: 20),
                          Text(
                            '$quantity',
                            style: poppin,
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: const Icon(Icons.remove, color: grey)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${(quantity * widget.productC.precio!).toStringAsFixed(2)}\€',
                      style: poppin.copyWith(
                          fontSize: 32,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                marcarComoFavorito(widget.productC.id);
              },
              child: Icon(
                Icons.favorite_border,
                size: 32,
                color: grey,
              ),
            ),
            const SizedBox(width: 25),
            GestureDetector(
              onTap: () {
                cartProvider.addCart2(widget.productC, quantity);
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart_outlined, color: white),
                      const SizedBox(width: 10),
                      Text(
                        'Añadir al carrito',
                        style: poppin.copyWith(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}

Future<void> marcarComoFavorito(int? id) async {
  var url = "http://192.168.29.2/petshop/actions/marcarFavorito.php?id=$id";

  final response = await http.post(Uri.parse(url),
      //headers: {"Access-Control-Allow-Origin":"*", "Content-Type": "application/json"},
      body: ({
        'id': id.toString(),
        'favorito': 1.toString(),
      }));
}