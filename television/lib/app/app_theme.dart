import 'package:flutter/material.dart';

class HoriverticalTheme {
  final String name;
  final String backgroundUrl;
  final Color songVoteColor;
  final Color songTextColor;
  final Color playlistTextColor;

  HoriverticalTheme({
    required this.name,
    required this.backgroundUrl,
    this.songVoteColor = Colors.red,
    this.songTextColor = Colors.green,
    this.playlistTextColor = Colors.green,
  });
}
