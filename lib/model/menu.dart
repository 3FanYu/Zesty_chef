class Menu {
  final int id;
  final String name;
  // final int maximumPeople;
  // final int minimumPeople;
  final int price;
  final int stars;
  // final List<MenuDetail> menuDetails;
  final String img;

  Menu({
    this.id,
    this.name,
    this.price,
    this.stars,
    this.img,
  });
  factory Menu.fromJson(Map<String, dynamic> parsedJson) {
    return Menu(
      id: parsedJson['id'],
      name: parsedJson['name'],
      // maximumPeople: parsedJson['maximum_people'],
      // minimumPeople: parsedJson['minimum_people'],
      price: parsedJson['price'],
      stars: parsedJson['stars'],
      img: parsedJson['path'],
    );
  }
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
