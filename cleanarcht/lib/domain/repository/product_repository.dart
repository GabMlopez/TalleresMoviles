import '../entities/products.dart';

abstract class ProductRepository {
  List<Product> getProducts();

  void addProduct(Product product);

  void updateProduct(Product product);

  void deleteProduct(String id);
}
  //Contrato de Repositorio
  //Implementa capa de Datos