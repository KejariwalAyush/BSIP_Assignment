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
                    title: Text(bill.title),
                    subtitle:
                        Text(DateFormat.yMMMMEEEEd().format(bill.createdAt)),
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

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int i = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Bill Splitter"),
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             i++;
//             setState(() {
//               Bill bill = Bill(title: "$i");
//               billList.addBill(bill);
//               bill.addEntry(Entry(cost: 5000, quantity: 2, title: "Resturant"));
//               bill.addEntry(Entry(cost: 1000, title: "Resturant"));
//             });
//           },
//           child: const Icon(Icons.add)),
//       body: ListView.builder(
//         itemCount: billList._bills.length,
//         itemBuilder: (context, index) {
//           Bill bill = billList._bills[index];
//           return Dismissible(
//             key: Key(bill.title),
//             direction: DismissDirection.endToStart,
//             background: Container(
//               color: Colors.red,
//               padding: const EdgeInsets.all(8.0),
//               child: const Align(
//                   alignment: Alignment.centerRight,
//                   child: Icon(Icons.delete_rounded)),
//             ),
//             onDismissed: (dir) {
//               billList.deleteBill(bill);
//               setState(() {});
//             },
//             child: ListTile(
//               onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => BillDetailPage(bill),
//               )),
//               title: Text(bill.title),
//               subtitle: Text(DateFormat.yMEd().format(bill.createdAt)),
//               trailing: Text(bill.amount.toStringAsFixed(2)),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
