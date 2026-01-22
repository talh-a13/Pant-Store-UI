import 'package:flutter/material.dart';
import 'package:plant_app/components/bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/cart_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:plant_app/view_models/shop_view_model.dart';
import 'package:plant_app/screens/favorites_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String id = 'MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const HomeScreen(), // Placeholder for Orders
    const HomeScreen(), // Placeholder for Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: kDarkGreenColor,
                radius: 22.0,
                backgroundImage: const AssetImage('images/Talha.jpeg'),
              ),
              onTap: () {},
            ),
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: kDarkGreenColor,
                  radius: 22.0,
                  child: IconButton(
                    color: Colors.white,
                    splashRadius: 28.0,
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Consumer<ShopViewModel>(
                    builder: (context, shop, child) {
                      if (shop.cartCount == 0) return const SizedBox.shrink();
                      return Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${shop.cartCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        selectedColor: kDarkGreenColor,
        unselectedColor: kSpiritedGreen,
        onTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.bookmark_outline), // Search/Favorites icon
          Icon(Icons.receipt),
          Icon(Icons.person),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
