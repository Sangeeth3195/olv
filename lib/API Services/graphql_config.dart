import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {

  String url_live = 'https://omaliving.com/graphql';
  String url_stage = 'https://staging2.omaliving.com/';

  static HttpLink httpLink = HttpLink(
    'https://omaliving.com/graphql',
  );

  GraphQLClient clientToQuery() => GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}