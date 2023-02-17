import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';

import '/pages/horizontal/horizontal_page.dart';

part 'horivertical_cubit.dart';
part 'horivertical_state.dart';

class HoriverticalPage extends StatelessWidget {
  const HoriverticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoriverticalCubit, HoriverticalState>(
      builder: (context, state) {
        return BlocProvider(
          create: (_) => HorizontalCubit(),
          child: const HorizontalPage(),
        );
      },
    );
  }
}
