import 'package:flutter/material.dart';
import 'package:scorecheck/presentation/typography.dart';

class DetailsRowWidget extends StatelessWidget {
  final String leftStats;
  final String centerInfo;
  final String rightStats;
  final TextStyle? valueStyle;

  DetailsRowWidget({
    required this.leftStats,
    required this.centerInfo,
    required this.rightStats,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left
          Expanded(
            child: Text(
              leftStats,
              style: valueStyle ?? AppTypography.basicStyle,
            ),
          ),
          
          // Center
          Container(
            alignment: Alignment.center,
            child: Text(
              centerInfo,
              style: valueStyle ?? AppTypography.boldStyle,
            ),
          ),
          
          // Right
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                rightStats,
                style: valueStyle ?? AppTypography.basicStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
