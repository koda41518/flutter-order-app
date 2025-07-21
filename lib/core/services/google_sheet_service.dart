import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class GoogleSheetService {
  static const String sheetUrl =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vTUgFLHjB74OQ59BYzzG0SBJA7tIzCC-QgsLpuADmZ1v4kP3ZgXBpG10muNhiMt3eGRtqChKm8n5TQ7/pub?gid=0&single=true&output=csv';

  static Future<List<Map<String, dynamic>>> fetchRestaurants() async {
    final response = await http.get(Uri.parse(sheetUrl));

    if (response.statusCode == 200) {
      final rawData = const CsvToListConverter().convert(response.body);
      final headers = rawData.first;
      final rows = rawData.sublist(1);

      return rows.map((row) {
        final Map<String, dynamic> map = {};
        for (int i = 0; i < headers.length; i++) {
          map[headers[i].toString()] = row[i];
        }
        return map;
      }).toList();
    } else {
      throw Exception('❌ Impossible de charger les données du Google Sheet');
    }
  }
}