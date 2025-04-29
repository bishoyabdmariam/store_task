import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/Features/products/domain/repository/products_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit({required this.repository}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }

  Future<void> fetchProductDetails(int id) async {
    emit(ProductDetailLoading());
    try {
      final product = await repository.getProductDetails(id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError('Failed to load product details: $e'));
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      if (state is ProductLoaded) {
        emit(ProductLoaded((state as ProductLoaded).products));
      }
      return;
    }
    try {
      final products = await repository.searchProducts(query);
      emit(ProductSearchLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to search products: $e'));
    }
  }
}
