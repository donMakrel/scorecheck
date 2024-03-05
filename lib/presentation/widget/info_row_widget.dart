import 'package:flutter/material.dart';
import 'package:scorecheck/presentation/typography.dart';

class InfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  InfoRowWidget({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.greyKarla,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: valueStyle ?? AppTypography.basicStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
