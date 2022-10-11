// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:q/models/productModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/product_services.dart';
import '../home_screen.dart';
import '../../widgets/button_widget.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late int id;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want add this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await ProductServices.addProduct(nameController.text,
                    imageLinkController.text, priceController.text);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Add Product",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: nameController,
                                obscureText: false,
                                decoration: inputDecoration()),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Image Link",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: imageLinkController,
                                decoration: inputDecoration()),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: descriptionController,
                                decoration: inputDecoration()),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                                controller: priceController,
                                decoration: inputDecoration()),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ButtonWidget(text: 'Save', onClicked: _confirmDialog),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
