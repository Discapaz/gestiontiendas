import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'carritoCompras.dart';
import 'listadoNegocios.dart';
import 'main.dart';


class registrarPedido extends StatefulWidget {
  final String id,cedula;  // id es id de negocio / cedula es el id del cliente
  const registrarPedido({required this.id,required this.cedula});

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {
  List listaProductos=[];    // ListaCursos del ejemplo
  List codigosPro=[];
  List<datosPedido> pedido=[];

  void initState(){
    super.initState();
    getProductos();
  }
  void getProductos()async {
    CollectionReference productos = FirebaseFirestore.instance.collection('Productos');
    String cod='';
    QuerySnapshot producto = await productos.where('tienda', isEqualTo: widget.id).get();
    if(producto.docs.length>0){
      for(var doc in producto.docs){
        cod=doc.id.toString();
        codigosPro.add(cod);
        listaProductos.add(doc.data());
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Pedido'),
        actions: [
          IconButton(
              onPressed: (){
                for(var i=0 ; i < pedido.length; i++){
                  print(pedido[i].precio);
                  print(pedido[i].cant);
                  print(pedido[i].total);
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>carritoCompras(pedido: pedido,
                        cedula: widget.cedula,
                        id: widget.id)));
              },
              icon: const Icon(Icons.add_shopping_cart,
                size: 45,
                color: Colors.white,
              )
          )
        ],
      ),
      drawer: menu(),
      //body: Text('Id persona'+widget.id+'--'+'Cedula'+widget.cedula),
      body: ListView.builder(
          itemCount: listaProductos.length,
          itemBuilder: (BuildContext context, i){
            var can = TextEditingController();
            return ListTile(
              leading: Icon(Icons.add_circle_outline,
                size: 45,
                color: Colors.green,
              ),
              title: Container(
                padding: EdgeInsets.all(27.0),

                color: Colors.lightGreen,
                child: Text(listaProductos[i]['descripcion']
                    //+' '+ listaProductos[i]['descripcion']
                    +'\n'+'\$ '+ listaProductos[i]['precio'].toString(),
                  style: TextStyle(fontSize: 20),),

              ),
              subtitle: TextField(
                controller: can,
                decoration: InputDecoration(
                    hintText: 'Cantidad'
                ),
              ),
              onTap: (){
                if(can.text.isEmpty){
                  can.text='0';
                }
                int total =int.parse(can.text)*(int.parse(listaProductos[i]['precio'].toString()));
                datosPedido p = datosPedido(codigosPro[i], listaProductos[i]['descripcion'],
                    listaProductos[i]['precio'],
                    int.parse(can.text),total);
                pedido.add(p);
                Fluttertoast.showToast(msg: "Pedido agregado a carrito de compras.",
                    fontSize: 20,
                    backgroundColor: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER);
              },
            );
          }
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);

        }, label: Text("Atras"),
        icon: Icon(Icons.arrow_left),
      ),

    );
  }
}

class datosPedido {
  String codigo='';
  String nombre='';

  int precio=0;
  int cant=0;
  int total=0;

  datosPedido(this.codigo, this.nombre,  this.precio,
      this.cant, this.total);
}