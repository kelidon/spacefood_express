import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get shadowed => copyWith(
        shadows: [
          BoxShadow(
              color: color ?? Colors.white, blurRadius: 5, spreadRadius: 0),
        ],
      );
}
