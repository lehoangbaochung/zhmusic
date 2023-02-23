import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';
import 'package:television/app/app_storage.dart';

import '/extensions/entities.dart';
import '/pages/horivertical/horivertical_widget.dart';
import '/pages/horizontal/horizontal_page.dart';

part 'horivertical_cubit.dart';
part 'horivertical_state.dart';

class HoriverticalPage extends StatefulWidget {
  const HoriverticalPage({super.key});

  @override
  State<HoriverticalPage> createState() => _HoriverticalPageState();
}

class _HoriverticalPageState extends State<HoriverticalPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.playerCubit.player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoriverticalCubit, HoriverticalState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  alignment: Alignment.center,
                  actionsAlignment: MainAxisAlignment.center,
                  title: const Text('Thoát ứng dụng'),
                  content: const Text('Bạn muốn thoát ứng dụng ngay bây giờ?'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, true);
                        await context.playerCubit.player.dispose();
                      },
                      child: const Text('Thoát'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Hủy'),
                    ),
                  ],
                );
              },
            );
            return result ?? false;
          },
          child: BlocProvider(
            create: (_) => HorizontalCubit(),
            child: const HorizontalPage(),
          ),
        );
      },
    );
  }
}
