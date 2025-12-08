import '../../domain/entities/products.dart';
import '../../data/datasources/product_memory_datasources.dart';
import '../../domain/repository/product_repository.dart';
class ProductRepositoryImpl implements ProductRepository{
  /*Esta clase conecta la capa de datos con la capa de dominio, ya que implementa
  * las abstracciones de la capa de dominio para que interactúen con la fuente
  * de datos.*/

  final ProductMemoryDatasources datasource;
  ProductRepositoryImpl(this.datasource);
  /*El repositorio establece una conexión a la fuente de datos, para acceder
  * a sus operaciones CRUD.*/

  @override
  List<Product> getProducts() => datasource.getAll();
  /*Esta función  conecta la operación de lectura en la fuente de
  * datos con la abstracción para obtener todos los productos desde el dominio.*/

  @override
  void addProduct(Product product) => datasource.add(product);
  /*Esta función conecta la operación de escritura en la fuente de
  * datos con la abstracción para agregar un nuevo producto desde el dominio.*/

  @override
  void updateProduct(Product product) => datasource.update(product);
  /*Esta función conecta la operación de actualización en la fuente de
  * datos con la abstracción para modificar la información
  *  de un producto desde el dominio.*/

  @override
  void deleteProduct(String id) => datasource.delete(id);
/*Esta función conecta la operación de eliminación en la fuente de
  * datos con la abstracción para quitar un producto de la lista
  *  desde el dominio.*/
}