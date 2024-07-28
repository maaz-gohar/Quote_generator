import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  static const String apiUrl = 'https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en';

  Future<Quote> fetchQuote() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return Quote.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
