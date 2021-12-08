import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestiontiendas/pantallas/pantalla_3.dart';
import 'main.dart';

class pantalla_2 extends StatefulWidget {
  final String cedula;
  const pantalla_2({required this.cedula});

  @override
  _pantalla_2State createState() => _pantalla_2State();
}

class _pantalla_2State extends State<pantalla_2> {
  List datos_tiendas = [];

  get floatingActionButton => null;

  void initState() {
    super.initState();
    getTiendas();
  }

  void getTiendas() async {
    print("dentro getTiendas");
    CollectionReference datos = FirebaseFirestore.instance
        .collection("Tiendas"); //Conexión a la colección
    QuerySnapshot tiendas = await datos.get(); //Traer todas las tiendas
    if (tiendas.docs.length > 0) {
      //Trae datos
      print("Trae datos en consola");
      for (var doc in tiendas.docs) {
        print(doc.data());
        setState(() {
          datos_tiendas.add(doc.data());
        });
      }
    } else {
      print("Ha fallado...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: menu(),
        appBar: AppBar(
          title: Image.network("https://img.freepik.com/vector-gratis/personas-pie-cola-tienda_23-2148594615.jpg?size=626&ext=jpg", height: 90, width: 60),
            ),
        body: Center(

          child: ListView.builder(
              itemCount: datos_tiendas.length,
              itemBuilder: (BuildContext context, j) {
                return ListTile(
                  //padding: EdgeInsets.all(27),
                    onTap: () {
                      print('dentro de onTap pantalla1');
                      print(widget.cedula);
                      print(datos_tiendas[j]); // Print datos card * en consola
                      datosNegocio d = datosNegocio(
                          datos_tiendas[j]['Nombre'],
                          datos_tiendas[j]['Telefono'],
                          datos_tiendas[j]['Direccion'],
                          datos_tiendas[j]['Logo'],
                          datos_tiendas[j]['PaginaWeb'],
                          datos_tiendas[j]['Foto']);

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla_3()));
                    },
                    title: miCardImage(
                        url: datos_tiendas[j]['Foto'],
                        texto: datos_tiendas[j]['Nombre'] +
                            "\n ✆ :  " +
                            datos_tiendas[j]['Telefono'].toString() +
                            '\n ➤ :  ' +
                            datos_tiendas[j]['Direccion']));
              }),
          /*
    floatingActionButton: FloatingActionButton.extended(
    onPressed: () {
    Navigator.pop(context);

    }, label: Text("Atras"),
    icon: Icon(Icons.arrow_left),
    ), */
        ));
  }
}

class miCardImage extends StatelessWidget {
  final String url;
  final String texto;

  const miCardImage({required this.url, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.all(20),
      elevation: 10,
      color: Colors.black,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            Image.network(url),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text(
                texto,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class datosNegocio {
  String Nombre = "";
  String Telefono = "";
  String Direccion = "";
  String Logo = "";
  String PaginaWeb = "";
  String Foto = "";

  datosNegocio(Nombre, Telefono, Direccion, Logo, PaginaWeb, Foto) {
    this.Nombre = Nombre;
    this.Telefono = Telefono;
    this.Direccion = Direccion;
    this.Logo = Logo;
    this.PaginaWeb = PaginaWeb;
    this.Foto = Foto;
  }
}