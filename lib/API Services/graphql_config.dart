import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLConfig {
  String url_live = 'https://omaliving.com/graphql';
  String url_stage = 'https://staging2.omaliving.com/graphql';

  String token = '';

  static HttpLink httpLink = HttpLink('https://omaliving.com/graphql');

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(),
        link: _CustomAuthLink(token).concat(httpLink),
      );
}

class _CustomAuthLink extends AuthLink {
  _CustomAuthLink(String token)
      : super(getToken: () async {
          // ...
          // Call your api to refresh the token and return it
          // ...
          SharedPreferences prefs = await SharedPreferences.getInstance();
          token = prefs.getString('token') ?? '';

          if (kDebugMode) {
            print('token -> $token');
          }

          String tokenVal = token;
          return "Bearer $tokenVal";
        });
}
