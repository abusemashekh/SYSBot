import 'package:flutter/material.dart';

Widget progressBar({required double percentage, required Color bgClr, required Color fillClr}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Container(
      height: 7.5,
      width: double.infinity,
      color: bgClr,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: (percentage.clamp(0, 100)) / 100,
        child: Container(
          decoration: BoxDecoration(
            color: fillClr, // fill color
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
  );
}
