// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:q/Services/authServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configuration/ApiConfig.dart';
import '../Models/productModel.dart';
import '../Services/productServices.dart';
import 'addProduct.dart';
import 'login.dart';
import 'productDescription.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  itemBuilder: (ctx) => [
                        PopupMenuItem(
                          onTap: () async {
                            await AuthServices.LogOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text('Log Out'),
                        )
                      ])
            ]),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addProduct()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
        body: Container(
            child: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: ProductServices.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<Product> products = snapshot.data!;
                  return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ProductDescription(product: product);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 130,
                                    width: 110,
                                    child: Image.network(product.imageLink),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "₱${product.price}",
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ])));
  }
}
