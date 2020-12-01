class Order {
  final String name;
  final int id;
  final String datetime;
  final String address;
  final int count;
  final int price;
  final String postScript;
  final int status;
  final int menuId;
  final String path;
  final int star;
  Order({
    this.name,
    this.id,
    this.datetime,
    this.address,
    this.count,
    this.price,
    this.postScript,
    this.status,
    this.menuId,
    this.path,
    this.star,
  });
  factory Order.fromJson(dynamic data) {
    return Order(
      name: data['name'],
      id: data['id'],
      datetime: data['datetime'],
      address: data['address'],
      count: data['count'],
      price: data['price'],
      postScript: data['postscript'],
      status: data['status'],
      menuId: data['menu_id'],
      path: data['path'],
      star: data['stars'],
    );
  }
}
