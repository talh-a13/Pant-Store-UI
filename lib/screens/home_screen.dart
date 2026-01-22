import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/curve.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/data.dart';
import 'package:plant_app/screens/plant_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:plant_app/view_models/shop_view_model.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/components/plant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Let\'s find your plants!',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: kDarkGreenColor,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    style: TextStyle(color: kDarkGreenColor),
                    cursorColor: kDarkGreenColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kGinColor,
                      hintText: 'Search Plant',
                      hintStyle: TextStyle(color: kGreyColor),
                      prefixIcon: Icon(
                        Icons.search,
                        color: kDarkGreenColor,
                        size: 20.0,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.mic),
                        color: kDarkGreenColor,
                        iconSize: 20.0,
                        splashRadius: 20.0,
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGinColor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGinColor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGinColor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  CategorySelector(
                    selected: selected,
                    categories: const [
                      'Recommended',
                      'Top',
                      'Indoor',
                      'Outdoor'
                    ],
                    onTap: (index) {
                      setState(() {
                        selected = index;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 290.0,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 220.0,
                            child: Consumer<ShopViewModel>(
                              builder: (context, shop, child) {
                                final plants = shop.recommendedPlants;
                                return ListView.separated(
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: plants.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 20.0);
                                  },
                                  itemBuilder: (context, index) {
                                    final plant = plants[index];
                                    return PlantCard(
                                      plant: plant,
                                      onFavoriteTap: () {
                                        shop.toggleFavorite(plant);
                                      },
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PlantDetails(
                                                plant: plant,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Text(
                            'Recently Viewed',
                            style: TextStyle(
                              color: kDarkGreenColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                          child: ListView.separated(
                            itemCount: viewed.length,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RecentlyViewedCard(
                                plantName: viewed[index].plantName,
                                plantInfo: viewed[index].plantInfo,
                                image: AssetImage(viewed[index].image),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 20.0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentlyViewedCard extends StatelessWidget {
  const RecentlyViewedCard({
    required this.plantName,
    required this.plantInfo,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String plantName;
  final String plantInfo;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(width: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              plantName,
              style: GoogleFonts.poppins(
                color: kDarkGreenColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              plantInfo,
              style: GoogleFonts.poppins(
                color: kGreyColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.selected,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  final int selected;
  final List<String> categories;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < categories.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.symmetric(
                vertical: selected == i ? 8.0 : 0.0,
                horizontal: selected == i ? 12.0 : 0.0,
              ),
              decoration: BoxDecoration(
                color: selected == i ? kGinColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: GestureDetector(
                onTap: () {
                  onTap(i);
                },
                child: Align(
                  child: Text(
                    categories[i],
                    style: TextStyle(
                      color: selected == i ? kDarkGreenColor : kGreyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
