import 'package:store_task/Features/products/data/data_sources/products_local_data_source/products_local_data_source.dart';
import 'package:store_task/Features/products/data/data_sources/products_remote_data_source/products_remote_data_source.dart';
import 'package:store_task/Features/products/data/model/product.dart';
import 'package:store_task/Features/products/domain/repository/products_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      // Try to fetch from remote
      final remoteProducts = await remoteDataSource.fetchProducts();
      // Cache the products locally
      await localDataSource.insertProducts(remoteProducts);
      return remoteProducts;
    } catch (e) {
      // If remote fails, return local data
      final localProducts = await localDataSource.getProducts();
      if (localProducts.isNotEmpty) {
        return localProducts;
      }
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    try {
      // Try to fetch from remote
      final remoteProduct = await remoteDataSource.fetchProductDetails(id);
      // Cache the product locally
      await localDataSource.insertProducts([remoteProduct]);
      return remoteProduct;
    } catch (e) {
      // If remote fails, return local data
      final localProduct = await localDataSource.getProductById(id);
      if (localProduct != null) {
        return localProduct;
      }
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    return await localDataSource.searchProducts(query);
  }
}
