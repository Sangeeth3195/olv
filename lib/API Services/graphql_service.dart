import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/models/CountryModel.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:omaliving/models/HomePageModel.dart';
import 'package:omaliving/screens/homescreen/homescreen.dart';
import 'package:omaliving/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainLayout.dart';
import '../models/OrderModel.dart';
import 'graphql_config.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<HomePageModel> gethomepagedata() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query { 
                getHomePageData {
                  category
                  title
                  description
                  priority
                  skulist
                  buttontext
                  link
                  sectiondata{
                    title
                    description
                    priority
                    attachment
                    attachmentmob
                    buttontext
                    link
                  }
                }
              }
            """),
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        EasyLoading.dismiss();

        log(jsonEncode(result.data));
        return HomePageModel.fromJson(result.data!!);
      }
    } catch (error) {
      return HomePageModel();
    }
  }

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
                    include_in_menu
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

  Future<dynamic> getproductlist({
    required int limit,
    required int id,
  }) async {
    try {
      EasyLoading.show(status: 'loading...');
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                    products(
                    filter: {
                      category_id: {eq: "$id"}
                      material: {in: [] }
                      color:{in: []}
                      brands:{in:[]}
                      oma_collection:{in:[]}
                      oma_subclass:{in:[]}
                      }
                      sort: {name: ASC}
                      pageSize:"${16}"
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
                        __typename
                        sku
                        price_range {
                          minimum_price {
                            regular_price {
                              value
                              currency
                            }
                          }
                        }
                        ... on ConfigurableProduct {
                            configurable_options {
                            id
                            attribute_id
                            label
                            position
                            use_default
                            attribute_code
                            values {
                              value_index
                              label
                              swatch_data{
                                value
                              }
                            }
                            product_id
                          }
                        variants {
                            product {
                              id
                              name
                              sku
                              attribute_set_id
                              ... on PhysicalProductInterface {
                                weight
                              }
                              price_range{
                                minimum_price{
                                  regular_price{
                                    value
                                    currency
                                  }
                                }
                              }
                              
                            }
                            attributes {
                              uid
                              label
                              code
                              value_index
                            }
                  }
                        }
                        getPriceRange{
                            oldpricevalue  
                            normalpricevalue
                          }
                          textAttributes{
                            weight
                            normalprice
                            specicalprice
                      }
                       dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                             attribute_code
                            attribute_label
                            attribute_value
                      }
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
            'limit': 10,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        EasyLoading.dismiss();

        return result;
      }
    } catch (error) {
      return [];
    }
  }

  Future<dynamic> getproductlistBySorting({
    required int limit,
    required int id,
    required Map<String, dynamic> hashMap,
  }) async {
    try {
      EasyLoading.show(status: 'loading...');

      hashMap['category_id'] = "{eq: $id}";
      var jsonObj = hashMap;
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          onComplete: (data) {
            print(data);
          },
          document: gql("""
           query Query {
                    products(
                    filter: $jsonObj
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
                        __typename
                        sku
                        price_range {
                          minimum_price {
                            regular_price {
                              value
                              currency
                            }
                          }
                        }
                        ... on ConfigurableProduct {
                            configurable_options {
                            id
                            attribute_id
                            label
                            position
                            use_default
                            attribute_code
                            values {
                              value_index
                              label
                              swatch_data{
                                value
                              }
                            }
                            product_id
                          }
                        variants {
                            product {
                              id
                              name
                              sku
                              attribute_set_id
                              ... on PhysicalProductInterface {
                                weight
                              }
                              price_range{
                                minimum_price{
                                  regular_price{
                                    value
                                    currency
                                  }
                                }
                              }
                              
                            }
                            attributes {
                              uid
                              label
                              code
                              value_index
                            }
                  }
                        }
                        getPriceRange{
                            oldpricevalue  
                            normalpricevalue
                          }
                          textAttributes{
                            weight
                            normalprice
                            specicalprice
                      }
                       dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                             attribute_code
                            attribute_label
                            attribute_value
                      }
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
            'limit': 10,
          },
        ),
      );

      if (result.hasException) {
        print(result.exception);
        throw Exception(result.exception);
      } else {
        EasyLoading.dismiss();

        return result;
      }
    } catch (error) {
      print("testing errors$error");
      return [];
    }
  }

  Future<dynamic> getproductdescription({
    required int limit,
    required String id,
  }) async {
    try {
      EasyLoading.show(status: 'loading...');
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                    products(filter: { sku: { eq: "$id" } }) {
                      items {
                        id
                        detail
                        length
                        width
                        height
                        diameter
                        overall
                        capacity
                        depth
                        name
                        sku
                        stock_status
                        only_x_left_in_stock
                        meta_keyword
                        meta_description
                        special_price
                        special_from_date
                        special_to_date
                        attribute_set_id
                        manufacturer
                        canonical_url
                        price_range{
                          minimum_price{
                            regular_price{
                              value
                              currency
                            }
                          }
                        }
                        getPriceRange{
                              oldpricevalue  
                              normalpricevalue
                            }
                            textAttributes{
                              weight
                              normalprice
                              specicalprice
                        }
                         dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                               attribute_code
                              attribute_label
                              attribute_value
                        }
                        description {
                          html
                        }
                        short_description {
                          html
                        }
                        image {
                          url
                          label
                          position
                          disabled
                        }
                        small_image {
                          url
                          label
                          position
                          disabled
                        }
                        thumbnail {
                          url
                          label
                          position
                          disabled
                        }
                        new_from_date
                        new_to_date
                        price_tiers {
                          quantity
                          discount {
                            percent_off
                            amount_off
                          }
                          final_price {
                            value
                            currency
                          }
                        }
                        ... on PhysicalProductInterface {
                          weight
                        }
                        ... on ConfigurableProduct {
                          configurable_options {
                            id
                            attribute_id
                            label
                            position
                            use_default
                            attribute_code
                            values {
                              value_index
                              label
                              swatch_data{
                                value
                              }
                            }
                            product_id
                          }
                          variants {
                            product {
                              id
                              name
                              sku
                              attribute_set_id
                              ... on PhysicalProductInterface {
                                weight
                              }
                              price_range{
                                minimum_price{
                                  regular_price{
                                    value
                                    currency
                                  }
                                }
                              }
                            }
                            attributes {
                              label
                              code
                              value_index
                            }
                          }
                        }
                        options_container
                        created_at
                        updated_at
                        country_of_manufacture
                        type_id
                        websites {
                          id
                          name
                          code
                          sort_order
                          default_group_id
                          is_default
                        }
                        product_links {
                          sku
                          link_type
                          linked_product_sku
                          linked_product_type
                          position
                        }
                        media_gallery {
                          url
                          label
                          position
                          disabled
                          ... on ProductVideo {
                            video_content {
                              media_type
                              video_provider
                              video_url
                              video_title
                              video_description
                              video_metadata
                            }
                          }
                        }
                        price_range {
                          minimum_price {
                            regular_price {
                              value
                              currency
                            }
                            final_price {
                              value
                              currency
                            }
                            fixed_product_taxes {
                              label
                              amount {
                                value
                                currency
                              }
                            }
                          }
                          maximum_price {
                            discount {
                              amount_off
                              percent_off
                            }
                            fixed_product_taxes {
                              label
                              amount {
                                value
                                currency
                              }
                            }
                          }
                        }
                        gift_message_available
                        url_rewrites {
                          parameters {
                            name
                            value
                          }
                        }
                        related_products {
                          id
                          name
                          sku
                          media_gallery {
                                url
                                label
                                position
                                disabled
                                ... on ProductVideo {
                                  video_content {
                                    media_type
                                    video_provider
                                    video_url
                                    video_title
                                    video_description
                                    video_metadata
                                  }
                                }
                              }
                          getPriceRange{
                              oldpricevalue  
                              normalpricevalue
                            }
                           price_range{
                                minimum_price{
                                  regular_price{
                                    value
                                    currency
                                  }
                                }
                              }
                        }
                        upsell_products {
                          id
                          name
                          sku
                        }
                        crosssell_products {
                          id
                          name
                          sku
                        }
                        categories {
                          id
                          url_key
                          name
                          position
                          is_anchor
                          url_suffix
                          description
                          display_mode
                          meta_keywords
                          path_in_store
                          default_sort_by
                          meta_description
                          custom_layout_update_file
                          available_sort_by
                          products {
                            items {
                              id
                              sku
                            }
                          }
                          cms_block {
                            title
                            content
                            identifier
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
        EasyLoading.dismiss();

        dynamic res = result.data?['products']['items'];

        if (res == null || res.isEmpty) {
          return [];
        }

        return res;
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<dynamic>> productsearch({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                  products(search: "item-028258") {
                    items {
                      id
                      name
                      sku
                      stock_status
                      only_x_left_in_stock
                      meta_keyword
                      meta_description
                      special_price
                      special_from_date
                      special_to_date
                      attribute_set_id
                      manufacturer
                      canonical_url
                      description {
                        html
                      }
                      short_description {
                        html
                      }
                      image {
                        url
                        label
                        position
                        disabled
                      }
                      small_image {
                        url
                        label
                        position
                        disabled
                      }
                      thumbnail {
                        url
                        label
                        position
                        disabled
                      }
                      new_from_date
                      new_to_date
                      price_tiers {
                        quantity
                        discount {
                          percent_off
                          amount_off
                        }
                        final_price {
                          value
                          currency
                        }
                      }
                      ... on PhysicalProductInterface {
                        weight
                      }
                      options_container
                      created_at
                      updated_at
                      country_of_manufacture
                      type_id
                      websites {
                        id
                        name
                        code
                        sort_order
                        default_group_id
                        is_default
                      }
                      product_links {
                        sku
                        link_type
                        linked_product_sku
                        linked_product_type
                        position
                      }
                      media_gallery {
                        url
                        label
                        position
                        disabled
                        ... on ProductVideo {
                          video_content {
                            media_type
                            video_provider
                            video_url
                            video_title
                            video_description
                            video_metadata
                          }
                        }
                      }
                      price_range {
                        minimum_price {
                          regular_price {
                            value
                            currency
                          }
                          final_price {
                            value
                            currency
                          }
                          fixed_product_taxes {
                            label
                            amount {
                              value
                              currency
                            }
                          }
                        }
                        maximum_price {
                          discount {
                            amount_off
                            percent_off
                          }
                          fixed_product_taxes {
                            label
                            amount {
                              value
                              currency
                            }
                          }
                        }
                      }
                      gift_message_available
                      url_rewrites {
                        parameters {
                          name
                          value
                        }
                      }
                      related_products {
                        id
                        name
                        sku
                      }
                      upsell_products {
                        id
                        name
                        sku
                      }
                      crosssell_products {
                        id
                        name
                        sku
                      }
                      categories {
                        id
                        url_key
                        name
                        position
                        is_anchor
                        url_suffix
                        description
                        display_mode
                        meta_keywords
                        path_in_store
                        default_sort_by
                        meta_description
                        custom_layout_update_file
                        available_sort_by
                        products {
                          items {
                            id
                            sku
                          }
                        }
                        cms_block {
                          title
                          content
                          identifier
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

  /// create new user
  static String new_user(String firstname, String lastname, String email,
      String password, bool isSubcribed) {
    return '''
            mutation {
              createCustomer(
                input: {
                  firstname: "$firstname"
                  lastname: "$lastname"
                  email: "$email"
                  password: "$password"
                  is_subscribed: $isSubcribed
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

  Future<String> createuser(String firstname, String lastname, String email,
      String password, bool issub, BuildContext context) async {
    try {
      print(firstname);
      print(lastname);
      print(email);
      print(password);
      print(issub);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(
              new_user(firstname, lastname, email, password, issub)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        print(result.data?['createCustomerV2']['customer']);

        EasyLoading.dismiss();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainLayout()),
            (Route<dynamic> route) => false);
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

  Future<String> Login(String email, password, BuildContext context) async {
    try {
      GraphQLConfig graphQLConfig = GraphQLConfig();
      GraphQLClient client = graphQLConfig.clientToQuery();
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(login(email, password)), // this
        ),
      );
      if (result.hasException) {
        print('---${result.exception!.graphqlErrors[0].message}');
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        print(result.data?['generateCustomerToken']['token']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'token', result.data?['generateCustomerToken']['token']);

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

        Navigator.of(context).pop();
        context.go('/home');
        Fluttertoast.showToast(msg: 'Login successfully');
      }

      MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);
      myProvider.getuserdata();


      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Social login
  static String social_login(String firstname, String lastname, String email,
      String token, bool issub) {
    return '''
            mutation {
                createCustomerV3(
                  input: {
                    firstname: "$firstname"
                    lastname: "$firstname"
                    email: "$email"
                    token: "$token"
                    is_subscribed: $issub
                  }
                ) {
                  token
                }
              }
        ''';
  }

  Future<String> Social_Login(String firstname, lastname, email, token,
      issubscribe, BuildContext context) async {
    try {
      GraphQLConfig graphQLConfig = GraphQLConfig();
      GraphQLClient client = graphQLConfig.clientToQuery();
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(social_login(
              firstname, lastname, email, token, issubscribe)), // this
        ),
      );
      if (result.hasException) {
        print('---${result.exception!.graphqlErrors[0].message}');
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        print(result.data?['createCustomerV3']['token']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', result.data?['createCustomerV3']['token']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainLayout()),
            (Route<dynamic> route) => false);

        Fluttertoast.showToast(msg: 'Login successfully');
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

  Future<String> resetpassword(String email, BuildContext context) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(resetpass(email)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        print(result.data?['requestPasswordResetEmail']);
        if (result.data?['requestPasswordResetEmail'] == true) {
          Fluttertoast.showToast(
              msg: 'A link to reset your password will be sent to your email');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);

          print(result.exception?.graphqlErrors[0].message);
        } else {}
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// change password
  static String changepws(String email, String token, String password) {
    return '''
            mutation {
              resetPassword(
              email: "$email",
              resetPasswordToken: "$token",
              newPassword: "$password"
            )
            }
        ''';
  }

  Future<String> chnagepassword(
      String email, String token, String password, BuildContext context) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(changepws(email, token, password)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        print(result.data?['requestPasswordResetEmail']);
        if (result.data?['requestPasswordResetEmail'] == true) {
          Fluttertoast.showToast(
              msg: 'A link to reset your password will be sent to your email');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);

          print(result.exception?.graphqlErrors[0].message);
        } else {}
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Add Customer address
  static String add_cus_add(
      {required String firstname,
      required String lastname,
      required String phNo,
      required String postalCode,
      required String city,
      required String address,
      required String region,
      required String regioncode,
      required String countryCode,
      required String regionId,
      bool? isSubcribed}) {
    return '''
            mutation {
            
              createCustomerAddress(
                input: {
                  region: {
      region: "$region"
      region_code: "$regioncode"
      region_id: "$regionId"
    }
    country_code: $countryCode
    street: ["$address"]
    telephone: "$phNo"
    postcode: "$postalCode"
    city: "$city"
    firstname: "$firstname"
    lastname: "$lastname"
    default_shipping: true
    default_billing: false
                }
              ) {
    id
    region {
      region
      region_code
    }
    country_code
    street
    telephone
    postcode
    city
    default_shipping
    default_billing
  }
            }
        ''';
  }

  Future<String> add_customer_address(
      {required String firstname,
      required String lastname,
      required String phNo,
      required String postalCode,
      required String city,
      required String address,
      required String region,
      required String regioncode,
      required String countryCode,
      required String regionId,
      bool? isSubcribed}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(add_cus_add(
              firstname: firstname,
              lastname: lastname,
              city: city,
              address: address,
              phNo: phNo,
              postalCode: postalCode,
              isSubcribed: true,
              countryCode: countryCode,
              region: region,
              regioncode: regioncode,
              regionId: regionId)), // this
        ),
      );
      log(add_cus_add(
              firstname: firstname,
              lastname: lastname,
              phNo: phNo,
              postalCode: postalCode,
              city: city,
              address: address,
              region: region,
              regioncode: regioncode,
              countryCode: countryCode,
              regionId: regionId)
          .toString());
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        return "200";
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<String> update_customer_address(
      {required String firstname,
      required String lastname,
      required String phNo,
      required String postalCode,
      required String city,
      required String address,
      required String region,
      required String regioncode,
      required String countryCode,
      required String regionId,
      bool? billingadd,
      bool? shippadd,
      required String id}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(upd_cus_add(
              firstname: firstname,
              lastname: lastname,
              city: city,
              address: address,
              phNo: phNo,
              postalCode: postalCode,
              // isSubcribed: true,
              countryCode: countryCode,
              region: region,
              regioncode: regioncode,
              regionId: regionId,
              billingadd: billingadd,
              shippadd: shippadd,
              id: id)), // this
        ),
      );
      log(upd_cus_add(
              firstname: firstname,
              lastname: lastname,
              phNo: phNo,
              postalCode: postalCode,
              city: city,
              address: address,
              region: region,
              regioncode: regioncode,
              countryCode: countryCode,
              regionId: regionId,
              billingadd: billingadd,
              shippadd: shippadd,
              id: id)
          .toString());
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        return "200";
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Update Customer address
  static String upd_cus_add(
      {required String firstname,
      required String lastname,
      required String phNo,
      required String postalCode,
      required String city,
      required String address,
      required String region,
      required String regioncode,
      required String countryCode,
      required String regionId,
      bool? billingadd,
      bool? shippadd,
      required String id}) {
    return '''
            mutation {
            
              updateCustomerAddress(
                              id: $id
                                input: {
                                  region: {
                      region: "$region"
                      region_code: "$regioncode"
                      region_id: "$regionId"
                    }
                    country_code: $countryCode
                    street: ["$address"]
                    telephone: "$phNo"
                    postcode: "$postalCode"
                    city: "$city"
                    firstname: "$firstname"
                    lastname: "$lastname"
                    default_shipping: $billingadd
                    default_billing: $shippadd
                                }
                              ) {
                    id
                    region {
                      region
                      region_code
                    }
                    country_code
                    street
                    telephone
                    postcode
                    city
                    default_shipping
                    default_billing
                  }
                            }
        ''';
  }

  static String update_customer_details(
      {required String firstname,
      required String lastname,
      required String email,
      bool? isSubscribed}) {
    return '''
            mutation {
              updateCustomer(
                  input: {
                    firstname: "$firstname"
                    lastname: "$lastname"
                    is_subscribed: $isSubscribed
                  }
                ) {
                  customer {
                    firstname
                    is_subscribed
                  }
                }
            }
        ''';
  }

  Future<String> update_customer_details_api(
      {required String firstname,
      required String lastname,
      required String email,
      bool? isSubscribed}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(update_customer_details(
              firstname: firstname,
              lastname: lastname,
              email: email,
              isSubscribed: isSubscribed)), // this
        ),
      );
      log(update_customer_details(
              firstname: firstname,
              lastname: lastname,
              email: email,
              isSubscribed: isSubscribed)
          .toString());
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        return "200";
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Get Customer address
  static String get_cus_det() {
    return '''
            {
              customer {
                firstname
                lastname
                is_subscribed
                suffix
                email
                wishlists {
                  id
                }
                addresses {
                  id
                  firstname
                  lastname
                  street
                  city
                  region {
                    region_code
                    region
                  }
                  postcode
                  country_code
                  telephone
                  default_shipping
                  default_billing
                }
            
                wishlist {
                  items_count
                  sharing_code
                  updated_at
                  items {
                    id
                    qty
                    description
                    added_at
                    product {
                      sku
                      name
                      ... on BundleProduct {
                        sku
                        dynamic_sku
                      }
                      ... on ConfigurableProduct {
                        sku
                        configurable_options {
                          id
                          attribute_id_v2
                          attribute_code
                          label
                          __typename
                          use_default
                          values {
                            store_label
                            swatch_data {
                              value
                            }
                            use_default_value
                          }
                        }
                      }
                      media_gallery {
                            url
                            label
                            position
                            disabled
                            ... on ProductVideo {
                              video_content {
                                media_type
                                video_provider
                                video_url
                                video_title
                                video_description
                                video_metadata
                              }
                            }
                          }
                      price_range {
                        minimum_price {
                          regular_price {
                            value
                            currency
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
        ''';
  }

  Future<CustomerModel> get_customer_details() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(get_cus_det()), // this
        ),
      );
      if (result.hasException) {
        EasyLoading.dismiss();
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        EasyLoading.dismiss();
        log(jsonEncode(result.data));
        print(result.data?['customer']['addresses']);
        return CustomerModel.fromJson(result.data!);
      }
      EasyLoading.dismiss();
      return CustomerModel();
    } catch (e) {
      print(e);
      return CustomerModel();
    }
  }

  /// Get Customer Details & Address List
  Future<List<dynamic>> getcustomeraddresslist({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                    customer {
                      firstname
                      lastname
                      suffix
                      email
                      wishlists{
                          id
                      }
                      addresses {
                          id
                        firstname
                        lastname
                        street
                        city
                        region {
                          region_code
                          region
                        }
                        postcode
                        country_code
                        telephone
                        default_shipping
                        default_billing
                      }
                    }
                  }
            """),
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List? res = result.data?['categoryList'];

        if (res == null || res.isEmpty) {
          return [];
        }

        return res.first['children'];
      }
    } catch (error) {
      return [];
    }
  }

  /// Get Order Details
  Future<OrderModel> getorderdetails({
    required int limit,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                  customer {
                    orders(pageSize: 200) {
                      items {
                        id
                        order_number
                        status
                        shipping_method
                        payment_methods {
                          name
                        }
                        shipping_address {
                          firstname
                          lastname
                          street
                          city
                          telephone
                          region
                          postcode
                        }
                        billing_address {
                          firstname
                          lastname
                          street
                          city
                          telephone
                          region
                          postcode
                        }
                
                        items {
                          product_name
                          product_type
                          product_sku
                          product_sale_price {
                            value
                            currency
                          }
                          quantity_ordered
                        }
                        order_date
                        total {
                          total_shipping {
                            value
                            currency
                          }
                          subtotal {
                            value
                            currency
                          }
                          grand_total {
                            value
                            currency
                          }
                        }
                        status
                      }
                    }
                  }
                }
            """),
        ),
      );

      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        EasyLoading.dismiss();
      } else if (result.data != null) {
        log(jsonEncode(result.data));
        EasyLoading.dismiss();

        return OrderModel.fromJson(result.data!);
      }
      EasyLoading.dismiss();

      return OrderModel();
    } catch (e) {
      print(e);
      return OrderModel();
    }
  }

  /// Get Region
  Future<CountryModel> getregion() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                countries {
                  id
                  two_letter_abbreviation
                  three_letter_abbreviation
                  full_name_locale
                  full_name_english
                  available_regions {
                    id
                    code
                    name
                  }
                }
              }
            """),
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return CountryModel.fromJson(result.data!);
      }
    } catch (error) {
      return CountryModel();
    }
  }

  /// Revoke Customer Token
  Future<String> revokeuser(BuildContext context) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           mutation {
              revokeCustomerToken {
                result
              }
            }
            """),
        ),
      );

      if (result.hasException) {
        if (kDebugMode) {
          print(result.exception?.graphqlErrors[0].message);
        }
      } else if (result.data != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => MainLayout()),
        //     (Route<dynamic> route) => false);

        Fluttertoast.showToast(msg: 'Logout successfully');
      }
      Navigator.of(context).pop();
      context.go('/home');

      // MyProvider  myProvider = Provider.of<MyProvider>(context, listen: true);
      // myProvider.customerModel=CustomerModel();
      // myProvider.getuserdata();
      // myProvider.notifyListeners();
      // final NavbarNotifier _navbarNotifier = NavbarNotifier();
      // _navbarNotifier.setIndexFor(0);

      return "";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }

  /// Custom Web view
  Future<Object> getcustomwebview(String value) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                  cmsPage(identifier: "$value") {
                    identifier
                    url_key
                    title
                    content
                    content_heading
                    page_layout
                    meta_title
                    meta_description
                    meta_keywords
                  }
                }
            """),
        ),
      );

      if (result.hasException) {
        EasyLoading.dismiss();
        throw Exception(result.exception);
      } else {
        EasyLoading.dismiss();
        return result;
      }
    } catch (error) {
      return [];
    }
  }

  static String update_custor_password({
    required String password,
  }) {
    return '''
            mutation {
              updateCustomer(
                  input: {
                    password: "$password"
                  }
                ) {
                  customer {
                    firstname
                    is_subscribed
                  }
                }
            }
        ''';
  }

  Future<String> update_reset_password({required String password}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(update_custor_password(password: password)), // this
        ),
      );
      log(update_custor_password(password: password).toString());
      if (result.hasException) {
        EasyLoading.dismiss();
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        EasyLoading.dismiss();
        return "200";
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  // --------------- Wishlist FUNCTION -------------- //

  /// Add Product to Wishlist
  static String addProductfromwishlist(
      {required String sku, required String qty}) {
    return '''
            mutation {
                  addProductsToWishlist(
                    wishlistId: 
                    wishlistItems: [
                      {
                        sku: "$sku"
                        quantity: $qty
                      }
                    ]
                  ) {
                    wishlist {
                        items_count
                        sharing_code
                        updated_at
                        items {
                          id
                          qty
                          description
                          added_at
                          product {
                            sku
                            name
                            media_gallery {
                          url
                          label
                          position
                          disabled
                          ... on ProductVideo {
                            video_content {
                              media_type
                              video_provider
                              video_url
                              video_title
                              video_description
                              video_metadata
                            }
                          }
                        }
                            ... on BundleProduct {
                              sku
                              dynamic_sku
                            }
                            ... on ConfigurableProduct {
                              sku
                              configurable_options {
                                id
                                attribute_id_v2
                                attribute_code
                                label
                                __typename
                                use_default
                                values {
                                  store_label
                                  swatch_data {
                                    value
                                  }
                                  use_default_value
                                }
                              }
                            }
                            price_range{
                                minimum_price{
                                  regular_price{
                                    value
                                    currency
                                  }
                                }
                              }
                          }
                        }
                      }
                    user_errors {
                      code
                      message
                    }
                  }
                }

        ''';
  }

  Future<String> add_Product_from_wishlist(
      {required String sku, required String qty}) async {
    try {
      print(sku);
      print(qty);

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(addProductfromwishlist(sku: sku, qty: qty)), // this
        ),
      );

      log(addProductfromwishlist(sku: sku, qty: qty).toString());

      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        log(jsonEncode(result.data));

        EasyLoading.dismiss();
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Remove Product from Wishlist
  static String removeProductfromwishlist(
      {required String wishlistId, required String wishlistItemsIds}) {
    return '''
            mutation {
                removeProductsFromWishlist(
                wishlistId: $wishlistId
                wishlistItemsIds: [$wishlistItemsIds]
                ){
                  wishlist {
                      items_count
                      sharing_code
                      updated_at
                      items {
                        id
                        qty
                        description
                        added_at
                        product {
                          sku
                          name
                          media_gallery {
                        url
                        label
                        position
                        disabled
                        ... on ProductVideo {
                          video_content {
                            media_type
                            video_provider
                            video_url
                            video_title
                            video_description
                            video_metadata
                          }
                        }
                      }
                          ... on BundleProduct {
                            sku
                            dynamic_sku
                          }
                          ... on ConfigurableProduct {
                            sku
                            configurable_options {
                              id
                              attribute_id_v2
                              attribute_code
                              label
                              __typename
                              use_default
                              values {
                                store_label
                                swatch_data {
                                  value
                                }
                                use_default_value
                              }
                            }
                          }
                          price_range{
                              minimum_price{
                                regular_price{
                                  value
                                  currency
                                }
                              }
                            }
                        }
                      }
                    }
                  user_errors {
                    code
                    message
                  }
                }
              }
        ''';
  }

  Future<String> remove_Product_from_wishlist(
      {required String wishlistId, required String wishlistItemsIds}) async {
    try {
      print(wishlistId);
      print(wishlistItemsIds);

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(removeProductfromwishlist(
              wishlistId: wishlistId,
              wishlistItemsIds: wishlistItemsIds)), // this
        ),
      );

      log(removeProductfromwishlist(
              wishlistId: wishlistId, wishlistItemsIds: wishlistItemsIds)
          .toString());

      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        log(jsonEncode(result.data));

        EasyLoading.dismiss();
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  // --------------- CART FUNCTION -------------- //

  /// Step 1 - Create Cart
  static String crt_cart() {
    return '''
             mutation {
                createEmptyCart
              }
        ''';
  }

  Future<String> create_cart() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(crt_cart()), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data?['createEmptyCart']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cart_token', result.data?['createEmptyCart']);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 2 - Create Cart Non logged In
  static String crt_cart_non_user() {
    return '''
            mutation {
            createEmptyCart
          }
        ''';
  }

  Future<String> create_cart_non_user() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(crt_cart_non_user()), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data?['createEmptyCart']);
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 3 - I - add Product to Cart
  static String add_prd_to_cart(String cart_token,String sku, String qty,) {
    return '''
            mutation {
                addSimpleProductsToCart(
                  input: {
                    cart_id: $cart_token
                    cart_items: [
                      {
                        data: {
                          quantity: $qty
                          parent_sku:""
                          sku: $sku
                        }
                      }
                    ]
                  }
                ) {
                  cart {
                    items {
                      id
                      product {
                        name
                        sku
                      }
                       quantity
                    }
                     prices {
                      grand_total{
                        value
                        currency
                      }
                    }
                  }
                }
              }
        ''';
  }

  Future<String> addProductToCart(String sku, String qty,) async {
    try {

      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      var cart_token = prefs.getString('cart_token') ?? '';

      print(cart_token);

      if (cart_token == '') {
        await create_cart();
        cart_token=prefs.getString('cart_token') ?? '';
      }


      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(add_prd_to_cart(cart_token,sku,qty,)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 3 - II - Update Product to Cart
  static String upt_prd_to_cart(String cart_token,String uid, String qty,) {
    return '''
            mutation {
                  updateCartItems(
                    input: {
                      cart_id: $cart_token,
                      cart_items: [
                        {
                          cart_item_uid: $uid
                          quantity: $qty
                        }
                      ]
                    }
                  ){
                    cart {
                       id
                    items {                    
                      product {
                        sku
                        uid
                        name
                        dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                             attribute_code
                            attribute_label
                            attribute_value
                      }
                        media_gallery {
                        url
                        label
                        position
                        disabled
                      }
                      }
                    }
                   
                   shipping_addresses {
                      available_shipping_methods {
                        amount {
                          currency
                          value
                        }
                        available
                        carrier_code
                        carrier_title
                        method_code
                        method_title
                        price_excl_tax {
                          value
                          currency
                        }
                        price_incl_tax {
                          value
                          currency
                        }
                      }
                      selected_shipping_method {
                        amount {
                          value
                          currency
                        }
                        carrier_code
                        carrier_title
                        method_code
                        method_title
                      }
                    }
                
                    prices {
                        discounts {
                          label
                          amount {
                            value
                          }
                        }
                subtotal_excluding_tax{
                          value
                          currency
                        }
                
                        grand_total{
                          value
                          currency
                        }
                      }
                    }
                  }
                }
        ''';
  }

  Future<String> update_product_to_cart(String uid, String qty,) async {
    try {
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      var cart_token = prefs.getString('cart_token') ?? '';

      print(cart_token);

      if (cart_token == '') {
        await create_cart();
        cart_token=prefs.getString('cart_token') ?? '';
      }

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(upt_prd_to_cart(cart_token,uid,qty)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 3 - III - GET Cart List
  static String gt_crt_list(String cart_token) {
    return '''
            {
                cart(
                  cart_id: $cart_token
                ) {
                    id
                  items {
                    quantity
                    product {
                      sku
                      uid
                      name
                      dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                           attribute_code
                          attribute_label
                          attribute_value
                    }
                      media_gallery {
                      url
                      label
                      position
                      disabled
                    }
                    }
                  }
                 shipping_addresses {
                    available_shipping_methods {
                      amount {
                        currency
                        value
                      }
                      available
                      carrier_code
                      carrier_title
                      method_code
                      method_title
                      price_excl_tax {
                        value
                        currency
                      }
                      price_incl_tax {
                        value
                        currency
                      }
                    }
                    selected_shipping_method {
                      amount {
                        value
                        currency
                      }
                      carrier_code
                      carrier_title
                      method_code
                      method_title
                    }
                  }
              
                  prices {
                      discounts {
                        label
                        amount {
                          value
                        }
                      }
                      
                  subtotal_excluding_tax{
                        value
                        currency
                      }
              
                      grand_total{
                        value
                        currency
                      }
                    }
                }
              }
        ''';
  }

  Future<String> get_cart_list() async {

    try {
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      var cart_token = prefs.getString('cart_token') ?? '';

      print(cart_token);

      if (cart_token == '') {
        await create_cart();
        cart_token=prefs.getString('cart_token') ?? '';
      }

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(gt_crt_list(cart_token)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 3 - IV - Remove Item from Cart
  static String rmv_itm_frm_cart(String cart_token,String id,) {
    return '''
            mutation {
                  removeItemFromCart(
                    input: {
                      cart_id: $cart_token,
                      cart_item_id: $id
                    }
                  )
                 {
                  cart {
                       id
                      
                    items {
                      quantity
                    
                      product {
                        sku
                        
                        uid
                        name
                        dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                             attribute_code
                            attribute_label
                            attribute_value
                      }
                        media_gallery {
                        url
                        label
                        position
                        disabled
                      }
                      }
                    }
                   
                   shipping_addresses {
                      available_shipping_methods {
                        amount {
                          currency
                          value
                        }
                        available
                        carrier_code
                        carrier_title
                        method_code
                        method_title
                        price_excl_tax {
                          value
                          currency
                        }
                        price_incl_tax {
                          value
                          currency
                        }
                      }
                      selected_shipping_method {
                        amount {
                          value
                          currency
                        }
                        carrier_code
                        carrier_title
                        method_code
                        method_title
                      }
                    }
                
                    prices {
                        discounts {
                          label
                          amount {
                            value
                          }
                        }
                
                subtotal_excluding_tax{
                
                          value
                          currency
                        }
                
                        grand_total{
                          value
                          currency
                        }
                      }
                  }
                 }
                }
        ''';
  }

  Future<String> remove_item_from_cart(String cart_token,String id,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(rmv_itm_frm_cart(cart_token,id)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  // ---------- Here Compulsory Login needed ----------- //

  /// Step 4 - assign Customer To Guest Cart
  static String assign_Customer_To_Guest_Crt(String cart_token,) {
    return '''
            mutation {
                  assignCustomerToGuestCart(
                    cart_id: $cart_token
                  ) {
                      items {
                      quantity
                      id
                      uid
                      product {
                        sku
                        uid
                        name
                        dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                             attribute_code
                            attribute_label
                            attribute_value
                      }
                        media_gallery {
                        url
                        label
                        position
                        disabled
                      }
                      }
                    }
                     shipping_addresses {
                              available_shipping_methods {
                                amount {
                                  currency
                                  value
                                }
                                available
                                carrier_code
                                carrier_title
                                method_code
                                method_title
                                price_excl_tax {
                                  value
                                  currency
                                }
                                price_incl_tax {
                                  value
                                  currency
                                }
                              }
                              selected_shipping_method {
                                amount {
                                  value
                                  currency
                                }
                                carrier_code
                                carrier_title
                                method_code
                                method_title
                              }
                            }
                  }
                }
        ''';
  }

  Future<String> assign_Customer_To_Guest_Cart(String cart_token,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(assign_Customer_To_Guest_Crt(cart_token)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data?['customerCart']['id']);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 5 - Set Shipping Address On Cart
  static String set_shipping_add_to_cart(String cart_token,) {
    return '''
            mutation {
                  setShippingAddressesOnCart(
                    input: {
                      cart_id: $cart_token
                      shipping_addresses: [
                        {
                          address: {
                            firstname: ""
                            lastname: ""
                            company: ""
                            street: [""]
                            city: ""
                            region_id: 
                            region: ""
                            postcode: ""
                            country_code: ""
                            telephone: ""
                            save_in_address_book: false
                          },
                          pickup_location_code: ""
                        }
                      ]
                    }
                  ) {
                    cart {
                      shipping_addresses {
                        firstname
                        lastname
                        company
                        street
                        city
                        region {
                          code
                          label
                        }
                        postcode
                        telephone
                        country {
                          code
                          label
                        }
                        pickup_location_code
                      }
                    }
                  }
                }
        ''';
  }

  Future<String> set_shipping_address_to_cart(String cart_token,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(set_shipping_add_to_cart(cart_token)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data?['customerCart']['id']);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 6 - Set billing Address to cart
  static String St_billing_Address_to_cart(String cart_token) {
    return '''
            mutation {
                setBillingAddressOnCart(
                  input: {
                    cart_id: $cart_token
                    billing_address: {
                      address: {
                        firstname: "John"
                        lastname: "Doe"
                        company: "Company Name"
                        street: ["64 Strawberry Dr"]
                        city: "Los Angeles"
                        region: "AN"
                        region_id: 533
                        postcode: "90210"
                        country_code: "IN"
                        telephone: "123-456-0000"
                        save_in_address_book: true
                      }
                    }
                  }
                ) {
                  cart {
                    billing_address {
                      firstname
                      lastname
                      company
                      street
                      city
                      region{
                        code
                        label
                      }
                      postcode
                      telephone
                      country {
                        code
                        label
                      }
                    }
                  }
                }
              }

        ''';
  }

  Future<String> Set_billing_Address_to_cart(
      {required String cart_token, required String wishlistItemsIds}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(St_billing_Address_to_cart(cart_token)), // this
        ),
      );

      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        log(jsonEncode(result.data));

        EasyLoading.dismiss();
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 7 - Set Shipping Method to cart
  static String st_shp_to_mtd_to_cart(String cart_token,String carrier_code,) {
    return '''
            mutation {
              setShippingMethodsOnCart(
                input: {
                  cart_id: $cart_token,
                  shipping_methods: [
                    {
                      carrier_code: $carrier_code
                      method_code: $carrier_code
                    }
                  ]
                }
              ) {
                cart {
                  shipping_addresses {
                    selected_shipping_method {
                      carrier_code
                      carrier_title
                      method_code
                      method_title
                      amount {
                        value
                        currency
                      }
                    }
                  }
                }
              }
            }
        ''';
  }

  Future<String> set_shipping_method_to_cart(String cart_token,String cpn,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(st_shp_to_mtd_to_cart(cart_token,cpn)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 8 - I - apply Coupon To Cart
  static String apply_cpn_to_cart(String cart_token,String coupon_code,) {
    return '''
            mutation {
                applyCouponToCart(
                  input: {
                    cart_id: $cart_token
                    coupon_code: $coupon_code
                  }
                ) {
                  cart {
                   id
                  items {
                    quantity
                    id
                    uid
                    product {
                      sku
                      uid
                      name
                      dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                           attribute_code
                          attribute_label
                          attribute_value
                    }
                      media_gallery {
                      url
                      label
                      position
                      disabled
                    }
                    }
                  }
                 
                 shipping_addresses {
                    available_shipping_methods {
                      amount {
                        currency
                        value
                      }
                      available
                      carrier_code
                      carrier_title
                      method_code
                      method_title
                      price_excl_tax {
                        value
                        currency
                      }
                      price_incl_tax {
                        value
                        currency
                      }
                    }
                    selected_shipping_method {
                      amount {
                        value
                        currency
                      }
                      carrier_code
                      carrier_title
                      method_code
                      method_title
                    }
                  }
              
                  prices {
                      discounts {
                        label
                        amount {
                          value
                        }
                      }
              
                      subtotal_excluding_tax{
                        value
                        currency
                      }
                      
                      grand_total{
                        value
                        currency
                      }
                    }
                  }
                }
              }
        ''';
  }

  Future<String> apply_coupon_to_cart(String cart_token,String cpn,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(apply_cpn_to_cart(cart_token,cpn)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 8 - II - Remove Coupon code To Cart
  static String rmv_cpn_to_cart(String cart_token) {
    return '''
            mutation {
                mutation {
                    removeCouponFromCart(
                      input:
                        { cart_id: $cart_token }
                      ) {
                      cart {
                         id
                        
                      items {
                        quantity
                      
                        product {
                          sku
                          
                          uid
                          name
                          dynamicAttributes(fields:["oma_collection","oma_subclass"]){
                               attribute_code
                              attribute_label
                              attribute_value
                        }
                          media_gallery {
                          url
                          label
                          position
                          disabled
                        }
                        }
                      }
                     
                     shipping_addresses {
                        available_shipping_methods {
                          amount {
                            currency
                            value
                          }
                          available
                          carrier_code
                          carrier_title
                          method_code
                          method_title
                          price_excl_tax {
                            value
                            currency
                          }
                          price_incl_tax {
                            value
                            currency
                          }
                        }
                        selected_shipping_method {
                          amount {
                            value
                            currency
                          }
                          carrier_code
                          carrier_title
                          method_code
                          method_title
                        }
                      }
                  
                      prices {
                  
                          discounts {
                            label
                            amount {
                              value
                            }
                          }
                  
                  subtotal_excluding_tax{
                            value
                            currency
                          }
                  
                          grand_total{
                            value
                            currency
                          }
                        }
                      }
                    }
                  }
              }
        ''';
  }

  Future<String> remove_coupon_to_cart(String cart_token) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(rmv_cpn_to_cart(cart_token)),
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 9 - I - Available Payment methods
  static String avl_payment_methods(String cart_token,) {
    return '''
            query query {
                cart(cart_id: $cart_token) {
                  available_payment_methods {
                    code
                    title
                  }
                }
              }
        ''';
  }

  Future<String> available_payment_methods(String cart_token,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(avl_payment_methods(cart_token)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 9 - II - Set Payment to Cart
  static String set_paymnt_to_cart(String cart_token,String pay_mode,) {
    return '''
            mutation {
                setPaymentMethodOnCart(input: {
                    cart_id: $cart_token
                    payment_method: {
                        code: "razorpay"
                    }
                }) {
                  cart {
                    selected_payment_method {
                      code
                    }
                  }
                }
              }
        ''';
  }

  Future<String> set_payment_to_cart(String cart_token,String pay_mode,) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(set_paymnt_to_cart(cart_token,pay_mode)), // this
        ),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Step 10  - Place Order
  static String plc_ord(String cart_token) {
    return '''
            mutation {
                placeOrder(input: {cart_id: $cart_token}) {
                  order {
                    order_number
                  }
                }
        ''';
  }

  Future<String> place_order(
      {required String cart_token, required String wishlistItemsIds}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(plc_ord(cart_token)), // this
        ),
      );

      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
        Fluttertoast.showToast(
            msg: result.exception!.graphqlErrors[0].message.toString());
      } else if (result.data != null) {
        log(jsonEncode(result.data));

        EasyLoading.dismiss();
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

}
