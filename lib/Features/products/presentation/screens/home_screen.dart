import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/Core/extensions/extensions.dart';
import 'package:store_task/Features/products/data/model/product.dart';
import 'package:store_task/Features/products/presentation/cubit/product_cubit';
import '../../../settings/presentation/cubit/locale/locale_cubit.dart';
import '../../../settings/presentation/widgets/switch_language.dart';
import '../cubit/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/search_field.dart';
import 'product_detail_screen.dart';

import 'package:store_task/injection_container.dart' as di;

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
        title: Text(
          'Products'.translate(context),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          SwitchLanguage(),
        ],
      ),
      body: Container(
        color: const Color(0xFFF9F9F9),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SearchField(
                onChanged: context.read<ProductCubit>().searchProducts,
              ),
            ),
            const SizedBox(height: 8),
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
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
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
                  return Center(
                    child: Text(
                      'No products found'.translate(context),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
