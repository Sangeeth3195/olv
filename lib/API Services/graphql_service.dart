import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/categoryList.dart';
import 'graphql_config.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<CategoryModel>> getCategory({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                categoryList {
                  children_count
                  children {
                    id
                    position
                    image
                    level
                    name
                    path
                    url_path
                    url_key
                    children {
                      id
                      level
                      name
                      path
                      url_path
                      url_key
                    }
                  }
                }
              }
            """),
          variables: {
            'limit': limit,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List? res = result.data?['categoryList'];

        if (res == null || res.isEmpty) {
          return [];
        }

        List<CategoryModel> categorylist =
            res.map((feeling) => CategoryModel.fromMap(map: categorylist)).toList();

        return categorylist;
      }
    } catch (error) {
      return [];
    }
  }
}
