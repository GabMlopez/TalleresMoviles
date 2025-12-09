import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/products.dart';
import '../providers/product_provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  late String? productId;
  //Sobrescribir deoendencias
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Product;
    if(args != null){
      productId = args.id;
      nameController.text=args.name;
      priceController.text=args.price.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de Producto"),
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
            //validacion de valores
            if(nameController.text.isEmpty || priceController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Nombre o precio del producto estan vacios"),
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }
            if(num.tryParse(priceController.text) == null){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Precio solo puede ser un número"),
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }
            //validación existencia del producto en la lista de Productos
            if(productId !=null){
              provider.update(
                Product(productId.toString(),
                    nameController.text,
                    double.parse(priceController.text))
              );
              Navigator.pushNamed(context, '/');
            }
          }, child: Text("Editar"))
        ],
      ),
    );
  }
}
