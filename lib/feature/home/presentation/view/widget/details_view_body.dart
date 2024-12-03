import 'package:flutter/material.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailsViewBody extends StatefulWidget {
  const DetailsViewBody({super.key});

  @override
  State<DetailsViewBody> createState() => _DetailsViewBodyState();
}

class _DetailsViewBodyState extends State<DetailsViewBody> {
  List<Map<String, dynamic>> tasks = [
    {"title": "المهمة الأولى", "completed": false},
    {"title": "المهمة الثانية", "completed": false},
    {"title": "المهمة الثالثة", "completed": false},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                tasks[index]['completed'] = !tasks[index]['completed'];
              });
            },
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isLast: index == tasks.length - 1,
              indicatorStyle: IndicatorStyle(
                indicator: const CircleAvatar(
                  child: Text("1"),
                ),
                width: 30,
                color: task['completed'] ? Colors.green : Colors.grey,
                padding: const EdgeInsets.all(8),
              ),
              beforeLineStyle: const LineStyle(
                thickness: 2,
                color: Colors.blue,
              ),
              endChild: Container(
                padding: const EdgeInsets.all(16),
                color: task['completed']
                    ? Colors.green.shade100
                    : Colors.grey.shade200,
                child: Text(
                  task['title'],
                  style: TextStyle(
                    fontSize: 16,
                    color: task['completed'] ? Colors.green : Colors.black,
                    decoration:
                        task['completed'] ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
