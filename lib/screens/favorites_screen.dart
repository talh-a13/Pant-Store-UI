import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/components/plant_card.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:plant_app/view_models/shop_view_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Favorites',
                style: GoogleFonts.poppins(
                  color: kDarkGreenColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Consumer<ShopViewModel>(
                  builder: (context, shop, child) {
                    final favorites = shop.favoritePlants;
                    if (favorites.isEmpty) {
                      return Center(
                        child: Text(
                          'No favorites yet',
                          style: GoogleFonts.poppins(
                            color: kGreyColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final plant = favorites[index];
                        return PlantCard(
                          plant: plant,
                          onFavoriteTap: () => shop.toggleFavorite(plant),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlantDetails(plant: plant),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
