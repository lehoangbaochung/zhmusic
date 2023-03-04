import 'package:flutter/material.dart';

class HoriverticalTheme {
  final String name;
  final String backgroundUrl;
  final Color songVoteColor;
  final Color songTextColor;
  final Color infoTextColor;
  final Color playlistTextColor;

  HoriverticalTheme._({
    required this.name,
    required this.backgroundUrl,
    required this.songVoteColor,
    required this.songTextColor,
    required this.infoTextColor,
    required this.playlistTextColor,
  });

  factory HoriverticalTheme.initial() {
    return HoriverticalTheme._(
      name: 'Mặc định',
      songVoteColor: Colors.red,
      songTextColor: Colors.white,
      infoTextColor: Colors.white,
      playlistTextColor: Colors.white,
      backgroundUrl: 'https://static.vecteezy.com/system/resources/previews/002/058/477/original/floral-nature-spring-background-free-vector.jpg',
    );
  }
}
