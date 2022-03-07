class Entry {
  final int id;
  final String title;
  final double cost;
  final int quantity;

  Entry(
      {required this.id,
      required this.title,
      required this.cost,
      this.quantity = 1});

  factory Entry.fromMap(Map<String, dynamic> json) => Entry(
        id: json["id"],
        title: json["title"],
        cost: json["cost"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "cost": cost,
        "quantity": quantity,
      };
}
