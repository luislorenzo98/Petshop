import 'package:pet_shop_app/models/ProductosCategoria.dart';

class ProductoModel {
  //data Type
  int? id;
  double? precio;
  String? nombre;
  String? descripcion;
  String? categoria;
  String? url_producto;
  /* String? dst;
  String? dstname;
  String? duration;
  String? cost;
  String? status;
  String? ip;
  String? useragent;
  String? plan;
  String? processed;
  String? comments;
*/
// constructor
  ProductoModel(
      {
        /*  this.id,
        this.startdate,
        */
        this.id,
        this.nombre,
        this.descripcion,
        this.precio,
        this.categoria,
        this.url_producto,
        /*    this.dst,
        this.dstname,
        this.duration,
        this.cost,
        this.status,
        this.ip,
        this.useragent,
        this.plan,
        this.processed,
        this.comments*/
      }
      );


  fromProductoC(ProductosCategoria productC){
    this.precio = productC.precio;
    this.nombre = productC.nombre;
    this.descripcion = productC.descripcion;
    this.categoria = productC.categoria;
    this.url_producto = productC.url_producto;
  }


  //method that assign values to respective datatype vairables
  ProductoModel.fromJson(Map<String,dynamic> json)
  {
    /*id = json['id'];
    startdate =json['startdate'];
    stopdate = json['stopdate'];*/
    id = int.parse(json['id']);
    nombre =json['nombre'];
    descripcion = json['descripcion'];
    precio = double.parse(json['precio']);
    categoria = json['categoria'];
    url_producto = json['url_producto'];
    /*
    dstname =json['dstname'];
    duration = json['duration'];
    cost =json['cost'];
    status = json['status'];
    ip =json['ip'];
    useragent = json['useragent'];
    plan =json['plan'];
    processed = json['processed'];
    comments =json['comments'];*/
  }

}
