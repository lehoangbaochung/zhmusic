import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/pages/horizontal/horizontal_page.dart';

class HoriverticalCubit extends Cubit<HoriverticalState> {
  HoriverticalCubit() : super(HoriverticalState());
}

class HoriverticalState {

}

class HoriverticalPage extends StatelessWidget {
  const HoriverticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HorizontalCubit(),
      child: const HorizontalPage(),
    );
  }
}