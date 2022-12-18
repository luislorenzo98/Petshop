import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:pet_shop_app/models/ProductoModel.dart';
import 'package:pet_shop_app/pages/HomePage.dart';

class Listado extends StatefulWidget {
  const Listado({Key? key}) : super(key: key);
  static const ruta = '/Listado';

  @override
  State<Listado> createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  //bool isFirst = true;
  //var llamadas2;

  @override
  Widget build(BuildContext context) {

    //return FutureBuilder(future: getTimer(),builder: (context,data){
    /*TextEditingController tiempo = TextEditingController();
    tiempo.value=TextEditingValue();*/
    return Scaffold(
      //backgroundColor: Color(0xff829495),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(103, 58, 183, 1),
        title: Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }, icon: Icon(Icons.arrow_back,color: Colors.white),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                alignment: Alignment.centerLeft,
                child: const Text('Productos Favoritos',style: TextStyle(
                    fontSize: 20
                ),),
              ),
            ],
          ),
        ),
      ),
      body: listadowidget(),
    );
  }
  Widget listadowidget() => FutureBuilder(
    future: getProductos(),
    builder: (context, data) {
      if (data.hasError) {
        return Scaffold(
            resizeToAvoidBottomInset : false,
            body: /*Text("${data.error}")*/
            Container(
              constraints: const BoxConstraints.expand(),
              child: const Text("NO HAY PRODUCTOS FAVORITOS",textAlign: TextAlign.center,style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                backgroundColor: Colors.white,
              ),
              ),
            )
        );
      } else if (data.hasData) {
        var favos;
        favos = data.data as List<ProductoModel>;
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: favos.length==0? const Text("NO HAY PRODUCTOS MARCADOS COMO FAVORITOS",style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              ):Text("HAY ${favos.length} PRODUCTOS MARCADOS COMO FAVORITOS",style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),),
            ),
            ListView.separated(
                shrinkWrap: true,
                // ignore: unnecessary_null_comparison
                itemCount:  favos.length,
                // itemCount: llamadas == null ? 0 : llamadas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      quitarProducto(favos[index].id);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                      super.widget), (Route<dynamic> route) => false);
                    },
                    child: Material(
                      color: const Color.fromRGBO(103, 58, 183, 0.18823529411764706),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      child:ListTile(
                        title: Text(
                          favos[index].nombre,
                          style: const TextStyle(fontSize: 24, color: Color.fromRGBO(0, 0, 0, 1)),
                        ),
                        subtitle: Text(
                          favos[index].descripcion.toString(),
                          style: const TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        ),
                        trailing: Text(
                          favos[index].precio.toStringAsFixed(2)+"€",
                          style: const TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(height: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                //anchor: 1.0,
              ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );

  Future<List<ProductoModel>> getProductos() async {

    var url = "http://192.168.29.2/petshop/actions/listarFavoritos.php";

    final response = await http.post(Uri.parse(url),
        headers: {"Access-Control-Allow-Origin":"*", "Content-Type": "application/json"});

    final Map<String, dynamic> decodedJson = json.decode(response.body) ;
    final List<dynamic> jsonList = decodedJson['data'];
    print(response.body);
    return jsonList.map((json) => ProductoModel.fromJson(json)).toList();
  }

  Future<void> quitarProducto(int? id) async {
    var url = "http://192.168.29.2/petshop/actions/quitarFavorito.php?id=$id";

    final response = await http.post(Uri.parse(url),
        //headers: {"Access-Control-Allow-Origin":"*", "Content-Type": "application/json"},
        body: ({
          'id': id.toString(),
          'favorito': 0.toString(),
        }));
  }
}