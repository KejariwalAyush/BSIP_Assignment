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
}
