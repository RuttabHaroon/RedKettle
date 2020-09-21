import 'package:flutter/widgets.dart';

class InvalidTokenNotification extends Notification {

  final bool isTokenExpired;

  const InvalidTokenNotification({this.isTokenExpired});
}