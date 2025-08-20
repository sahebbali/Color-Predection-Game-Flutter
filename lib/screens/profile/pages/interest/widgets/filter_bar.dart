import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_history_controller.dart';

class FilterBar extends StatelessWidget {
  final InterestHistoryController controller;

  const FilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Transactions',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          Obx(
            () => DropdownButton<String>(
              value: controller.selectedFilter.value,
              icon: const Icon(Icons.filter_list, color: Colors.deepPurple),
              underline: Container(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.changeFilter(newValue);
                }
              },
              items: <String>['All', 'Credited', 'Pending']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}