import 'package:app/features/cart/cart_screen.dart';
import 'package:app/features/product/product_list_screen.dart';
import 'package:app/features/home/home_cubit.dart';
import 'package:app/features/saved/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProductListView(),
    const SavedScreen(),
    const CartScreen()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff23272C),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(24.0),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Saved',
                  icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  label: 'Cart',
                  icon: Icon(Icons.shopping_cart),
                ),
              ],
              unselectedItemColor: Colors.grey,
              selectedItemColor: Color(0xffFEDA7A),
              // showUnselectedLabels: true,
            ),
          ),
        ),
      ),
    );
  }
}
