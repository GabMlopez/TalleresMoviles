import '../repository/product_repository.dart';
import '../entities/products.dart';

class AddProduct{
  final ProductRepository repository;
  AddProduct(this.repository);
  void call(Product product)=>repository.addProduct(product);
}
