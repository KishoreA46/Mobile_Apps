import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/education_provider.dart';
import '../../models/lesson.dart';
import '../../screens/main_navigation/main_navigation_screen.dart';
import '../../core/theme/app_colors.dart';

class EducationScreen extends ConsumerWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedLessonIds = ref.watch(educationProvider);
    final totalLessonCount = mockLessons.length;
    final progressValue = totalLessonCount > 0 
        ? completedLessonIds.length / totalLessonCount 
        : 0.0;

    final phases = {
      'Foundations': mockLessons
          .where((l) => l.phaseId == 'foundations')
          .toList(),
      'Technical Analysis': mockLessons
          .where((l) => l.phaseId == 'technical')
          .toList(),
      'Risk Management': mockLessons.where((l) => l.phaseId == 'risk').toList(),
      'Advanced Trading': mockLessons
          .where((l) => l.phaseId == 'advanced')
          .toList(),
    };

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: Text(
          'Education',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: context.textPrimary),
          onPressed: () => AppDrawerScope.of(
            context,
          )?.scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header banner
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trading Academy',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${completedLessonIds.length} / $totalLessonCount lessons completed',
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progressValue,
                          backgroundColor: AppColors.surfaceHighlight,
                          color: AppColors.primary,
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => context.push('/education/strategies'),
                          icon: const Icon(Icons.psychology_outlined, size: 18),
                          label: const Text('Trading Strategies'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Phases
          ...phases.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PhaseHeader(title: entry.key, count: entry.value.length),
                const SizedBox(height: 8),
                ...entry.value.map((lesson) => _LessonCard(lesson: lesson)),
                const SizedBox(height: 20),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// extra bracket removed
class _PhaseHeader extends StatelessWidget {
  final String title;
  final int count;
  const _PhaseHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    final icon = title == 'Foundations'
        ? Icons.foundation
        : title == 'Technical Analysis'
        ? Icons.candlestick_chart
        : title == 'Risk Management'
        ? Icons.shield
        : Icons.psychology;
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: context.textPrimary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: context.borderColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$count lessons',
            style: TextStyle(color: context.textSecondary, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class _LessonCard extends ConsumerWidget {
  final LessonModel lesson;
  const _LessonCard({required this.lesson});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(educationProvider).contains(lesson.id);
    final difficultyColor = lesson.difficulty == 'Beginner'
        ? Colors.green
        : lesson.difficulty == 'Intermediate'
        ? Colors.orange
        : lesson.difficulty == 'Advanced'
        ? Colors.deepPurpleAccent
        : Colors.red;

    return GestureDetector(
      onTap: () => context.push('/education/lesson/${lesson.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCompleted 
              ? AppColors.primary.withValues(alpha: 0.5) 
              : context.borderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isCompleted 
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isCompleted ? Icons.check_circle : Icons.play_circle_fill,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: context.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: difficultyColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          lesson.difficulty,
                          style: TextStyle(
                            color: difficultyColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.timer_outlined,
                        color: context.textSecondary,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        lesson.duration,
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: context.textSecondary),
          ],
        ),
      ),
    );
  }
}

