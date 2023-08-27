import 'dart:convert';

import 'package:app/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class HomeState {
  final bool isLoading;
  final List<Product>? product;
  final List<Product>? favoriteProducts;
  final bool? isFavorite;

  HomeState(
      {this.isLoading = false,
      this.product,
      this.favoriteProducts,
      this.isFavorite});

  HomeState copyWith(
      {bool? isLoading = false,
      bool? isFavorite = false,
      List<Product>? product,
      List<Product>? favoriteProducts}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        product: product ?? this.product,
        favoriteProducts: favoriteProducts ?? this.favoriteProducts,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(product: []));

  Future<void> fetchProduct() async {
    emit(state.copyWith(isLoading: true));
    try {
      final String jsonText = await rootBundle.loadString('assets/data.json');
      final jsonData = json.decode(jsonText)['product_items'] as List<dynamic>;
      emit(
        state.copyWith(
          product: jsonData.map((data) => Product.fromJson(data)).toList(),
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void toggleFavorite(int productId) {
    final updatedProducts = state.product?.map((product) {
      if (product.id == productId) {
        return product.copyWith(isFavorite: !product.isFavorite);
      }
      return product;
    }).toList();

    final updatedFavoriteProducts =
        updatedProducts?.where((product) => product.isFavorite).toList();

    final isProductFavorite = updatedProducts
        ?.firstWhereOrNull(
          (product) => product.id == productId,
        )
        ?.isFavorite;
    emit(state.copyWith(
        product: updatedProducts,
        favoriteProducts: updatedFavoriteProducts,
        isFavorite: isProductFavorite));
  }
}
