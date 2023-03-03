import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'horivertical_page.dart';

extension HoriverticalWidgetX on BuildContext {
  HoriverticalCubit get horiverticalCubit => read<HoriverticalCubit>();

  HoriverticalState get horiverticalState => watch<HoriverticalCubit>().state;
}

enum HoriverticalSource {
  audio,
  video;
}

enum HoriverticalMode {
  online,
  offline;
}

enum HoriverticalType {
  horizontal,
  vertical;
}
