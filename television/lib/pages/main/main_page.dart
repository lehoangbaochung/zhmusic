import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/repositories.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horivertical/horivertical_page.dart';
import '/pages/horivertical/horivertical_theme.dart';
import '/pages/horivertical/horivertical_widget.dart';

part 'main_cubit.dart';
part 'main_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Stream.fromFuture(
          musicService.checkNetwork(),
        ).asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final connected = snapshot.requireData;
            if (connected) {
              return FutureBuilder(
                future: HoriverticalState.initial(
                  mode: HoriverticalMode.offline,
                  type: HoriverticalType.horizontal,
                  theme: HoriverticalTheme.initial(),
                  source: HoriverticalSource.audio,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final state = snapshot.requireData;
                    return FutureBuilder(
                      future: HoriverticalCubit.initial(state),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return BlocProvider(
                            child: const HoriverticalPage(),
                            create: (_) => snapshot.requireData,
                          );
                        }
                        return centeredLoadingIndicator;
                      },
                    );
                  }
                  return centeredLoadingIndicator;
                },
              );
            } else {
              return AlertDialog(
                alignment: Alignment.center,
                actionsAlignment: MainAxisAlignment.center,
                title: const Text(
                  'Kh??ng c?? k???t n???i',
                ),
                content: const Text(
                  'Ki???m tra l???i k???t n???i c???a b???n v?? th??? l???i',
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () async {
                      await musicService.checkNetwork();
                    },
                    child: const Text('Th??? l???i'),
                  ),
                  TextButton(
                    onPressed: () => exit(0),
                    child: const Text('Tho??t'),
                  ),
                ],
              );
            }
          }
          return centeredLoadingIndicator;
        },
      ),
    );
  }
}
