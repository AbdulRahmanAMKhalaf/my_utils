
import 'package:flutter/cupertino.dart';
// ...existing code...

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({super.key,this.height=2});
  final double height;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * (height / 100),
    );
  }
}
