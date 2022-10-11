import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Configuration/ApiConfig.dart';
import '../models/productModel.dart';

class ProductServices {
  static Future<List<Product>> getAllProducts() async {
    String token;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();
    token = preferences.getString('token')!;
    var response = await http.get(
      Uri.parse("${ApiConfig.BASE_URL}/api/products"),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      var jsonProducts = jsonResponse['data'];

      List<Product> products = [];
      for (var jsonProduct in jsonProducts) {
        Product product = Product.fromJson(jsonProduct);
        products.add(product);
      }
      return products;
    } else {
      return <Product>[];
    }
  }

  static Future<Product> getSingleProducts(int id) async {
    String token;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();
    token = preferences.getString('token')!;
    var response = await http.get(
      Uri.parse("${ApiConfig.BASE_URL}/api/products/$id"),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Get a Product');
    }
  }

  static Future<void> addProduct(String name, imagelink, price) async {
    var jsonResponse;
    Map data = {
      'name': name,
      'image_link': imagelink,
      // 'description': product.description,
      'price': price
    };
    print(data);
    String? token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    String body = json.encode(data);
    Uri url = Uri.parse("${ApiConfig.BASE_URL}/api/products");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body.toString());
    } else {
      throw Exception('Failed to Add a Product');
    }
  }

  static Future<Product> EditProduct(
      int id, String name, imagelink, price) async {
    var jsonResponse;
    Map data = {
      'name': name,
      'image_link': imagelink,
      // 'description': product.description,
      'price': price,
      'is_published': true
    };

    String? token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    String body = json.encode(data);
    Uri url = Uri.parse("${ApiConfig.BASE_URL}/api/products/$id");
    var response = await http.put(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
      // jsonResponse = json.decode(response.body.toString());
    } else {
      throw Exception('Failed to Edit a Product');
    }
  }

  static Future<void> DeleteProduct(
    String id,
  ) async {
    var jsonResponse;

    String? token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    Uri url = Uri.parse("${ApiConfig.BASE_URL}/api/products/$id");
    var response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 10));

    if (response.statusCode == 201) {
      print("Deleted");
    } else {
      print('Error');
    }
  }
}
