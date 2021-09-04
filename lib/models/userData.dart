import 'package:flutter/foundation.dart';

class UserData {
  int lastVideo;
  // String name;
  // List<String> watchedVideos;

  UserData({@required this.lastVideo});
}

UserData currentUser = UserData(lastVideo: 2);
