import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
      'https://omaliving.com/graphql',
  );

  GraphQLClient clientToQuery() => GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}