import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class My_Container extends StatefulWidget {
  final String text;
  final bool? isSmall;
  final Function()? function;
  const My_Container(
      {super.key, required this.text, this.function, this.isSmall = false});

  @override
  State<My_Container> createState() => _My_ContainerState();
}

class _My_ContainerState extends State<My_Container> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(widget.isSmall == false ? 4 : 12),
        decoration: BoxDecoration(
            color: const Color(0xffFFD465),
            borderRadius:
                BorderRadius.circular(widget.isSmall == false ? 8.r : 16.r)),
        child: Text(widget.text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
