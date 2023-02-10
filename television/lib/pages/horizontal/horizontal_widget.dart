import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

import '/pages/main/main_page.dart';

part '../../widgets/horizontal/horizontal_icon_button.dart';
part '../../widgets/horizontal/horizontal_playing_song.dart';
part '../../widgets/horizontal/horizontal_playlist_dialog.dart';
part '../../widgets/horizontal/horizontal_playlist_marquee.dart';
part '../../widgets/horizontal/horizontal_song_dialog.dart';
part '../../widgets/horizontal/horizontal_song_tile.dart';

extension HorizontalWidgetX on BuildContext {
  double get songBarHeight => MediaQuery.of(this).size.height * 0.18;
}

const songTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
);

const marqueeTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
);
