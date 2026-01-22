import 'package:flutter/material.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/models/cart_item.dart';
import 'package:plant_app/data.dart';

class ShopViewModel extends ChangeNotifier {
  final List<Plant> _recommended = recommended;
  final List<CartItem> _cart = [];

  List<Plant> get recommendedPlants => _recommended;
  List<CartItem> get cart => _cart;

  double get totalCartPrice {
    return _cart.fold(0.0, (sum, item) => sum + (item.plant.plantPrice * item.quantity));
  }

  int get cartCount {
    return _cart.fold(0, (sum, item) => sum + item.quantity);
  }

  void toggleFavorite(Plant plant) {
    plant.isFavorite = !plant.isFavorite;
    notifyListeners();
  }

  void addToCart(Plant plant, [int quantity = 1]) {
    var existingItemIndex = _cart.indexWhere((item) => item.plant.id == plant.id);
    if (existingItemIndex != -1) {
      _cart[existingItemIndex].quantity += quantity;
    } else {
      _cart.add(CartItem(plant, quantity));
    }
    notifyListeners();
  }

  void removeFromCart(Plant plant) {
    _cart.removeWhere((item) => item.plant.id == plant.id);
    notifyListeners();
  }

  void updateQuantity(Plant plant, int quantity) {
    var index = _cart.indexWhere((item) => item.plant.id == plant.id);
    if (index != -1) {
      if (quantity <= 0) {
        _cart.removeAt(index);
      } else {
        _cart[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  List<Plant> get favoritePlants => _recommended.where((p) => p.isFavorite).toList();
}
