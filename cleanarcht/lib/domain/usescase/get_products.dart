import '../repository/product_repository.dart';

class GetProducts{
  final ProductRepository repository;

  GetProducts (this.repository);
  List call()=>repository.getProducts();


}