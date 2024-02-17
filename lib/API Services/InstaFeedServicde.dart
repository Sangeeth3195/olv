import 'dart:convert';
import 'dart:developer';

import 'package:omaliving/models/InstaFeed.dart';
import 'package:http/http.dart' as http;

class InstaFeed {
  static const String BASE_URL =
      'https://graph.instagram.com/me/media?access_token=IGQWRQTUFHZAFlnMkRpTEFOZAUNCR1Fybmp1UGhlOGNwb3FsRF9mQkliYS1XQnBIU2gxRUZAIMXJFNHZAjWGpTQk5lZAmtYckxNdUJ0dW1PVVowWFZAmT3FBTU9sNzJZAb3gxcXhkbkJTWnNPVExMWkVSUGlYRDJXLWZA3SkkZD&fields=id, caption, media_type, media_url, permalink';

  static Future<InstafeedModel?> getInstaPost() async {
    String _url;

    try {
      _url = BASE_URL;
      dynamic response = await http.get(Uri.parse(_url));

      return InstafeedModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return null;

      //TODO Handle No Internet Response
    }
  }
}
