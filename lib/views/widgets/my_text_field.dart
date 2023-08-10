import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? prefix;
  final IconData suffix;
  final bool password;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool allowLatters;
  final Function(String)? onChanged;
  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.prefix,
      this.password = false,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.allowLatters = true,
      this.onChanged,
      required this.suffix})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      inputFormatters:
          widget.allowLatters ? [] : [FilteringTextInputFormatter.digitsOnly],
      // widget.allowLatters
      //     ? []
      //     : [FilteringTextInputFormatter.allow(RegExp('[0-9.]+'))],
      // onSubmitted: widget.onsubmitted,
      textInputAction: widget.textInputAction,
      obscureText: widget.password ? !obscure : obscure,
      /*default is true the text in these case is hidden */
      decoration: InputDecoration(
        // prefix: Icon(Icons.email),

        prefixIcon: IconData == null ? null : Icon(widget.prefix),
        suffixIcon: widget.password ==
                true /*to determine if there is password icon or null */
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscure = !obscure; //true => put the text shown
                  });
                },
                child: Icon(obscure ? Icons.visibility : Icons.visibility_off))
            : Icon(widget.suffix, size: 30),

        /*suffix take nullable value*/
        // label: Text("Email"),
        // contentPadding: EdgeInsets.zero,
        hintText: widget.hint,

        // hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue)),
        // filled: true,
        // fillColor: Colors.red
      ),
      // autofocus: true,
      // obscureText: true,
      cursorColor: Colors.blue,
      cursorHeight: 30,
      onChanged: widget.onChanged,

      style: const TextStyle(color: Colors.blue),
    );
  }
}
