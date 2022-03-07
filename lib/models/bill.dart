import 'package:bill_seperator/models/contact_details.dart';
import 'package:bill_seperator/models/entry.dart';

class Bill {
  final int id;
  final String title;
  double amount = 0.0;
  final List<ContactDetails> contacts;
  final DateTime createdAt;
  final List<Entry> entries;
  List<String> categories;
  List<String> images;

  Bill({
    required this.id,
    required this.title,
    required this.categories,
    required this.contacts,
    required this.createdAt,
    required this.entries,
    required this.images,
  });

  double getRatioTotal() {
    double cnt = 0;
    for (var val in contacts) {
      cnt += val.ratio;
    }
    return cnt;
  }

  factory Bill.fromMap(Map<String, dynamic> json) => Bill(
        id: json["id"],
        title: json["title"],
        contacts: List<ContactDetails>.from(
            json["contacts"].map((x) => ContactDetails.fromMap(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        entries: List<Entry>.from(json["entries"].map((x) => Entry.fromMap(x))),
        categories: List<String>.from(json["categories"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "amount": amount,
        "contacts": List<dynamic>.from(contacts.map((x) => x.toMap())),
        "createdAt": createdAt.toIso8601String(),
        "entries": List<dynamic>.from(entries.map((x) => x.toMap())),
        "categories": List<String>.from(categories.map((x) => x)),
        "images": List<String>.from(images.map((x) => x)),
      };
}
