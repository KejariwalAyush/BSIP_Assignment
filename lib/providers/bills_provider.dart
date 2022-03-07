import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/models.dart';

class BillListProvider extends ChangeNotifier {
  final List<Bill> _bills = [];
  final TextEditingController tec = TextEditingController();

  List<Bill> get bills => _bills;
  Bill bill(int id) => _bills.firstWhere((e) => e.id == id);

  void addBill(String title) {
    Bill bill = Bill(id: _bills.isEmpty ? 0 : _bills.last.id + 1, title: title);
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
    if (!bill.contacts.keys.any((ele) => ele.displayName == con.displayName)) {
      bill.contacts.putIfAbsent(con, () => 1);
    }
    notifyListeners();
  }

  void deleteContact(Bill bill, Contact contact) {
    bill.contacts.remove(contact);
    notifyListeners();
  }

  void updateContactRatio(Bill bill, Contact contact, double ratio) {
    bill.contacts.update(contact, (value) => ratio);
    notifyListeners();
  }
}
