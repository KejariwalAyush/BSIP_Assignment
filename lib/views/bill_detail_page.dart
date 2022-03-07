import 'package:bill_seperator/providers/bills_provider.dart';
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(bill.title),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("Entries"),
              icon: Icon(Icons.document_scanner),
            ),
            Tab(
              child: Text("Contacts"),
              icon: Icon(Icons.contacts_rounded),
            )
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
                    provider.addContacts(bill, contacts);
                  },
                  icon: const Icon(Icons.person_add));
            }),
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
                        return ListTile(
                          title: Text(entry.title),
                          subtitle: Text("Qty: ${entry.quantity}"),
                          trailing: Text(entry.cost.toStringAsFixed(2)),
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
                        MapEntry<Contact, double> contact = provider
                            .bill(bill.id)
                            .contacts
                            .entries
                            .elementAt(index);
                        return ListTile(
                          title: Text(contact.key.displayName ?? "No Name"),
                          subtitle: Text(contact.value.toStringAsFixed(1)),
                          trailing: Text((provider.bill(bill.id).amount *
                                  (contact.value /
                                      provider.bill(bill.id).contacts.length))
                              .toStringAsFixed(2)),
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
            ],
          );
        }),
      ),
    );
  }
}
