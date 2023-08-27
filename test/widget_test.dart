import 'package:app/model/cart_model.dart';
import 'package:app/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/cart/cart_cubit.dart';
import 'package:app/features/cart/cart_state.dart';

void main() {
  group('CartCubit', () {
    late CartCubit cartCubit;

    setUp(() {
      cartCubit = CartCubit();
    });

    tearDown(() {
      cartCubit.close();
    });

    test('adding the cart updates the state', () async {
      final cubit = CartCubit();
      final setItems = List<CartItem>.from(cubit.state.items);
      cubit.emit(CartState(items: setItems));
      expect(cartCubit.state, CartState(items: setItems));
    });
    test('adding the cart updates the state is Emtry', () async {
      final cubit = CartCubit();
      final setItems = [];
      cubit.emit(const CartState(items: []));
      expect(cartCubit.state.items, setItems);
    });
  });
}
