import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/cart_item.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    required this.item,
    required this.onQuantityChanged,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  final CartItem item;
  final Function(int) onQuantityChanged;
  final Function() onDelete;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: kGinColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            height: 80.0,
            width: 80.0,
            margin: const EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(
                  widget.item.plant.image,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.item.plant.plantName,
                      style: GoogleFonts.poppins(
                        color: kDarkGreenColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    widget.item.plant.plantType,
                    style: GoogleFonts.poppins(
                      color: kGreyColor,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        quantityButton(
                          icon: Icons.remove,
                          onPressed: () {
                            if (widget.item.quantity > 1) {
                              widget.onQuantityChanged(widget.item.quantity - 1);
                            }
                          },
                        ),
                        SizedBox(
                          width: 31.0,
                          child: Text(
                            widget.item.quantity.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: kDarkGreenColor,
                            ),
                          ),
                        ),
                        quantityButton(
                          icon: Icons.add,
                          onPressed: () {
                            if (widget.item.quantity < 20) {
                              widget.onQuantityChanged(widget.item.quantity + 1);
                            }
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Rs ${(widget.item.plant.plantPrice * widget.item.quantity).toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityButton(
      {required IconData icon, required Function() onPressed}) {
    return Container(
      height: 22.0,
      width: 24.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: kDarkGreenColor,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          icon,
          size: 14.0,
        ),
      ),
    );
  }
}
