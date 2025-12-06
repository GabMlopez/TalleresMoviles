import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/products.dart';
import '../providers/product_provider.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  //Sobrescribir deoendencias

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de Nuevo Producto"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                labelText: "Nombre producto"
            ),
          ),
          const SizedBox(height:20,),
          TextField(
              controller: priceController,
              decoration: const InputDecoration(
                  labelText: "Precio producto"
              )
          ),
          const SizedBox(height:20,),
          ElevatedButton(onPressed: (){
              if(nameController.text.isEmpty || priceController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Nombre o precio del producto estan vacios"),
                      duration: const Duration(seconds: 2),
                    ),
                );
                return;
              }
              if(num.tryParse(priceController.text) != null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Precio solo puede ser un número"),
                    duration: const Duration(seconds: 2),
                  ),
                );
                return;
              }
              provider.add(
                  Product(DateTime.now().microsecondsSinceEpoch.toString(),
                      nameController.text,
                      double.parse(priceController.text))
              );
            Navigator.pushNamed(context, '/');
          }, child: Text("Registrar"))
        ],
      ),
    );
  }
}
