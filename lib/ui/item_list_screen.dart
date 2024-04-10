import 'package:deeplinks_app/domain/items_repository.dart';
import 'package:flutter/material.dart';

class ItemListScreen extends StatelessWidget {
  ItemListScreen({
    super.key,
    required this.onTapToCart,
    required this.onTapToItemDetails,
  });

  final void Function() onTapToCart;
  final void Function(String itemId) onTapToItemDetails;

  final items = ItemsRepository.getItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Онлайн магазин'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onTapToCart,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              onTapToItemDetails(item.id);
            },
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        item.id,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
