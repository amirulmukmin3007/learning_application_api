import 'package:flutter/material.dart';
import 'package:learning_application_api/models/task_models.dart';
import 'package:learning_application_api/utils/components/custom_appbar.dart';
import 'package:learning_application_api/utils/components/custom_listtile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  Map<String, dynamic> result = {};
  String name = '';
  List<dynamic> taskList = [];
  List<dynamic> activeTaskList = [];
  List<dynamic> incompleteTaskList = [];

  @override
  void initState() {
    fetchTasks();
    super.initState();
  }

  void fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    result = await getTasks();
    if (!mounted) return; // Checking if you are still in the same widget
    name = result['user_id'];
    taskList = result['tasks'];
    divideTasks(taskList);
    setState(() {
      isLoading = false;
    });
  }

  void divideTasks(List<dynamic> taskList) {
    taskList.forEach((task) {
      if (task['task_status'] == 'ACTIVE') {
        activeTaskList.add(task);
      } else {
        incompleteTaskList.add(task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: CustomAppBar(title: 'Home'),

      // Main content area - Safe Area
      body: Container(
        color: Color(0xFFFF6D4D),
        child: Stack(
          children: [
            Column(
              children: [
                // Welcome Container with Icon
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome, $name!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.account_circle, color: Colors.black, size: 28),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // TabBar and TabBarView
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          // TabBar
                          Container(
                            padding: EdgeInsets.all(8),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  color: Colors.amber[300]!,
                                  width: 2,
                                ),
                              ),
                              labelColor: Colors.amber[300],
                              unselectedLabelColor: Colors.white,
                              labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              tabs: [
                                Tab(text: 'To Do'),
                                Tab(text: 'Missed'),
                              ],
                            ),
                          ),

                          // TabBarView
                          Expanded(
                            child: TabBarView(
                              children: [
                                // To Do Tab
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: ListView.builder(
                                    itemCount: activeTaskList.length,
                                    itemBuilder: (context, index) {
                                      return TaskItem(
                                        text:
                                            activeTaskList[index]['task_desc'],
                                      );
                                    },
                                  ),
                                ),

                                // Missed Tab
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: ListView.builder(
                                    itemCount: incompleteTaskList.length,
                                    itemBuilder: (context, index) {
                                      return TaskItem(
                                        text:
                                            incompleteTaskList[index]['task_desc'],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
            if (isLoading) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
