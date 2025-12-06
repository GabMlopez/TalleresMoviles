import 'package:cleanarcht/presentation/layouts/product_add.dart';

import 'data/datasources/product_memory_datasources.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/layouts/product_detail.dart';
import 'presentation/layouts/product_list.dart';
import 'presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'domain/usescase/add_product.dart';
import 'domain/usescase/delete_product.dart';
import 'domain/usescase/get_products.dart';
import 'domain/usescase/update_product.dart';
void main() {
  final datasource = ProductMemoryDatasources();
  final repository = ProductRepositoryImpl(datasource);

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>
          //provider con funciones Crud
          ProductProvider(
              getProductsUseCase: GetProducts(repository),
              addProductUseCase: AddProduct(repository ),
              updateProductUseCase: UpdateProduct(repository ),
              deleteProductUseCase: DeleteProduct(repository )))
        ]
    ,
    child: const MyApp(),)

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Architecture - productos',
      initialRoute: '/',
      routes: {
        //pagina de inicio
        '/': (context) => const ProductListPage(),
        //pagina de crear porducto
        '/detail': (context) => const ProductAddPage(),
        //pagina de editar producto
        '/edit': (context) => const ProductDetailPage(),
      },

    );

  }
}