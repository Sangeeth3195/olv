import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {

  String url_live = 'https://omaliving.com/graphql';
  String url_stage = 'https://staging2.omaliving.com/graphql';

  String token = '';

  static HttpLink httpLink = HttpLink(
    'https://staging2.omaliving.com/graphql');

  GraphQLClient clientToQuery() => GraphQLClient(
    cache: GraphQLCache(),
    link: _CustomAuthLink().concat(httpLink),
  );
}

class _CustomAuthLink extends AuthLink {
  _CustomAuthLink() : super(
      getToken: () {
        // ...
        // Call your api to refresh the token and return it
        // ...
        String token = 'eyJraWQiOiIxIiwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjM3NywidXR5cGlkIjozLCJpYXQiOjE2ODkyNTY5MTUsImV4cCI6MTY4OTI2MDUxNX0.3LcIiW5r1nxFyGi16m-IGMoCY0nYXgTQXmIXkJeJXqo';
        return "Bearer $token";
      }
  );
}