import 'package:flutter/material.dart';

class TestFieldEdit extends StatelessWidget {
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;

  const TestFieldEdit(
      {Key? key,
      required this.mycontroller,
      required this.valid,
      required this.isNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: TextFormField(
                keyboardType: isNumber
                    ? const TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
                validator: valid,
                controller: mycontroller,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                )),
          ),
        ],
      ),
    );
  }
}
