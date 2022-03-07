// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

class BillListProvider extends ChangeNotifier {
  final List<Bill> _bills = [];
  bool _fileExists = false;

  Map<String, dynamic> _json = {};
  late String _jsonString;

  List<Bill> get bills => _bills;
  Bill bill(int id) => _bills.firstWhere((e) => e.id == id);

  Map<String, dynamic> _toMap() =>
      {"bills": List<dynamic>.from(_bills.map((x) => x.toMap()))};

  BillListProvider() {
    _readJson();
  }

  Future<void> addBill(String title, List<String> categories) async {
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
    _setDataLocally();
  }

  void deleteBill(Bill bill) {
    _bills.remove(bill);
    notifyListeners();
    _setDataLocally();
  }

  void addEntry(Bill bill, Entry entry) {
    bill.entries.add(entry);
    bill.amount += entry.cost;
    notifyListeners();
    _setDataLocally();
  }

  void deleteEntry(Bill bill, Entry entry) {
    bill.amount -= entry.cost;
    bill.entries.remove(entry);
    notifyListeners();
    _setDataLocally();
  }

  void addContact(Bill bill, Contact con) {
    ContactDetails contact = ContactDetails(
        phone: con.phones == null || con.phones!.isEmpty
            ? ""
            : con.phones!.first.toString(),
        name: con.displayName ?? "No name",
        ratio: 1);
    if (bill.contacts
        .where((element) => element.name == con.displayName)
        .isEmpty) {
      bill.contacts.add(contact);
    }
    notifyListeners();
    _setDataLocally();
  }

  void addImage(Bill bill, String imgPath) {
    bill.images.add(imgPath);
    notifyListeners();
    _setDataLocally();
  }

  void deleteImage(Bill bill, String imgPath) {
    bill.images.remove(imgPath);
    notifyListeners();
    _setDataLocally();
  }

  void deleteContact(Bill bill, ContactDetails contact) {
    bill.contacts.remove(contact);
    notifyListeners();
    _setDataLocally();
  }

  void updateContactRatio(Bill bill, ContactDetails contact, double ratio) {
    // bill.contacts.where((element) => element == contact).first
    contact.ratio = ratio;
    notifyListeners();
    _setDataLocally();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  void _setDataLocally() async {
    final _filePath = await _localFile;

    Map<String, dynamic> _newJson = _toMap();

    _json.addAll(_newJson);
    _jsonString = jsonEncode(_json);

    _filePath.writeAsString(_jsonString);
  }

  void _readJson() async {
    final _filePath = await _localFile;

    _fileExists = await _filePath.exists();
    if (_fileExists) {
      try {
        _jsonString = await _filePath.readAsString();
        _json = jsonDecode(_jsonString);
        _bills.addAll(
            List<Bill>.from(_json["bills"].map((x) => Bill.fromMap(x))));
        for (var bill in _bills) {
          bill.amount = 0;
          for (var entry in bill.entries) {
            bill.amount += entry.cost;
          }
        }
        notifyListeners();
      } catch (e) {
        print('Tried reading _file error: $e');
      }
    }
  }
}
