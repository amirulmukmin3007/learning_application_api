import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_application_api/utils/route/api.dart';

Future<Map<String, dynamic>> getTasks() async {
  try {
    final response = await http.get(Uri.parse(Api.getTaskDataSteven));
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {};
    }
  } catch (e) {
    print(e);
    return {};
  }
}
