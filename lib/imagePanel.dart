import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImagesFromFirebaseStorage();
  }

  Future<void> _loadImagesFromFirebaseStorage() async {
    try {
      // Reference to your Firebase Storage bucket
      var storageRef = firebase_storage.FirebaseStorage.instance.ref().child('fotolar');

      // Get list of all items under the "images" folder
      var imageList = await storageRef.listAll();

      // Iterate through each item and get the download URL
      for (var item in imageList.items) {
        var url = await item.getDownloadURL();
        setState(() {
          _imageUrls.add(url);
        });
      }
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: _imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
