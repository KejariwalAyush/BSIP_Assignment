import 'package:bill_seperator/models/contact_details.dart';
import 'package:bill_seperator/providers/bills_provider.dart';
import 'package:bill_seperator/views/components/edit_ratio.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'components/add_entry.dart';

class BillDetailPage extends StatelessWidget {
  final Bill bill;
  const BillDetailPage(this.bill, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(bill.title),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("Entries"),
              icon: Icon(Icons.document_scanner),
            ),
            Tab(
              child: Text("Contacts"),
              icon: Icon(Icons.contacts_rounded),
            ),
            Tab(
              child: Text("Images"),
              icon: Icon(Icons.image),
            ),
          ]),
          actions: [
            AddEntryIconButton(bill: bill),
            Consumer<BillListProvider>(builder: (_, provider, __) {
              return IconButton(
                  onPressed: () async {
                    bool isShown =
                        await Permission.contacts.request().isGranted;
                    if (!isShown) {
                      const snackBar = SnackBar(
                        content:
                            Text('Error getting permisson of contacts list'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    List<Contact> contacts = await ContactsService.getContacts(
                        withThumbnails: false);
                    Contact contact = await dropdownDialog(context, contacts);
                    provider.addContact(bill, contact);
                  },
                  icon: const Icon(Icons.person_add));
            }),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo))
          ],
        ),
        body: Consumer<BillListProvider>(builder: (context, provider, __) {
          return TabBarView(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.bill(bill.id).entries.length,
                      itemBuilder: (context, index) {
                        Entry entry = provider.bill(bill.id).entries[index];
                        return Dismissible(
                          key: Key(entry.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.all(8.0),
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete_rounded)),
                          ),
                          onDismissed: (dir) =>
                              provider.deleteEntry(bill, entry),
                          child: ListTile(
                            title: Text(entry.title),
                            subtitle: Text("Qty: ${entry.quantity}"),
                            trailing: Text(entry.cost.toStringAsFixed(2)),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.blue.withOpacity(0.3),
                    padding: const EdgeInsets.all(3.0),
                    child: ListTile(
                        trailing: Text("Total: " +
                            provider.bill(bill.id).amount.toStringAsFixed(2))),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.bill(bill.id).contacts.length,
                      itemBuilder: (context, index) {
                        ContactDetails contact =
                            provider.bill(bill.id).contacts[index];
                        return Dismissible(
                          key: Key(contact.name),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.all(8.0),
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete_rounded)),
                          ),
                          onDismissed: (dir) =>
                              provider.deleteContact(bill, contact),
                          child: ListTile(
                            title: Text(
                              contact.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: [
                                Text("Ratio: " +
                                    contact.ratio.toStringAsFixed(1)),
                                // const SizedBox(width: 2),
                                EditRatioButton(bill: bill, contact: contact),
                              ],
                            ),
                            trailing: Text((provider.bill(bill.id).amount *
                                    (contact.ratio /
                                        provider.bill(bill.id).getRatioTotal()))
                                .toStringAsFixed(2)),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.blue.withOpacity(0.3),
                    padding: const EdgeInsets.all(3.0),
                    child: ListTile(
                        trailing: Text("Total: " +
                            provider.bill(bill.id).amount.toStringAsFixed(2))),
                  ),
                ],
              ),
              Column(
                children: const [],
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<Contact> dropdownDialog(
    BuildContext context,
    List<Contact> contacts,
  ) async {
    Contact choice = contacts.first;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text("Choose Contact"),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DropdownButton<Contact>(
              hint: const Text("--"),
              value: choice,
              items: contacts
                  .map((value) {
                    return DropdownMenuItem<Contact>(
                      value: value,
                      child: Text(value.displayName.toString()),
                    );
                  })
                  .toSet()
                  .toList(),
              onChanged: (value) {
                setState(() {
                  choice = value!;
                });
              },
            );
          }),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Ok",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
    return choice;
  }
}
