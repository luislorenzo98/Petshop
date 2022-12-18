class CategoriaModel {
  //data Type
  int? id;
  String? nombre;
  String? url_categoria;
  String? descripcion;
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
  CategoriaModel(
      {
        /*  this.id,
        this.startdate,
        */
        this.id,
        this.nombre,
        this.url_categoria,
        this.descripcion,
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
  CategoriaModel.fromJson(Map<String,dynamic> json)
  {
    /*id = json['id'];
    startdate =json['startdate'];
    stopdate = json['stopdate'];*/
    id = int.parse(json['id']);
    nombre = json['nombre'];
    url_categoria = json['url_categoria'];
    descripcion = json['descripcion'];
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
