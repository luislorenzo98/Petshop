import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_shop_app/const.dart';
import 'package:pet_shop_app/fav/Listado.dart';
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
import 'ProductosCategoriasPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  var selectedCategory = "food";

  List<IconData> icons = [
    Icons.home_filled,
    Icons.person_outline_rounded,
    Icons.favorite_border_rounded,
    Icons.chat_outlined,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: Container(
        alignment: Alignment.topCenter,
        /*decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fonfdo/gris.png'),
            fit: BoxFit.cover,
          ),
        ),*/
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Petshop',
                        style: poppin.copyWith(
                          fontSize: 20,
                          color: black,
                          fontWeight: FontWeight.bold,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartPage()));
                      },
                      child: SizedBox(
                        height: 35,
                        width: 30,
                        child: Stack(
                          children: [
                            const Positioned(
                              bottom: 0,
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: black,
                              ),
                            ),
                            cartProvider.carts.isNotEmpty
                                ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: deepPurple,
                                  ),
                                  child: Text(
                                    '${cartProvider.carts.length}',
                                    style: poppin.copyWith(color: white),
                                  )),
                            )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => const Login()),(route)=> false);

                      },
                      child: SizedBox(
                        height: 35,
                        width: 30,
                        child: Stack(
                          children: [
                            const Positioned(
                              bottom: 0,
                              child: Icon(
                                Icons.login,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: grey.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscador de productos',
                        hintStyle:
                        poppin.copyWith(color: black.withOpacity(0.6)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: black,
                        ),
                        prefixIconColor: white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: getCategorias(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Text("ErrorCategorias""${data.error}");
                  } else if (data.hasData) {
                    var categorias = data.data as List<CategoriaModel>;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) => Container(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                categorias.length,
                                    (index) => Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.only(left: 20, right: 20)
                                      : const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => ProductosCategoriaPage(idCategoria: int.parse("${categorias[index].id}"))));
                                    },
                                    child: CategoryItem(
                                      category: categorias[index],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),

                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Todos los productos',
                      style: poppin.copyWith(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: getProductos(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Text("ErrorProductos""${data.error}");
                  } else if (data.hasData) {
                    var productos = data.data as List<ProductoModel>;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) => Container(
                        height: 350,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                productos.length,
                                    (index) => Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.only(left: 20, right: 20)
                                      : const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  product: productos[index])));
                                    },
                                    child: ProductItem(
                                      product: productos[index],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),

                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pack especial',
                      style: poppin.copyWith(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width - 40,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: purple.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: -10,
                      child: Transform.rotate(
                        angle: -0.15,
                        child: Image.asset(
                          'assets/foods/meow-mix1.png',
                          height: 120,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 7,
                      left: 50,
                      child: Transform.rotate(
                        angle: 0.3,
                        child: Image.asset(
                          'assets/foods/authority1.png',
                          height: 120,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Transform.rotate(
                        angle: 0,
                        child: Image.asset(
                          'assets/foods/royal-canin1.png',
                          height: 120,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 190,
                      top: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pack especial',
                            style: poppin.copyWith(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Oferta especial\n 3x1',
                            style: poppin.copyWith(color: white, fontSize: 14),
                          ),
                          Text(
                            '${40}\€',
                            style: poppin.copyWith(
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
            backgroundColor: white,
            selectedItemColor: deepPurple,
            unselectedItemColor: grey,
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Listado()));
            },
            items: List.generate(
                icons.length,
                (index) => BottomNavigationBarItem(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icons[index],
                          color: selectedPage == index ? deepPurple : grey,
                        ),
                        const SizedBox(height: 5),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: selectedPage == index ? 15 : 0,
                          height: selectedPage == index ? 3 : 0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: deepPurple),
                        )
                      ],
                    ),
                    label: ''))
        ),
      ),
    );
  }
}

Future<List<ProductoModel>> getProductos() async {

  var url = "http://192.168.29.2/petshop/actions/obtener_productos.php";

  final response = await http.post(Uri.parse(url),
      headers: {"Access-Control-Allow-Origin":"*", "Content-Type": "application/json"});

  final Map<String, dynamic> decodedJson = json.decode(response.body) ;
  final List<dynamic> jsonList = decodedJson['data'];
  print(response.body);
  return jsonList.map((json) => ProductoModel.fromJson(json)).toList();
}

Future<List<CategoriaModel>> getCategorias() async {

  var url = "http://192.168.29.2/petshop/actions/obtener_categorias.php";

  final response = await http.post(Uri.parse(url),
      headers: {"Access-Control-Allow-Origin":"*", "Content-Type": "application/json"});

  final Map<String, dynamic> decodedJson = json.decode(response.body) ;
  final List<dynamic> jsonList = decodedJson['data'];
  //print(response.body);
  return jsonList.map((json) => CategoriaModel.fromJson(json)).toList();
}
