import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';
import 'package:video_player/video_player.dart';

import '/pages/horizontal/horizontal_page.dart';

part 'main_cubit.dart';
part 'main_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HorizontalCubit(),
      child: const HorizontalPage(),
    );
  }
}
