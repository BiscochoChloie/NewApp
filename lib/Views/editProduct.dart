// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../Models/productModel.dart';
import '../Services/productServices.dart';
import 'homePage.dart';
import 'widgets/button_widget.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool _loading = false;
  bool publish = false;
  int? id;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController publishController = TextEditingController();
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
              onPressed: () {
                ProductServices.EditProduct(
                    widget.product.id,
                    nameController.text,
                    imageLinkController.text,
                    priceController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
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
  void initState() {
    super.initState();
    id = widget.product.id;
    nameController.text = widget.product.name;
    imageLinkController.text = widget.product.imageLink;
    priceController.text = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Edit Product",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            TextFormField(
                                                controller: nameController,
                                                obscureText: false,
                                                decoration: inputDecoration()),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            TextFormField(
                                                controller: imageLinkController,
                                                decoration: inputDecoration()),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                controller:
                                                    descriptionController,
                                                decoration: inputDecoration()),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                  ButtonWidget(
                                      text: 'Edit', onClicked: _confirmDialog),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            ]))))));
  }
}
