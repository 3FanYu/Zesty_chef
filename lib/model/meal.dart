class Meal {
  final int id;
  final String name;
  final int maximumPeople;
  final int minimumPeople;
  final int price;
  final int stars;
  final List<MenuDetail> menuDetails;

  Meal({
    this.id,
    this.name,
    this.maximumPeople,
    this.minimumPeople,
    this.price,
    this.stars,
    this.menuDetails,
  });
}

class MenuDetail {
  final int id;
  final String description;
  final String path;
  final int menuId;

  MenuDetail({
    this.id,
    this.description,
    this.path,
    this.menuId,
  });
  factory MenuDetail.fromJson(Map<String, dynamic> parsedJson) {
    return MenuDetail(
      id: parsedJson['id'],
      description: parsedJson['description'],
      path: parsedJson['path'],
      menuId: parsedJson['menu_id'],
    );
  }
}
