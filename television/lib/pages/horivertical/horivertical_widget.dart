import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'horivertical_page.dart';

extension HoriverticalWidgetX on BuildContext {
  HoriverticalCubit get playerCubit => read<HoriverticalCubit>();

  HoriverticalState get playerState => watch<HoriverticalCubit>().state;
}