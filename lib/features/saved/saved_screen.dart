import 'package:app/common/utils/snack_helper.dart';
import 'package:app/features/home/home_cubit.dart';
import 'package:app/features/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.watch<HomeCubit>();
    final favoriteProducts = homeCubit.state.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: favoriteProducts?.length ?? 0,
        itemBuilder: (context, index) {
          final product = favoriteProducts![index];
          return Card(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      product: product,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        child: Image.network(
                          product.imageUrl,
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
                                product.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                homeCubit.toggleFavorite(product.id);
                                showSnackBar(context, text: 'UnSaved');
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text(product.name),
                  ),
                  Text('\$${product.price.toString()}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
