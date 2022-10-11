// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../models/productModel.dart';
import '../../services/product_services.dart';
import 'single_product_screen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: ProductServices.getAllProducts(),
        builder: (context, snapshot) {
          //  if (snapshot.data == null) {
          //         return Center(child: CircularProgressIndicator());
          //       } else {
          //         List<Product> products = snapshot.data!;
          //         return ListView.builder(
          //             itemCount: products.length,
          //             itemBuilder: (context, index) {
          //               Product product = products[index];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var product = snapshot.data?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SingleProductScreen(product: product);
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 130,
                          width: 110,
                          child: Image.network(product!.imageLink),
                        ),
                        Expanded(
                            child: Container(
                                width: 500,
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))),
                        SizedBox(width: 15),
                        Expanded(child: Text("₱${product.price}"))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 0.5, height: 0.5);
              },
              itemCount: snapshot.data?.length ?? 0);
          // List<Product> products = snapshot.data!;
          // return ListView.builder(
          //     itemCount: products.length,
          //     itemBuilder: (context, index) {
          //       Product product = products[index];

          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.of(context)
          //               .push(MaterialPageRoute(builder: (context) {
          //             return ProductDescription(product: product);
          //           }));
          //         },
          //         child: Padding(
          //           padding:
          //               const EdgeInsets.only(left: 10, right: 10),
          //           child: Container(
          //             margin: const EdgeInsets.only(bottom: 10),
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: Colors.grey,
          //                 width: 3,
          //               ),
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(5),
          //               ),
          //             ),
          //             child: Row(
          //               children: <Widget>[
          //                 SizedBox(
          //                   height: 130,
          //                   width: 110,
          //                   child: Image.network(product.imageLink),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(left: 10),
          //                   child: Column(
          //                     textDirection: TextDirection.ltr,
          //                     children: [
          //                       Text(
          //                         product.name,
          //                         style: TextStyle(
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                       Container(
          //                         padding:
          //                             const EdgeInsets.all(8.0),
          //                         child: Text(
          //                           "₱${product.price}",
          //                           textDirection:
          //                               TextDirection.ltr,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     });
        });
  }
}
