import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_application_api/utils/route/api.dart';

Future<Map<String, dynamic>> getTasks() async {
  try {
    final response = await http
        .get(Uri.parse(Api.getTaskDataEmma))
        .timeout(Duration(seconds: 5));

    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'success': false, 'error': 'Server error'};
    }
  } on TimeoutException {
    return {'success': false, 'error': 'Request timed out'};
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
