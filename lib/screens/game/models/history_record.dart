import 'package:flutter/material.dart';

class HistoryRecord {
  final String period;
  final int price;
  final int number;
  final Color resultColor;

  HistoryRecord({
    required this.period,
    required this.price,
    required this.number,
    required this.resultColor,
  });
}