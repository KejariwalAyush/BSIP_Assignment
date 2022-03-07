import 'package:bill_seperator/models/contact_details.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/models.dart';

class BillListProvider extends ChangeNotifier {
  final List<Bill> _bills = [];
  final TextEditingController tec = TextEditingController();

  List<Bill> get bills => _bills;
  Bill bill(int id) => _bills.firstWhere((e) => e.id == id);

  void addBill(String title, List<String> categories) {
    Bill bill = Bill(
      id: _bills.isEmpty ? 0 : _bills.last.id + 1,
      title: title,
      categories: categories,
      contacts: [],
      createdAt: DateTime.now(),
      entries: [],
      images: [],
    );
    _bills.add(bill);
    notifyListeners();
  }

  void deleteBill(Bill bill) {
    _bills.remove(bill);
    notifyListeners();
  }

  void addEntry(Bill bill, Entry entry) {
    bill.entries.add(entry);
    bill.amount += entry.cost;
    notifyListeners();
  }

  void deleteEntry(Bill bill, Entry entry) {
    bill.amount -= entry.cost;
    bill.entries.remove(entry);
    notifyListeners();
  }

  void addContact(Bill bill, Contact con) {
    ContactDetails contact = ContactDetails(
        phone: con.phones == null ? "" : con.phones!.first.toString(),
        name: con.displayName ?? "No name",
        ratio: 1);
    if (bill.contacts
        .where((element) => element.name == con.displayName)
        .isEmpty) {
      bill.contacts.add(contact);
    }
    notifyListeners();
  }

  void deleteContact(Bill bill, ContactDetails contact) {
    bill.contacts.remove(contact);
    notifyListeners();
  }

  void updateContactRatio(Bill bill, ContactDetails contact, double ratio) {
    // bill.contacts.where((element) => element == contact).first
    contact.ratio = ratio;
    notifyListeners();
  }
}
