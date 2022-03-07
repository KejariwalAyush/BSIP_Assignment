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
  late TextEditingController _ct;
  late TextEditingController _cc;
  @override
  initState() {
    _ct = TextEditingController();
    _cc = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _ct.dispose();
    _cc.dispose();
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
                        TextField(
                          decoration: const InputDecoration(
                              hintText: "Sepecate by ','",
                              label: Text("Categories")),
                          controller: _cc,
                          keyboardType: TextInputType.text,
                        ),
                        ElevatedButton(
                          child: const Text("Add Bill"),
                          onPressed: () {
                            if (_ct.text.trim() == "") {
                              Navigator.pop(context);
                              return;
                            }
                            provider.addBill(_ct.text, _cc.text.split(","));
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
