import '../entities/products.dart';
import '../repository/product_repository.dart';

class UpdateProduct{
  final ProductRepository repository;

  UpdateProduct(this.repository);

  void call(Product product) => repository.updateProduct(product);
}