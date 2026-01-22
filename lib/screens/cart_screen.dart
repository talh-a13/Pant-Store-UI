import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:plant_app/view_models/shop_view_model.dart';
import 'package:plant_app/models/cart_item.dart';
import 'package:plant_app/components/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static String id = "CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double shippingCost = 50.0;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leadingWidth: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 20.0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              splashRadius: 1.0,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: kDarkGreenColor,
                size: 24.0,
              ),
            ),
          ),
          Text(
            'My Cart',
            style: GoogleFonts.poppins(
              color: kDarkGreenColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 40.0,
            child: IconButton(
              onPressed: () {},
              splashRadius: 1.0,
              icon: Icon(
                Icons.more_vert,
                color: kDarkGreenColor,
                size: 34.0,
              ),
            ),
          ),
        ],
      ),
    );

    double appbarHeight = appBar.preferredSize.height;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double mainHeight =
        MediaQuery.of(context).size.height - appbarHeight - bottomPadding;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
        child: Consumer<ShopViewModel>(
          builder: (context, shop, child) {
            return Column(
              children: [
                Flexible(
                  flex: 7,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      height: mainHeight * 7 / 11 - 30,
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: shop.cart.isEmpty
                          ? Center(
                              child: Text(
                                'Your cart is empty',
                                style: GoogleFonts.poppins(
                                  color: kGreyColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: shop.cart.length,
                              itemBuilder: (context, index) {
                                final item = shop.cart[index];
                                return CartItemCard(
                                  item: item,
                                  onQuantityChanged: (value) {
                                    shop.updateQuantity(item.plant, value);
                                  },
                                  onDelete: () {
                                    shop.removeFromCart(item.plant);
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(-1, -6),
                          color: Colors.black12,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal:',
                                    style: kBillTextStyle,
                                  ),
                                  Text(
                                    'Rs ${shop.totalCartPrice.toStringAsFixed(2)}',
                                    style: kBillTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Cost:',
                                    style: kBillTextStyle,
                                  ),
                                  Text(
                                    'Rs ${shippingCost.toStringAsFixed(2)}',
                                    style: kBillTextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6.0),
                            ],
                          ),
                        ),
                        Container(height: 0.5, color: Colors.grey.shade500),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: GoogleFonts.poppins(
                                  color: kDarkGreenColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Rs ${(shop.totalCartPrice + shippingCost).toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  color: kDarkGreenColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kDarkGreenColor,
                            elevation: 20.0,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                          ),
                          child: const Text('Place Your Order'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
