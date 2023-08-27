import 'package:app/features/cart/cart_cubit.dart';
import 'package:app/features/cart/cart_screen.dart';
import 'package:app/features/home/home_cubit.dart';
import 'package:app/features/home/home_screen.dart';
import 'package:app/features/saved/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..fetchProduct(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'SIAMPIWAT',
        routes: {
          '/cart': (context) => const CartScreen(),
          '/saved': (context) => const SavedScreen()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
