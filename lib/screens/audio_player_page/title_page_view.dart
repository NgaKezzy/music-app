import 'package:flutter/material.dart';

class TitlePageView extends StatelessWidget {
  const TitlePageView(
      {super.key,
      required this.title,
      required this.widthFirst,
      required this.widthLast});
  final String title;
  final double widthFirst;
  final double widthLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widthFirst,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: widthLast,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
