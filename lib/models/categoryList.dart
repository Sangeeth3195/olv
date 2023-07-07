

class CategoryModel {
  Data? data;

  CategoryModel({this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CategoryList>? categoryList;

  Data({this.categoryList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryList != null) {
      data['categoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? childrenCount;
  List<Children>? children;

  CategoryList({this.childrenCount, this.children});

  CategoryList.fromJson(Map<String, dynamic> json) {
    childrenCount = json['children_count'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['children_count'] = childrenCount;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  int? position;
  String? image;
  int? level;
  String? name;
  String? path;
  String? urlPath;
  String? urlKey;
  List<Children>? children;

  Children(
      {this.id,
        this.position,
        this.image,
        this.level,
        this.name,
        this.path,
        this.urlPath,
        this.urlKey,
        this.children});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    image = json['image'];
    level = json['level'];
    name = json['name'];
    path = json['path'];
    urlPath = json['url_path'];
    urlKey = json['url_key'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['image'] = image;
    data['level'] = level;
    data['name'] = name;
    data['path'] = path;
    data['url_path'] = urlPath;
    data['url_key'] = urlKey;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class children {
  int? id;
  int? level;
  String? name;
  String? path;
  String? urlPath;
  String? urlKey;

  children(
      {this.id, this.level, this.name, this.path, this.urlPath, this.urlKey});

  children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    name = json['name'];
    path = json['path'];
    urlPath = json['url_path'];
    urlKey = json['url_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['name'] = name;
    data['path'] = path;
    data['url_path'] = urlPath;
    data['url_key'] = urlKey;
    return data;
  }
}
