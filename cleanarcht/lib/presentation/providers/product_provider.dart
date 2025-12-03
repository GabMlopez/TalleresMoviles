import 'package:flutter/cupertino.dart';


import '../../domain/entities/products.dart';
import '../../domain/usescase/add_product.dart';
import '../../domain/usescase/delete_product.dart';
import '../../domain/usescase/get_products.dart';
import '../../domain/usescase/update_product.dart';

class ProductProvider extends ChangeNotifier{
  final GetProducts getProductsUseCase;
  final AddProduct addProductUseCase;
  final UpdateProduct updateProductUseCase;
  final DeleteProduct deleteProductUseCase;

  ProductProvider({
    required this.getProductsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  });

  List get products => getProductsUseCase();

  void add(Product product){
    addProductUseCase(product);
    notifyListeners();
  }

  void update(Product product){
    updateProductUseCase(product);
    notifyListeners();
  }

  void delete(String id){
    deleteProductUseCase(id);
    notifyListeners();
  }

}
