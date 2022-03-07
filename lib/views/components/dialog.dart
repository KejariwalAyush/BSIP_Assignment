// import 'package:flutter/material.dart';

// class DialogExample extends StatefulWidget {
//   const DialogExample({Key? key}) : super(key: key);


//   @override
//   _DialogExampleState createState() => _DialogExampleState();
// }

// class _DialogExampleState extends State<DialogExample> {
//   String _text = "Title";
//   late TextEditingController _c;
//   @override
//   initState(){
//     _c = TextEditingController();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(_text),
//             ElevatedButton(onPressed: () {
//               addTitle(context);
//             },child: Text("Show Dialog"),)
//           ],
//         )
//       ),
//     );
//   }

// }