import 'package:audio/pages/home_page.dart';
import 'package:audio/widgets/app_widget.dart';
import 'package:audio/widgets/player_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/widgets.dart';

part 'main_cubit.dart';
part 'main_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedTabIndex = 0;
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: [
                const HomePage(),
                placeholder,
                placeholder,
                placeholder,
              ][selectedTabIndex],
              bottomSheet: const PlayerBar(),
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: false,
                currentIndex: selectedTabIndex,
                onTap: (value) => setState(() => selectedTabIndex = value),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    label: 'Trang chủ',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Khám phá',
                    icon: Icon(Icons.explore),
                  ),
                  BottomNavigationBarItem(
                    label: 'Thông báo',
                    icon: Icon(Icons.notifications),
                  ),
                  BottomNavigationBarItem(
                    label: 'Thư viện',
                    icon: Icon(Icons.library_music),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
