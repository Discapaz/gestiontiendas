import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestiontiendas/pantallas/pantalla_3.dart';
import 'listarPersonas.dart';
import 'main.dart';




class pantalla_2 extends StatefulWidget {
  const pantalla_2 ({Key? key}) : super(key: key);

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
    CollectionReference datos  = FirebaseFirestore.instance.collection("Tiendas"); //Conexión a la colección
    QuerySnapshot tiendas = await datos.get(); //Traer todas las tiendas
    if(tiendas.docs.length > 0) { //Trae datos
      print("Trae datos");
      for(var doc in tiendas.docs) {
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
      body: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(12.0),
          child: Text(
            "Conoce nuestras tiendas",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
        ),
          Container(
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(90.0),
              child: Container(
                width:200.0 ,
                height: 150.0,
                color: Colors.yellow,
              ),
              ),
          ListView.builder(
          itemCount: datos_tiendas.length,
          itemBuilder: (BuildContext context,i) {
          return ListTile(
            title: Text("Negocio:  " + i.toString()+" - "+datos_tiendas[i]['Categoria'].toString()),
          );
          },
    ),
  ],
    ),
    ),
          Container(
          child: ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> pantalla_3()));
          },child: Text('Siguiente'),),

),
],
),
);
}
}

