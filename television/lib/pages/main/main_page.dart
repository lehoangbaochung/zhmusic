import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/repositories.dart';
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
        future: musicService.checkNetwork(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final connected = snapshot.requireData;
            if (connected) {
              return FutureBuilder(
                future: HoriverticalState.initial(audioOnly: true),
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
                  'Không có kết nối',
                ),
                content: const Text(
                  'Kiểm tra lại kết nối của bạn và thử lại',
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await musicService.checkNetwork();
                    },
                    child: const Text('Thử lại'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Thoát'),
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
