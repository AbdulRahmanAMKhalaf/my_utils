import 'package:flutter/cupertino.dart';


class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({super.key, this.width = 2});

  final double width;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * (width / 100),
    );
  }
}
