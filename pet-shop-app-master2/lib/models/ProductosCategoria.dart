class ProductosCategoria {
  //data Type
  int? id;
  /*
  String? startdate;
  */
  double? precio;
  String? nombre;
  String? descripcion;
  String? categoria;
  String? c_nombre;
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
  ProductosCategoria(
      {
        /*  this.id,
        this.startdate,
        */
        this.id,
        this.nombre,
        this.descripcion,
        this.precio,
        this.categoria,
        this.c_nombre,
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
  //method that assign values to respective datatype vairables
  ProductosCategoria.fromJson(Map<String,dynamic> json)
  {
    /*id = json['id'];
    startdate =json['startdate'];
    stopdate = json['stopdate'];*/
    id = int.parse(json['id']);
    nombre =json['nombre'];
    descripcion = json['descripcion'];
    precio = double.parse(json['precio']);
    categoria = json['categoria'];
    c_nombre = json['c_nombre'];
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
