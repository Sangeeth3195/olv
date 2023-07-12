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

  /// product search
  Future<List<dynamic>> productsearch({
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

  /// create new user
  static String new_user(String firstname, String lastname, String email,
      String password, bool is_subcribed) {
    return '''
            mutation {
              createCustomerV2(
                input: {
                  firstname: '$firstname'
                  lastname: '$lastname'
                  email: '$email'
                  password: '$password'
                  is_subscribed: '$is_subcribed'
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

  Future<String> createuser(String firstname, String lastname,String email, String password,bool issub) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(new_user(firstname, password,email,password,issub)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {

      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// login
  static String login(String email, String password) {
    return '''
            mutation {
                generateCustomerToken(
                  email: "$email",
                  password: "$password" 
                  ) {
                      token
                  }
              }
        ''';
  }

  Future<String> Login(String email, password) async {
    try {
      GraphQLConfig graphQLConfig = GraphQLConfig();
      GraphQLClient client = graphQLConfig.clientToQuery();
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(login(email, password)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data?['generateCustomerToken']['token']);


      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// reset password
  static String resetpass(String email) {
    return '''
            mutation {
              requestPasswordResetEmail(
                email: "$email"
              )
            }
        ''';
  }

  Future<String> resetpassword(String email) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(resetpass(email)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {

      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// subscribe newsletter
  static String sub_email(String email) {
    return '''
            mutation {
                subscribeEmailToNewsletter(
                  email: "$email"
                ) {
                  status
                }
              }
        ''';
  }

  Future<String> subscribe_email(String email) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(sub_email(email)),
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

  /// revoke Customer Token
  static String rev_cus_token() {
    return '''
            mutation {
              revokeCustomerToken {
                result
              }
            }
        ''';
  }

  Future<String> revokeCustomerToken() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(rev_cus_token()),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {

      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Add Customer address
  static String add_cus_add(String firstname, String lastname, String email,
      String password, bool is_subcribed) {
    return '''
            mutation {
              createCustomerV2(
                input: {
                  firstname: '$firstname'
                  lastname: '$lastname'
                  email: '$email'
                  password: '$password'
                  is_subscribed: '$is_subcribed'
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

  Future<String> add_customer_address(String firstname, String lastname,String email, String password,bool issub) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(add_cus_add(firstname, password,email,password,issub)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {

      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Update Customer address
  static String upt_cus_add(String firstname, String lastname, String email,
      String password, bool is_subcribed) {
    return '''
            mutation {
              createCustomerV2(
                input: {
                  firstname: '$firstname'
                  lastname: '$lastname'
                  email: '$email'
                  password: '$password'
                  is_subscribed: '$is_subcribed'
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

  Future<String> update_customer_address(String firstname, String lastname,String email, String password,bool issub) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(upt_cus_add(firstname, password,email,password,issub)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {

      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

}
