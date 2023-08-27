import 'package:app/common/utils/snack_helper.dart';
import 'package:app/features/home/home_cubit.dart';
import 'package:app/features/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.watch<HomeCubit>();

    // final productCubit = context.watch<ProductCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('For You'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.product!.length,
            itemBuilder: (context, index) {
              final product = state.product![index];
              return Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                                product: product,
                              )),
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              state.product![index].imageUrl,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 120,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.all(6),
                              child: CircleAvatar(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    icon: Icon(
                                      state.product![index].isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      final isFavorite =
                                          homeCubit.state.isFavorite;
                                      homeCubit.toggleFavorite(product.id);
                                      if (isFavorite != null) {
                                        showSnackBar(context,
                                            text: !state
                                                    .product![index].isFavorite
                                                ? 'Saved'
                                                : 'UnSaved');
                                      }
                                      // productCubit.toggleFavorite(product.id);
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(state.product![index].name),
                      ),
                      Text('\$${state.product![index].price.toString()}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
