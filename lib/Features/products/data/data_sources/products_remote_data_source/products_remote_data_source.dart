import 'dart:convert';

import 'package:store_task/Core/api/dio_consumer.dart';
import 'package:store_task/Core/api/end_points.dart';
import 'package:store_task/Features/products/data/model/product.dart';
import 'package:store_task/injection_container.dart' as di;

class ProductsRemoteDataSource {
  final DioConsumer client = di.sl<DioConsumer>();

  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(EndPoint.getProductsUrl);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> fetchProductDetails(int id) async {
    final response = await client.get("${EndPoint.getProductsUrl}/$id");
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.data));
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
