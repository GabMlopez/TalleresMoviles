import '../../domain/entities/products.dart';

class ProductMemoryDatasources{
  /*Esta clase maneja la persistencia de los datos, actúando como una base de datos
  * en memoria.*/

  final List <Product> _products = [];
  /*Esta lista es la fuente de datos, que almacena toda la información que circula en
  * la aplicación, y sobre la cual se realizan diferentes operaciones.*/

  List<Product> getAll()=> _products;
  /*Esta función se encarga de la operación de lectura, ya que retorna una copia
  * de la lista completa.*/

  void add(Product product) => _products.add(product);
  /*Esta función se encarga de la operación de creación, al agregar un nuevo
  producto a la lista.
   */

  void update(Product product) {
    final index = _products.indexWhere(
        (e)=>e.id == product.id
    );
    if(index !=-1) _products[index]= product;
  }
  /*Esta función se encarga de la la operación de actualización. Recibe los
  datos modificados de un producto y lo busca en la lista. Si lo encuentra, reemplaza
  los datos antiguos con los nuevos.
  * */

  void delete(String id){
    _products.removeWhere(
            (e)=>e.id == id
    );
  }
  /*Esta función se encarga de la operación de eliminación. Recibe el id de un
  producto y busca en la lista para eliminarlo.
  * */
}