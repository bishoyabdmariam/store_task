import 'package:store_task/Features/products/data/model/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductDetailLoading extends ProductState {}

class ProductDetailLoaded extends ProductState {
  final ProductModel product;
  ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductState {
  final String message;
  ProductDetailError(this.message);
}

class ProductSearchLoaded extends ProductState {
  final List<ProductModel> products;
  ProductSearchLoaded(this.products);
}
