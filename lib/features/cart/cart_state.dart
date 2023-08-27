import 'package:app/model/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}
