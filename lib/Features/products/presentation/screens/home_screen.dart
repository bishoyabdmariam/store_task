import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/Features/products/data/model/product.dart';
import 'package:store_task/Features/products/presentation/cubit/product_cubit';
import '../cubit/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/search_field.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          SearchField(
            onChanged: (query) {
              context.read<ProductCubit>().searchProducts(query);
            },
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductLoaded ||
                    state is ProductSearchLoaded) {
                  List<ProductModel> products = [];
                  if (state is ProductLoaded) {
                    products = state.products;
                  } else if (state is ProductSearchLoaded) {
                    products = state.products;
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('No products available'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
