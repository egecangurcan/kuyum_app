import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuyum_app/main.dart';

class PasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = 'turandm';

  void _checkPassword(BuildContext context) {
    if (_passwordController.text == _correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditPanel()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hatalı"),
            content: const Text("Tekrar deneyin."),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre girin'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _checkPassword(context),
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditImages(),
    );
  }
}

class EditImages extends StatefulWidget {
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImages> {
  List<File> images = [];
  List<String> imageUrls = [];
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImagesFromFirebaseStorage();
  }

  Future<void> _loadImagesFromFirebaseStorage() async {
    try {
      var storageRef = FirebaseStorage.instance.ref().child('fotolar');
      var imageList = await storageRef.listAll();
      imageUrls = await Future.wait(imageList.items.map((item) => item.getDownloadURL()));
      setState(() {});
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fotoğraflar"),
        actions: [
          TextButton(
            onPressed: uploadImageToFirebaseStorage,
            child: const Text('Yükle', style: TextStyle(fontSize: 20, color: Colors.black)),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: images.length + imageUrls.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          if (index < imageUrls.length) {
            return GestureDetector(
              onTap: () {
                // Implement deletion logic here
                deleteImage(index);
              },
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            );
          } else if (index == imageUrls.length) {
            return Center(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  chooseImage();
                },
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(image: DecorationImage(image: FileImage(images[index - imageUrls.length - 1]))),
            );
          }
        },
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> uploadImageToFirebaseStorage() async {
    try {
      await Future.wait(images.map((element) async {
        Reference storageReference = FirebaseStorage.instance.ref().child('fotolar/${DateTime.now().toString()}');
        await storageReference.putFile(element);
      }));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  void deleteImage(int index) async {
    try {
      var storageRef = FirebaseStorage.instance.refFromURL(imageUrls[index]);
      await storageRef.delete();
      setState(() {
        imageUrls.removeAt(index);
      });
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}

