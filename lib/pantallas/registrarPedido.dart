import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

class registrarPedido extends StatefulWidget {
  const registrarPedido({Key? key}) : super(key: key);

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {
  List datos_productos = [];

  get floatingActionButton => null;

  void initState() {
    super.initState();
    getTiendas();
  }

  void getTiendas() async {
    print("dentro getTiendas");
    CollectionReference datos = FirebaseFirestore.instance
        .collection("Productos"); //Conexión a la colección
    QuerySnapshot productos = await datos.get(); //Traer todas las tiendas
    if (productos.docs.length > 0) {
      //Trae datos
      print("Trae datos en consola");
      for (var doc in productos.docs) {
        print(doc.data());
        setState(() {
          datos_productos.add(doc.data());
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
              itemCount: datos_productos.length,
              itemBuilder: (BuildContext context, j) {
                return ListTile(
                  //padding: EdgeInsets.all(27),
                    onTap: () {
                      print('dentro de onTap pantalla1');
                      print(datos_productos[j]); // Print datos card * en consola
                      datosProductos dp = datosProductos(
                          datos_productos[j]['Descripcion'],
                          datos_productos[j]['Imagen'],
                          datos_productos[j]['Precio'],
                      );

                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>carritoCompra(pedido: pedido, cedula: cedula, id: id)));
                    },
                    title: miCardImage(
                        url: datos_productos[j]['Imagen'],
                        texto: datos_productos[j]['Descripcion'] +
                            "\n ✆ :  " +
                            datos_productos[j]['Precio']
                            )
                );
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

class datosProductos {
  String Descripcion = "";
  String Imagen = "";
  String Precio = "";



  datosProductos(Descripcion, Imagen, Precio) {
    this.Descripcion= Descripcion;
    this.Imagen= Imagen;
    this.Precio= Precio;
  }
}