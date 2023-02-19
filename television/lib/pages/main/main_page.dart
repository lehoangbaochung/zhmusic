import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horivertical/horivertical_page.dart';

part 'main_cubit.dart';
part 'main_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: HoriverticalState.initial(audioOnly: true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocProvider(
                child: const HoriverticalPage(),
                create: (_) => HoriverticalCubit(snapshot.requireData),
              );
            }
            return centeredLoadingIndicator;
          },
        ),
      );
  }
}
