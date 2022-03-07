import 'package:bill_seperator/models/models.dart';
import 'package:bill_seperator/providers/bills_provider.dart';
import 'package:bill_seperator/views/bill_detail_page.dart';
import 'package:bill_seperator/views/components/add_bill.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bill Splitter"),
          actions: const [
            AddBillIconButton(),
          ],
        ),
        body: Consumer<BillListProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.bills.length,
              itemBuilder: (context, index) {
                Bill bill = provider.bills[index];
                return Dismissible(
                  key: Key(bill.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete_rounded)),
                  ),
                  onDismissed: (dir) {
                    provider.deleteBill(bill);
                  },
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BillDetailPage(bill),
                    )),
                    title: Text(
                      bill.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMEEEEd().format(bill.createdAt)),
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            for (String label in bill.categories)
                              if (label.trim() != "") Chip(label: Text(label)),
                          ],
                        )
                      ],
                    ),
                    trailing: Text(bill.amount.toStringAsFixed(2)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
