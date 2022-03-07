import 'package:bill_seperator/models/entry.dart';
import 'package:contacts_service/contacts_service.dart';

class Bill {
  final int id;
  final String title;
  double amount = 0.0;
  late final Map<Contact, double> contacts;
  late final DateTime createdAt;
  late final List<Entry> entries;

  Bill({
    required this.id,
    required this.title,
  }) {
    createdAt = DateTime.now();
    entries = [];
    contacts = {};
  }

  double getRatioTotal() {
    double cnt = 0;
    for (var val in contacts.values) {
      cnt += val;
    }
    return cnt;
  }
}
