import 'package:flutter/material.dart';
import 'package:rhd_todolist/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? ontap;
  const MyButton({Key? key, required this.label, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  
                ),
              ),
            ),
      ),
    );
  }
}
