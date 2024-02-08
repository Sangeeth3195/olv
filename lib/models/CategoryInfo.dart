// To parse this JSON data, do
//
//     final categoryInfo = categoryInfoFromJson(jsonString);

import 'dart:convert';

CategoryInfo categoryInfoFromJson(String str) => CategoryInfo.fromJson(json.decode(str));

String categoryInfoToJson(CategoryInfo data) => json.encode(data.toJson());

class CategoryInfo {
  String? typename;
  Category? category;

  CategoryInfo({
    this.typename,
    this.category,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
    typename: json["__typename"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "category": category?.toJson(),
  };
}

class Category {
  String? typename;
  int? id;
  int? level;
  String? name;
  Products? products;
  String? childrenCount;
  List<dynamic>? children;

  Category({
    this.typename,
    this.id,
    this.level,
    this.name,
    this.products,
    this.childrenCount,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    typename: json["__typename"],
    id: json["id"],
    level: json["level"],
    name: json["name"],
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
    childrenCount: json["children_count"],
    children: json["children"] == null ? [] : List<dynamic>.from(json["children"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "level": level,
    "name": name,
    "products": products?.toJson(),
    "children_count": childrenCount,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
  };
}

class Products {
  String? typename;
  int? totalCount;
  PageInfo? pageInfo;

  Products({
    this.typename,
    this.totalCount,
    this.pageInfo,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    typename: json["__typename"],
    totalCount: json["total_count"],
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "total_count": totalCount,
    "page_info": pageInfo?.toJson(),
  };
}

class PageInfo {
  String? typename;
  int? currentPage;
  int? pageSize;

  PageInfo({
    this.typename,
    this.currentPage,
    this.pageSize,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    typename: json["__typename"],
    currentPage: json["current_page"],
    pageSize: json["page_size"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "current_page": currentPage,
    "page_size": pageSize,
  };
}
