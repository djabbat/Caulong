import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  MarketplaceScreen({super.key});

  final List<Map<String, dynamic>> products = [
    {
      "name": "NAD+ 100 мг",
      "price": "₽1990",
      "category": "Нутрицевтики",
      "image": "https://picsum.photos/200/300?random=1 "
    },
    {
      "name": "NMN 500 мг",
      "price": "₽2490",
      "category": "Нутрицевтики",
      "image": "https://picsum.photos/200/300?random=2 "
    },
    {
      "name": "Генетический тест",
      "price": "₽7990",
      "category": "Тестирование",
      "image": "https://picsum.photos/200/300?random=3 "
    },
    {
      "name": "Стволовые клетки (курс)",
      "price": "₽99,000",
      "category": "Терапия",
      "image": "https://picsum.photos/200/300?random=4 "
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Маркетплейс")),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var product = products[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product['image'], height: 100, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product['category'],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(product['price']),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}