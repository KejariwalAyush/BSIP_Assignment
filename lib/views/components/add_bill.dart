import 'package:bill_seperator/providers/bills_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBillIconButton extends StatefulWidget {
  const AddBillIconButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBillIconButton> createState() => _AddBillIconButtonState();
}

class _AddBillIconButtonState extends State<AddBillIconButton> {
  // String _text = "Title";
  // double cost = 0;
  // int quantity = 1;
  late TextEditingController _ct;
  @override
  initState() {
    _ct = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => addTitle(context), icon: const Icon(Icons.add));
  }

  Future<dynamic> addTitle(BuildContext context) {
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
                          keyboardType: TextInputType.text,
                        ),
                        ElevatedButton(
                          child: const Text("Add Bill"),
                          onPressed: () {
                            provider.addBill(_ct.text);
                            _ct.clear();
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
