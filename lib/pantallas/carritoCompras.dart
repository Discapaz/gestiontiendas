import 'package:cloud_firestore/cloud_firestore.dart';
import 'listadoNegocios.dart';
import 'main.dart';
import 'registrarPedidos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class carritoCompras extends StatefulWidget {
  final List<datosPedido> pedido;
  final String id;
  final String cedula;

  const carritoCompras(
      {required this.pedido, required this.cedula, required this.id });

  @override
  _carritoComprasState createState() => _carritoComprasState();
}

class _carritoComprasState extends State<carritoCompras> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      drawer: menu(),
      body: Center(
        child: ListView.builder(
          itemCount: widget.pedido.length,
          itemBuilder: (BuildContext context, i) {
            return ListTile(
              title: Text(widget.pedido[i].nombre
                  + '\nPrecio: \$ ' + widget.pedido[i].precio.toString()
                  + '    Cant: ' + widget.pedido[i].cant.toString()
                  + '    Total:   \$ ' + widget.pedido[i].total.toString(),
                style: TextStyle(fontSize: 20),),
              trailing: Icon(Icons.delete, size: 30, color: Colors.red,),
              onTap: () {
                widget.pedido.removeAt(i);
                setState(() {
                  Fluttertoast.showToast(msg: "Pedido eliminado del carrito de compras.",
                      fontSize: 20,
                      backgroundColor: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                });
              },
            );

          },
        ),
      ),

      bottomNavigationBar: carritoBar(listaPedido: widget.pedido, negocio: widget.id, cliente: widget.cedula),
    );
  }
}

class carritoBar extends StatefulWidget {

  final List<datosPedido> listaPedido;
  final String negocio;
  final String cliente;

  const carritoBar({required this.listaPedido,
    required this.negocio,
    required this.cliente});

  @override
  _carritoBarState createState() => _carritoBarState();
}
class _carritoBarState extends State<carritoBar> {

  void registrarDetalle(codP){

    CollectionReference detalle = FirebaseFirestore.instance.collection("DetallePedido");
    for(var dato=0; dato< widget.listaPedido.length; dato++){
      detalle.add({
        "pedido": codP,
        "producto": widget.listaPedido[dato].codigo,
        "cantidad": widget.listaPedido[dato].cant,
        "total": widget.listaPedido[dato].total
      });
    }
  }
  void registrarP(){

    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    int totalP=0;
    String codPedido;
    for(int i=0; i< widget.listaPedido.length; i++){
      totalP+=widget.listaPedido[i].total;
    }
    CollectionReference pedidos = FirebaseFirestore.instance.collection("Pedidos");
    pedidos.add({
      "negocio": widget.negocio,
      "cliente": widget.cliente,
      "fecha": fecha,
      "total": totalP
    }).then((value) => registrarDetalle(value.id));

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white60,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.blue,
      items: [
        BottomNavigationBarItem(        // BOTON REGRESA
            icon: Icon(Icons.add_shopping_cart_sharp, size: 30),
            label: 'Agregar\nProducto'
        ),
        BottomNavigationBarItem(      // BOTON TOTAL
            icon: Icon(Icons.app_registration, size: 30),
            label: 'TOTAL'
        ),
        BottomNavigationBarItem(      // BOTON CONFIRMAR
            icon: Icon(Icons.add_business_sharp, size: 30),
            label: 'Confirmar\nCompra'
        )
      ],
      onTap: (indice){
        if(indice==0){
          Navigator.pop(context);
        }else if(indice==1){
          int totalPedido=0;
          for(int i=0; i< widget.listaPedido.length; i++){
            totalPedido+=widget.listaPedido[i].total;
          }
          print("Total es: "+totalPedido.toString());
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                title: Text("Total Compra:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
                contentPadding: EdgeInsets.all(20.0),
                content: Text('\$ '+totalPedido.toString(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
              ));
        }else{
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                title: Text("Confirmar Compra:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
                contentPadding: EdgeInsets.all(23.0),
                content: Text("Confirma el registro de la Compra.", style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),),
                actions: [
                  ElevatedButton(
                      onPressed: (){
                        registrarP();
                        Fluttertoast.showToast(msg: "Pedido Registrado exitosamente.",
                            fontSize: 20,
                            backgroundColor: Colors.lightBlueAccent,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>listaNegocios(cedula: widget.cliente)));
                      },
                      child: Text("Confirmar")
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancelar")
                  )
                ],
              ));

        }
      },
    );
  }
}

