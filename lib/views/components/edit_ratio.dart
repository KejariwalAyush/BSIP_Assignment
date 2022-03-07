import 'package:bill_seperator/models/contact_details.dart';
import 'package:bill_seperator/models/models.dart';
import 'package:bill_seperator/providers/bills_provider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRatioButton extends StatefulWidget {
  const EditRatioButton({
    Key? key,
    required this.bill,
    required this.contact,
  }) : super(key: key);
  final Bill bill;
  final ContactDetails contact;

  @override
  State<EditRatioButton> createState() => _EditRatioButtonState();
}

class _EditRatioButtonState extends State<EditRatioButton> {
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
        onPressed: () => editRatio(context),
        icon: const Icon(Icons.edit, size: 16));
  }

  Future<dynamic> editRatio(BuildContext context) {
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
                          decoration:
                              const InputDecoration(label: Text("Ratio")),
                          controller: _ct,
                          keyboardType: TextInputType.text,
                        ),
                        ElevatedButton(
                          child: const Text("Save"),
                          onPressed: () {
                            provider.updateContactRatio(widget.bill,
                                widget.contact, double.parse(_ct.text));
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
