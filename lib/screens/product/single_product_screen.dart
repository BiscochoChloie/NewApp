// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../models/productModel.dart';
import '../../services/product_services.dart';
import 'edit_product_screen.dart';
import '../home_screen.dart';

class SingleProductScreen extends StatefulWidget {
  final Product product;
  const SingleProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  bool _loading = false;

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                ProductServices.DeleteProduct(widget.product.id.toString());
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 300,
                  height: 380,
                  child: Image.network(
                    widget.product.imageLink,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "₱${widget.product.price}",
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.black,
                        width: 100,
                        height: 30,
                        child: MaterialButton(
                          color: Colors.black,
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProductScreen(
                                      product: widget.product)),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        color: Colors.black,
                        width: 100,
                        height: 30,
                        child: MaterialButton(
                          color: Colors.black,
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            _confirmDialog();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
