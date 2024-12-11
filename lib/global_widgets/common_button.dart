import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  CommonButton({super.key, this.functionality, required this.content});
  String content;
  Function()? functionality;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: functionality,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text("$content"),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1)),
      ),
    );
  }
}
