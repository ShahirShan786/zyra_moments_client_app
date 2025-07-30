class CategoryModel {
  final bool success;
  final List<Categories> categories;

  CategoryModel({
    required this.success,
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      success: json['success'],
      categories: List<Categories>.from(
        json['categories'].map((x) => Categories.fromJson(x)),
      ),
    );
  }
}

class Categories {
  final String id;
  final String categoryId;
  final bool status;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  Categories({
    required this.id,
    required this.categoryId,
    required this.status,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      categoryId: json['categoryId'],
      status: json['status'],
      title: json['title'].trim(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
