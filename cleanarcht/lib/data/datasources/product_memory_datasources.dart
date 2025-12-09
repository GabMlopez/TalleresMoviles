import '../../domain/entities/products.dart';

class ProductMemoryDatasources{

  final List <Product> _products = [];
  //Cargar la lista de datos
  List<Product> getAll()=> _products;
  //Agregar el objeto
  void add(Product product) => _products.add(product);
  //Actualizar producto
  void update(Product product) {
    final index = _products.indexWhere(
        (e)=>e.id == product.id
    );
    if(index !=-1) _products[index]= product;
  }
  //Eliminar producto
  void delete(String id){
    _products.removeWhere(
            (e)=>e.id == id
    );
  }
}