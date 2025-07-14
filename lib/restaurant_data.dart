import '../models/restaut.dart';

final allRestaurants = <Restaut>[
  Restaut(
    name: 'Burger Tama',
    description: 'Délicieux burgers artisanaux',
    price: 8.50,
    rating: 4.5,
    imageUrl: 'assets/images/Burger Tama.png',
  ),
  Restaut(
    name: 'Cherry Healthy',
    description: 'Repas sains et équilibrés',
    price: 9.20,
    rating: 4.8,
    imageUrl: 'assets/images/Cherry Healthy.png',
  ),
  Restaut(
    name: 'Sushi World',
    description: 'Un voyage de saveurs nippones.',
    price: 24.50,
    imageUrl: 'assets/images/sushi.png',
    rating: 4.8,
  ),
  Restaut(
    name: 'tacos',
    description: 'mexicooo.',
    price: 10.50,
    imageUrl: 'assets/images/tacos.png',
    rating: 4.8,
  ),
  // Ajoute ici facilement de nouveaux restos
];