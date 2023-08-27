import 'package:app/common/utils/snack_helper.dart';
import 'package:app/features/cart/cart_cubit.dart';
import 'package:app/features/home/home_cubit.dart';
import 'package:app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final cartCubit = context.watch<CartCubit>();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(widget.product.imageUrl),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
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
                                widget.product.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                homeCubit.toggleFavorite(widget.product.id);
                              }),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          cartCubit.addToCart(widget.product);
                          showSnackBar(
                            context,
                            text: 'Add to ${widget.product.name} to Cart',
                            type: SnackBarType.success,
                          );
                        },
                        child: Text('ADD CART'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
