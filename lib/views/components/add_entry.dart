import 'package:bill_seperator/providers/bills_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';

class AddEntryIconButton extends StatefulWidget {
  const AddEntryIconButton({
    Key? key,
    required this.bill,
  }) : super(key: key);

  final Bill bill;

  @override
  State<AddEntryIconButton> createState() => _AddEntryIconButtonState();
}

class _AddEntryIconButtonState extends State<AddEntryIconButton> {
  // String _text = "Title";
  // double cost = 0;
  // int quantity = 1;
  late TextEditingController _ct;
  late TextEditingController _cc;
  late TextEditingController _cq;
  @override
  initState() {
    _ct = TextEditingController();
    _cc = TextEditingController(text: "0");
    _cq = TextEditingController(text: "1");
    super.initState();
  }

  @override
  void dispose() {
    _ct.dispose();
    _cc.dispose();
    _cq.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => addTitle(context, widget.bill),
        icon: const Icon(Icons.add));
  }

  Future<dynamic> addTitle(BuildContext context, Bill bill) {
    return showDialog(
        builder: (context) => Dialog(
              child: Consumer<BillListProvider>(builder: (_, provider, __) {
                return Container(
                  height: 400,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(
                              hintText: "Title", label: Text("Title")),
                          controller: _ct,
                          keyboardType: TextInputType.name,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Cost"),
                          ),
                          controller: _cc,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Quantity"),
                          ),
                          controller: _cq,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                        ),
                        ElevatedButton(
                          child: const Text("Save"),
                          onPressed: () {
                            if (_ct.text.trim() == "" || _cc.text == "") {
                              Navigator.pop(context);
                              return;
                            }
                            int qty =
                                int.parse(_cq.text == "" ? "1" : _cq.text);
                            Entry entry = Entry(
                                id: provider.bill(bill.id).entries.isEmpty
                                    ? 0
                                    : provider.bill(bill.id).entries.last.id +
                                        1,
                                title: _ct.text,
                                cost: double.parse(_cc.text) * qty,
                                quantity: qty);
                            provider.addEntry(bill, entry);
                            _ct.clear();
                            _cc.clear();
                            _cq.clear();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
        context: context);
  }
}
