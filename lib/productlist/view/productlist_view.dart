import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop/productlist/bloc/productlist_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop/productlist/bloc/productlist_bloc.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Trigger fetching the next page when the bottom is reached
        context.read<ProductlistBloc>().fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductlistBloc, ProductlistState>(
      listener: (context, state) {
        if (state is ProductlistLoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProductlistLoading && state is! ProductlistLoadSuccess) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductlistLoadSuccess ||
            state is ProductlistLoadMoreLoading) {
          final products = state is ProductlistLoadSuccess
              ? state.products
              : (state as ProductlistLoadMoreLoading).products;

          return GridView.builder(
            controller: _scrollController,
            itemCount: products.length + 1, // Add 1 for the loading indicator
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4 / 6.5,
            ),
            itemBuilder: (context, index) {
              if (index == products.length) {
                // Display a loading indicator at the bottom if more data is being fetched
                return state is ProductlistLoadMoreLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }

              final product = products[index];
              return Material(
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle product tap, e.g., navigate to product details
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              product.images.isNotEmpty
                                  ? product.images.first
                                  : '',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '\$${product.price}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ProductlistLoadFailure) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        }
        return const Text('No Products Available');
      },
    );
  }
}
