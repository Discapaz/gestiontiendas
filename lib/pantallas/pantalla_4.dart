import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestiontiendas/pantallas/pantalla_5.dart';
import 'main.dart';


class pantalla_4 extends StatefulWidget {
  final String negocios;
  const pantalla_4(this.negocios,{Key? key}): super(key: key);

  @override
  _pantalla_4State createState() => _pantalla_4State();
}

class _pantalla_4State extends State <pantalla_4> {

  List listaproductos = [];
  List datos_negocios = [];

  void initState() {
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference datos = FirebaseFirestore.instance.collection("Productos");
    QuerySnapshot productos = await datos.where(
        "descripcion", isEqualTo: widget.negocios).get();

    if (productos.docs.length != 0) {
      print("tiene datos");
      for (var doc in productos.docs) {
        print(doc.data());
        listaproductos.add(doc);
      }
    } else {
      print("No tiene datos");
    }

    String id;
    CollectionReference datos2 = FirebaseFirestore.instance.collection("Tiendas");

    for(var i = 0; i < listaproductos.length; i ++) {
      id = listaproductos[i]['tienda'];
      QuerySnapshot tienda = await datos2.where(FieldPath.documentId, isEqualTo: id).get();
      if(tienda.docs.length > 0){
        for(var tien in tienda.docs){
          setState(() {
            datos_negocios.add(tien.data());
            print(tien.data());
          }
          );
        }
      }else{print('No encontrado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: menu(),
      appBar: AppBar(
          title: Image.network("https://img.freepik.com/vector-gratis/personas-pie-cola-tienda_23-2148594615.jpg?size=626&ext=jpg", height: 90, width: 60),
      ),
      body: ListView.builder(itemCount: listaproductos.length,
          itemBuilder: (BuildContext context, j) {
            return ListTile(
                onTap: () {
    print(listaproductos[j]);
    datosTienda t = datosTienda(
    datos_negocios[j]['Categoria'],
    datos_negocios[j]['Celular'],
    datos_negocios[j]['Direccion'],
    datos_negocios[j]['Foto'],
    datos_negocios[j]['Geolocalizacion'],
    datos_negocios[j]['Nombre'],
    datos_negocios[j]['PaginaWeb'],
    datos_negocios[j]['Telefono']);
            Navigator.push((context), MaterialPageRoute(
            builder: (context) => pantalla_5(tienda: t)));
    },
                  title:myCardImage(url: datos_negocios[j]['Foto'],
                      texto: datos_negocios[j]['Direccion'] + '\n' +
                          datos_negocios[j]['Telefono'])
    );
                }),
    );
  }
}

class myCardImage extends StatelessWidget {
  final String url;
  final String texto;

  const myCardImage({
    required this.url,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.blueAccent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Column(
              children: [
                Image.network(url),
                Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black,
                    child: Text(texto,
                        style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
                        textAlign: TextAlign.center)
                ),
              ]
          ),
        )
    );
  }
}

class datosTienda{
  String Categoria="";
  String Celular="";
  String Direccion="";
  String Foto="";
  late GeoPoint Geolocalizacion ;
  String Nombre="";
  String PaginaWeb="";
  String Telefono="";

  datosTienda(Categoria, Celular, Direccion, Foto, Geolocalizacion, Nombre, PaginaWeb, Telefono){
    this.Categoria=Categoria;
    this.Celular=Celular;
    this.Direccion=Direccion;
    this.Foto=Foto;
    this.Geolocalizacion=Geolocalizacion;
    this.Nombre=Nombre;
    this.PaginaWeb=PaginaWeb;
    this.Telefono=Telefono;
  }

}
