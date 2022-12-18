import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/login/Login.dart';
import 'package:pet_shop_app/pages/CartPage.dart';
import 'package:pet_shop_app/pages/DetailPage.dart';
import 'package:pet_shop_app/provider/CartProvider.dart';
import 'package:pet_shop_app/widgets/CategoryItem.dart';
import 'package:pet_shop_app/widgets/ProductItem.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/CategoriaModel.dart';
import '../models/ProductoModel.dart';
import '../models/ProductosCategoria.dart';
import 'HomePage.dart';

class ProductosCategoriaPage extends StatefulWidget{
  final int idCategoria;

  const ProductosCategoriaPage({Key? key, required this.idCategoria}) : super(key: key);

  @override
  State<ProductosCategoriaPage> createState() => _ProductosPorCategoriaState();

}

class _ProductosPorCategoriaState extends State<ProductosCategoriaPage> {

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo/gris.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: getListarCategorias(widget.idCategoria.toString()),
          builder: (context, data) {
            if (data.hasError) {
              return Text("PACO""${data.error}");
            } else if (data.hasData) {
              var prodCat = data.data as List<ProductosCategoria>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) =>
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.deepPurpleAccent,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => HomePage()));
                                }, icon: Icon(Icons.arrow_back,color: Colors.white),
                              ),
                              Text('${prodCat[index].c_nombre?.toUpperCase()}',textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                //backgroundColor: Colors.deepPurpleAccent,
                              ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: List.generate(
                                  prodCat.length,
                                      (index) => Padding(
                                    padding: index == 0
                                        ? const EdgeInsets.only(left: 20, right: 20)
                                        : const EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailPageCategoria(
                                                    productC: prodCat[index])));
                                      },
                                      child: ProductItemCategorias(
                                        productC: prodCat[index],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),

              );
            }else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<ProductosCategoria>> getListarCategorias(String idCategoria) async {
    final response = await http.post(Uri.parse("http://192.168.29.2/petshop/actions/obtener_productosCategorias.php?id_categoria=$idCategoria"));
    final Map<String, dynamic> decodedJson = json.decode(response.body) ;
    final List<dynamic> jsonList = decodedJson['datos'];
    return jsonList.map((json) => ProductosCategoria.fromJson(json)).toList();
  }

  Future<List<ProductoModel>> getProductos() async {

    var url = "http://192.168.29.2/petshop/actions/obtener_productos.php";

    final response = await http.post(Uri.parse(url),
        headers: {"Access-Control-Allow-Origin":"*", "Content-Type": "application/json"});

    final Map<String, dynamic> decodedJson = json.decode(response.body) ;
    final List<dynamic> jsonList = decodedJson['data'];
    //print(response.body);
    return jsonList.map((json) => ProductoModel.fromJson(json)).toList();
  }


}


