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
    return SafeArea(
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Center(
                child: Text(
                  'Ứng dụng hiện tại chỉ hỗ trợ chạy trên các thiết bị có màn hình tỉ lệ khung hình 16:9',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            } else {
              return FutureBuilder(
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
              );
            }
          },
        ),
      ),
    );
  }
}
