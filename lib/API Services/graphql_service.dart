import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:omaliving/LoginPage.dart';
import 'package:omaliving/models/CountryModel.dart';
import 'package:omaliving/models/CustomerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainLayout.dart';
import '../models/OrderModel.dart';
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
                      category_id: {eq: "${id}"}
                      material: {in: [] }
                      color:{in: []}
                      brands:{in:[]}
                      oma_collection:{in:[]}
                      oma_subclass:{in:[]}
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
                    products(filter: { sku: { eq: "${id}" } }) {
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

  /// Wishlist
  Future<List<dynamic>> getWishlist() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           query Query {
                wishlist {
                  items_count
                  name
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
                    }
                  }
                }
              }
            """),
        ),
      );

      if (result.hasException) {
        print(result.exception);
        throw Exception(result.exception);
      } else {
        List? res = result.data?['wishlist']['items'];

        if (res == null || res.isEmpty) {
          return [];
        }
        return res;
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  /// create new user
  static String new_user(String firstname, String lastname, String email,
      String password, bool isSubcribed) {
    return '''
            mutation {
              createCustomerV2(
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

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainLayout()));

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

  /// reset password
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
      region: "${region}"
      region_code: "${regioncode}"
      region_id: "${regionId}"
    }
    country_code: $countryCode
    street: ["${address}"]
    telephone: "${phNo}"
    postcode: "${postalCode}"
    city: "${city}"
    firstname: "${firstname}"
    lastname: "${lastname}"
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
              isSubcribed: true,
              countryCode: countryCode,
              region: region,
              regioncode: regioncode,
              regionId: regionId,
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
      bool? isSubcribed,
      bool? isSubcribed1,
      required String id}) {
    return '''
            mutation {
            
              updateCustomerAddress(
                              id: ${id}
                                input: {
                                  region: {
                      region: "${region}"
                      region_code: "${regioncode}"
                      region_id: "${regionId}"
                    }
                    country_code: $countryCode
                    street: ["${address}"]
                    telephone: "${phNo}"
                    postcode: "${postalCode}"
                    city: "${city}"
                    firstname: "${firstname}"
                    lastname: "${lastname}"
                    default_shipping: "${isSubcribed}"
                    default_billing: "${isSubcribed1}"
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
              updateCustomerV2(
                  input: {
                    firstname: "$firstname"
                    lastname: "${lastname}"
                    is_subscribed: ${isSubscribed ?? false}
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
              firstname: firstname, lastname: lastname, email: email)), // this
        ),
      );
      log(update_customer_details(
              firstname: firstname, lastname: lastname, email: email)
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
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        log(jsonEncode(result.data));
        print(result.data?['customer']['addresses']);
        return CustomerModel.fromJson(result.data!);
      }

      return CustomerModel();
    } catch (e) {
      print(e);
      return CustomerModel();
    }
  }

  /// Create Cart
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
        print(result.data?['customerCart']);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Create Cart Non logged In
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

  /// add Product to Cart
  static String add_prd_to_cart() {
    return '''
            mutation {
                addSimpleProductsToCart(
                  input: {
                    cart_id: 'token'
                    cart_items: [
                      {
                        data: {
                          quantity: 1
                          sku: "24-MB04"
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
                  }
                }
              }
        ''';
  }

  Future<String> add_product_to_cart() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(add_prd_to_cart()), // this
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

  /// Update Product to Cart
  static String upt_prd_to_cart() {
    return '''
            mutation {
                addSimpleProductsToCart(
                  input: {
                    cart_id: 'token'
                    cart_items: [
                      {
                        data: {
                          quantity: 1
                          sku: "24-MB04"
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
                  }
                }
              }
        ''';
  }

  Future<String> update_product_to_cart() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(upt_prd_to_cart()), // this
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

  /// Set Shipping Address On Cart
  static String set_shipping_add_to_cart() {
    return '''
            mutation {
                addSimpleProductsToCart(
                  input: {
                    cart_id: 'token'
                    cart_items: [
                      {
                        data: {
                          quantity: 1
                          sku: "24-MB04"
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
                  }
                }
              }
        ''';
  }

  Future<String> set_shipping_address_to_cart() async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(upt_prd_to_cart()), // this
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
  Future<OrdersModel> getorderdetails({
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
      } else if (result.data != null) {
        // log(jsonEncode(result.data));
        print(result.data?['customer']['orders']['items']);
        return OrdersModel.fromJson(result.data!);
      }

      return OrdersModel();
    } catch (e) {
      print(e);
      return OrdersModel();
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainLayout()),
            (Route<dynamic> route) => false);

        Fluttertoast.showToast(msg: 'Logout successfully');
      }
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
        throw Exception(result.exception);
      } else {
        return result;
      }
    } catch (error) {
      return [];
    }
  }

  /// subscribe to news letter
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

  Future<String> subscribenewsletter(String email) async {
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
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }

  /// Unsubscribe to news letter
  Future<Object> unsubscribenewsletter(String value) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
           mutation {
              unsubscribeEmailToNewsletter(email: "$value") {
                status
              }
            }
            """),
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return result;
      }
    } catch (error) {
      return [];
    }
  }
}
