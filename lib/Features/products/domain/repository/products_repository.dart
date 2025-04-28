import 'package:store_task/Features/products/data/model/product.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductDetails(int id);
  Future<List<ProductModel>> searchProducts(String query);
}
