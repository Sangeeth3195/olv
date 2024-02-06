

import 'dart:convert';

import 'package:omaliving/models/InstaFeed.dart';
import 'package:http/http.dart' as http;

class InstaFeed {
  static const String BASE_URL = 'https://graph.instagram.com/me/media?access_token=IGQWRNaVhBdGdHT3dmVmcyR21YS0xBTXZANakNVT0N4WVQ4Yk0zQjIzVW4zR2VhYUg4RXFudEp3WmREYzNGaXhCcDIyLW92Wm1rVHVJX2cyZA0d0ZATlfRGtyNEhPcHA4b3VHamktYUJlaGRhLVBzWVpKTnYxWEo5NXMZD&fields=id, caption, media_type, media_url, permalink';

  static Future<List<Instafeed>> getInstaPost() async {
    List<Instafeed> instafeed = [];

    String _url;

    try {
        _url = BASE_URL;
      dynamic response = await http.get(Uri.parse(_url));
      dynamic json = jsonDecode(response.body);
      for (var v in (json as List)) {
        instafeed.add(Instafeed.fromJson(v));
      }
    } catch (e) {
      //TODO Handle No Internet Response
    }
    return instafeed;
  }


}
