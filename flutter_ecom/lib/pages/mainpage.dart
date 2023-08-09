import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/cart/cart.dart';
import 'package:flutter_ecom/pages/home/home.dart';
import 'package:flutter_ecom/pages/orders/orders.dart';
import 'package:flutter_ecom/pages/user_profile/user.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages.add(const HomePage());
    _pages.add(const OrdersPage());
    _pages.add(const CartPage());
    _pages.add(const UserProfilePage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LP3-ECOM", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            ),
          ),
        backgroundColor: Colors.blue,
      ),
      body: IndexedStack( 
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: onTapped,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            ),
          BottomNavigationBarItem(
            label: "Pedidos",
            icon: Icon(Icons.list),
            ),
          BottomNavigationBarItem(
            label: "Carrinho",
            icon: Icon(Icons.shopping_cart),
            ),
          BottomNavigationBarItem(
            label: "Usuário",
            icon: Icon(Icons.person),
            )
        ],
        unselectedItemColor: const Color(0xFF000000),
        selectedItemColor: const Color(0xFFFF0000),
        backgroundColor: const Color(0x00FF0000),
        ),
    );
  }
  void onTapped(int index){
    setState(() {
     _index = index; 
    });
  }
}