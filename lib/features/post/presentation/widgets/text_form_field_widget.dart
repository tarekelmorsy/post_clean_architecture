import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.multiLines,
    required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: (val)=>
        val!.isEmpty?"$name can't be Empty":null,
        decoration: InputDecoration(hintText: "$name"),
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
      ),);
  }
}
