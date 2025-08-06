import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../models/history_record.dart';

class HistoryTable extends GetView<GameController> {
  const HistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.emoji_events_outlined),
              SizedBox(width: 8),
              Text(
                'Bcone Record',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildHeader(),
          const Divider(height: 1),
          Obx(
            () => ListView.separated(
              itemCount: controller.historyRecords.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _buildRow(controller.historyRecords[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: const Row(
        children: [
          Expanded(flex: 3, child: Center(child: Text('Period'))),
          Expanded(flex: 2, child: Center(child: Text('Price'))),
          Expanded(flex: 2, child: Center(child: Text('Number'))),
          Expanded(flex: 2, child: Center(child: Text('Result'))),
        ],
      ),
    );
  }

  Widget _buildRow(HistoryRecord record) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Center(child: Text(record.period))),
          Expanded(flex: 2, child: Center(child: Text(record.price.toString()))),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                record.number.toString(),
                style: TextStyle(
                    color: record.resultColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: record.resultColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}