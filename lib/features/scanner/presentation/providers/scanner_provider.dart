import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'scanner_controller.dart';
import 'scanner_state.dart';

final scannerControllerProvider =
    NotifierProvider<ScannerController, ScannerState>(
  ScannerController.new,
);