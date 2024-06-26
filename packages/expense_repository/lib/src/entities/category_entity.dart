class CategoryEntity {
  String categoryId;
  String name;
  int totalExpenses;
  String icon;
  String color;

  CategoryEntity(
      {required this.categoryId,
      required this.name,
      required this.totalExpenses,
      required this.icon,
      required this.color});

  Map<String, Object?> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      "totalExpenses": totalExpenses,
      "icon": icon,
      'color': color
    };
  }

  factory CategoryEntity.fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
        categoryId: doc['categoryId'],
        name: doc['name'],
        totalExpenses: doc['totalExpenses'],
        icon: doc['icon'],
        color: doc['color']);
  }
}
