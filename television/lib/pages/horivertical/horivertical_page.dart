import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';

import '/app/app_storage.dart';
import '/extensions/entities.dart';
import '/pages/horizontal/horizontal_page.dart';

part 'horivertical_cubit.dart';
part 'horivertical_state.dart';

late final AudioPlayer player;

class HoriverticalPage extends StatefulWidget {
  const HoriverticalPage({super.key});

  @override
  State<HoriverticalPage> createState() => _HoriverticalPageState();
}

class _HoriverticalPageState extends State<HoriverticalPage> {
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
                  title: const Text(
                    'Thoát ứng dụng',
                  ),
                  content: const Text(
                    'Bạn muốn thoát ứng dụng ngay bây giờ?',
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Thoát'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                    TextButton(
                      child: const Text('Hủy'),
                      onPressed: () => Navigator.pop(context, false),
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
