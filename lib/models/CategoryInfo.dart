
import 'dart:convert';

CategoryInfo categoryInfoFromJson(String str) => CategoryInfo.fromJson(json.decode(str));

String categoryInfoToJson(CategoryInfo data) => json.encode(data.toJson());

class CategoryInfo {
  String? typename;
  List<Category>? getCategoryinfoData;

  CategoryInfo({
     this.typename,
     this.getCategoryinfoData,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
    typename: json["__typename"],
    getCategoryinfoData: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": getCategoryinfoData == null ? [] : List<dynamic>.from(getCategoryinfoData!.map((x) => x.toJson())),
  };
}

class Category {
  int id;
  int level;
  String name;
  Products products;

  Category({
    required this.id,
    required this.level,
    required this.name,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    level: json["level"],
    name: json["name"],
    products: Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level": level,
    "name": name,
    "products": products.toJson(),
  };
}

class Products {
  int totalCount;

  Products({
    required this.totalCount,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
  };
}
