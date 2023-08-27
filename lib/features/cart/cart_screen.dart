import 'package:app/features/cart/cart_cubit.dart';
import 'package:app/features/cart/cart_state.dart';
import 'package:app/features/checkout/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            final cartItems = cartState.items;
            double totalPrice = 0;
            for (var cartItem in cartItems) {
              totalPrice += cartItem.product.price * cartItem.quantity;
            }
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return Dismissible(
                            key: Key(cartItem.product.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 16.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              context
                                  .read<CartCubit>()
                                  .removeFromCart(cartItem.product);
                            },
                            child: ListTile(
                              leading: Image.network(cartItem.product.imageUrl),
                              title: Text(cartItem.product.name),
                              subtitle: Text(
                                  '\$${cartItem.product.price.toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      context
                                          .read<CartCubit>()
                                          .adjustQuantity(cartItem.product, -1);
                                    },
                                  ),
                                  Text('${cartItem.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      context
                                          .read<CartCubit>()
                                          .adjustQuantity(cartItem.product, 1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.orange[300],
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price:',
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckOutPage(totalPrice: totalPrice),
                                ),
                              );
                            },
                            child: const Text('Check Out'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
