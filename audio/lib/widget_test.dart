import 'dart:async';

import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';

/// A circular progress indicator that centers its parent.
const centeredLoadingIndicator = Center(
  child: CircularProgressIndicator(),
);

final playerController = StreamController<Audio>.broadcast();
