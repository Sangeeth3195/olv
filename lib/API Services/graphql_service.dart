import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/categoryList.dart';
import 'graphql_config.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<dynamic>> getCategory({
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
        print(res.first['children']);

        // List<CategoryModel> categorylist =
        //     res.map((e) => print(e));

        return res.first['children'];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<dynamic>> getproductlist({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                  products(
                  filter: {
                    category_id: {eq: "10071"}
                    }
                    sort: {name: ASC}
                    pageSize:16
                    ) {
                    aggregations(filter: {category: {includeDirectChildrenOnly:true}}) {
                      attribute_code
                      count
                      label
                      options {
                        label
                        value
                        count
                      }
                    }
                    items {
                      id
                      name
                      sku
                      url_key
                      small_image{
                          url
                          label
                      }
                    }
                    total_count
                    page_info {
                      page_size
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
        print(res.first['children']);

        return res.first['children'];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<dynamic>> getproductdescription({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                  products(
                  filter: {
                    category_id: {eq: "10071"}
                    }
                    sort: {name: ASC}
                    pageSize:16
                    ) {
                    aggregations(filter: {category: {includeDirectChildrenOnly:true}}) {
                      attribute_code
                      count
                      label
                      options {
                        label
                        value
                        count
                      }
                    }
                    items {
                      id
                      name
                      sku
                      url_key
                      small_image{
                          url
                          label
                      }
                    }
                    total_count
                    page_info {
                      page_size
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
        print(res.first['children']);

        return res.first['children'];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<dynamic>> getsearch({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                  products(
                  filter: {
                    category_id: {eq: "10071"}
                    }
                    sort: {name: ASC}
                    pageSize:16
                    ) {
                    aggregations(filter: {category: {includeDirectChildrenOnly:true}}) {
                      attribute_code
                      count
                      label
                      options {
                        label
                        value
                        count
                      }
                    }
                    items {
                      id
                      name
                      sku
                      url_key
                      small_image{
                          url
                          label
                      }
                    }
                    total_count
                    page_info {
                      page_size
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
        print(res.first['children']);

        return res.first['children'];
      }
    } catch (error) {
      return [];
    }
  }

  static String newuser(String email, String password) {
    return '''
            mutation {
              createCustomerV2(
                input: {
                  firstname: "Test User1"
                  lastname: "Lname"
                  email: "omatestuser1@yopmail.com"
                  password: "omatestuser@321"
                  is_subscribed: true
                }
              ) {
                customer {
                  firstname
                  lastname
                  email
                  is_subscribed
                }
              }
            }
        ''';
  }

  Future<String> createuser(String email, password) async {
    try {
      //initializing GraphQLConfig
      GraphQLConfig graphQLConfiguration = GraphQLConfig();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(login(email, password)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        //  parse your response here and return
        // var data = User.fromJson(result.data["register"]);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  //login
  static String login(String email, String password) {
    return '''
            mutation{
              login(data: {
                email:'$email',
                password: '$password'
              }){
                token
              }
            }
        ''';
  }

  Future<String> Login(String email, password) async {
    try {
      //initializing GraphQLConfig
      GraphQLConfig graphQLConfiguration = GraphQLConfig();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(login(email, password)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        //  parse your response here and return
        // var data = User.fromJson(result.data["register"]);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}
