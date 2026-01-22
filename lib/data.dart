import 'package:plant_app/models/cart_item.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/models/recently_viewed.dart';

List<Plant> recommended = [
  Plant(
    id: '1',
    plantType: 'Indoor',
    plantName: 'Palm',
    plantPrice: 480.0,
    stars: 3.5,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/Palm.png',
  ),
  Plant(
    id: '2',
    plantType: 'Outdoor',
    plantName: 'Ficus Alli',
    plantPrice: 600.0,
    stars: 3.0,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/ficuss_alii.png',
  ),
  Plant(
    id: '3',
    plantType: 'Outdoor',
    plantName: 'Money Bonsai',
    plantPrice: 4000.0,
    stars: 4.0,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/money_bonsai.png',
  ),
  Plant(
    id: '4',
    plantType: 'Outdoor',
    plantName: 'Juniper Bonsai',
    plantPrice: 2000.0,
    stars: 3.5,
    metrics: PlantMetrics('8.2"', '52%', '4.2"'),
    image: 'images/Juniper_Bonsai.png',
  ),
  Plant(
    id: '5',
    plantType: 'Indoor',
    plantName: 'Snake Plant',
    plantPrice: 80.0,
    stars: 4.0,
    metrics: PlantMetrics('4', '52%', '4.2"'),
    image: 'images/snake_plant.png',
  )
];

List<ViewHistory> viewed = [
  ViewHistory('Calathea', 'It\'s spines don\'t grow.', 'images/calathea.jpg'),
  ViewHistory('Cactus', 'It has spines.', 'images/cactus.jpg'),
  ViewHistory('Stephine', 'It\'s spines do grow.', 'images/stephine_2.jpg'),
];

// Cart items will be managed by ShopViewModel
List<CartItem> cartItems = [];
