import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Storage {
  Storage(StreamingSharedPreferences preferences)
      : token = preferences.getString('token', defaultValue: 'b99d61d4-962e-4c52-b1d7-d98b59b9641f'),
        darkMode = preferences.getBool('darkMode', defaultValue: false);

  final Preference<String> token;
  final Preference<bool> darkMode;
}