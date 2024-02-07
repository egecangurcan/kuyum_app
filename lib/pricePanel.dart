import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('fiyatlar').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Product> fiyatlar = snapshot.data!.docs.map((DocumentSnapshot doc) {
          return Product.fromSnapshot(doc);
        }).toList();

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tür", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text("Satış ( ₺ )", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              ),
            ),
            const Divider(),
            ...fiyatlar.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 24)),
                    Text(product.price.toString(), style: const TextStyle(fontSize: 24)),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Product(
      name: data['tur'] ?? '',
      price: data['fiyat'] ?? '',
    );
  }
}