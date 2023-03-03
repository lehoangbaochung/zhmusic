import 'package:flutter/material.dart';

class HoriverticalTheme {
  final String name;
  final String backgroundUrl;
  final Color songVoteColor;
  final Color songTextColor;
  final Color infoTextColor;
  final Color playlistTextColor;

  HoriverticalTheme({
    required this.name,
    required this.backgroundUrl,
    this.songVoteColor = Colors.red,
    this.songTextColor = Colors.black,
    this.infoTextColor = Colors.white,
    this.playlistTextColor = Colors.white,
  });
}
