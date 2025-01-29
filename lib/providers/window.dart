import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/window_preferences.dart';

final fullscreenProvider = StateProvider((ref) => false);

final windowPreferencesProvider =
    StateProvider<WindowPreferences?>((ref) => null);
