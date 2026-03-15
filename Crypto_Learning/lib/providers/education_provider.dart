import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

final educationProvider = NotifierProvider<EducationNotifier, List<String>>(() {
  return EducationNotifier();
});

class EducationNotifier extends Notifier<List<String>> {
  static const String _storageKey = 'completed_lessons';

  @override
  List<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final completed = prefs.getStringList(_storageKey) ?? [];
    return completed;
  }

  Future<void> completeLesson(String lessonId) async {
    if (state.contains(lessonId)) return;

    final newState = [...state, lessonId];
    state = newState;

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(_storageKey, newState);
  }

  Future<void> resetProgress() async {
    state = [];
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_storageKey);
  }

  bool isCompleted(String lessonId) => state.contains(lessonId);
}
