import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';

final splashProvider =
    FutureProvider<bool>(
  (ref) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final repository =
        ref.read(
      authRepositoryProvider,
    );

    return repository.currentUser() !=
        null;
  },
);