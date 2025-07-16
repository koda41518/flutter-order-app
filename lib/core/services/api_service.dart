import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000'; // Android Emulator

  static Future<List<dynamic>> getRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/restaurants'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  static Future<void> postOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send order');
    }
  }
  static Future<List<dynamic>> getOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        throw Exception('Failed to load orders');
    }
  }
}