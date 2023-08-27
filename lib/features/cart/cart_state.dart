import 'package:app/model/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final List<CartItem>? cartItems;

  const CartState({required this.items, this.cartItems});

  @override
  List<Object?> get props => [items, cartItems];
}
