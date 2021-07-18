// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';

void main() async {
  var baidu = "http://www.baidu.com";
  var httpClient = HttpClient();
  // Step 1: get HttpClientRequest
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(baidu));
  // Step2: get HttpClientResponse
  HttpClientResponse response = await request.close();
  // Step3: consume HttpClientResponse
  var responseBody = await response.transform(Utf8Decoder()).join();
  print(responseBody);
// Step4: close connection.
  httpClient.close();
}

