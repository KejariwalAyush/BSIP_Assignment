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
    // Bill bill = _bills.where((element) => element.id == id).first;
    _bills.remove(bill);
    notifyListeners();
  }

  void addEntry(Bill bill, Entry entry) {
    bill.entries.add(entry);
    bill.amount += entry.cost;
    notifyListeners();
  }

  void removeEntry(Bill bill, Entry entry) {
    bill.amount -= entry.cost;
    bill.entries.remove(entry);
    notifyListeners();
  }

  void addContacts(Bill bill, List<Contact> phoneContacts) {
    for (var con in phoneContacts) {
      bill.contacts.putIfAbsent(con, () => 1);
    }
    notifyListeners();
  }

  void deleteContacts(Bill bill, Contact contact) {
    bill.contacts.remove(contact);
    notifyListeners();
  }

  void updateContactRatio(Bill bill, Contact contact, double ratio) {
    bill.contacts.update(contact, (value) => ratio);
    notifyListeners();
  }
}
