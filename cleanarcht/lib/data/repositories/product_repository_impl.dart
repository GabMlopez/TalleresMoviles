import '../../domain/entities/products.dart';
import '../../data/datasources/product_memory_datasources.dart';
import '../../domain/repository/product_repository.dart';
class ProductRepositoryImpl implements ProductRepository{
  final ProductMemoryDatasources datasource;
  ProductRepositoryImpl(this.datasource);

  @override
  List<Product> getProducts() => datasource.getAll();

  @override
  void addProduct(Product product) => datasource.add(product);

  @override
  void updateProduct(Product product) => datasource.update(product);

  @override
  void deleteProduct(String id) => datasource.delete(id);
}