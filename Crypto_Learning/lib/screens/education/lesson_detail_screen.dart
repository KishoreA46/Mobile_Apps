import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/education_provider.dart';
import '../../models/lesson.dart';
import '../../core/theme/app_colors.dart';

class LessonDetailScreen extends ConsumerWidget {
  final LessonModel lesson;
  const LessonDetailScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(educationProvider).contains(lesson.id);

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: Text(lesson.title, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: isCompleted 
                ? null 
                : () => ref.read(educationProvider.notifier).completeLesson(lesson.id),
            child: Text(
              isCompleted ? 'Done' : 'Mark Done',
              style: TextStyle(
                color: isCompleted ? Colors.grey : AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _MetaChip(
                  icon: Icons.signal_cellular_alt,
                  label: lesson.difficulty,
                  color: lesson.difficulty == 'Beginner'
                      ? Colors.green
                      : lesson.difficulty == 'Intermediate'
                      ? Colors.orange
                      : lesson.difficulty == 'Advanced'
                      ? Colors.deepPurpleAccent
                      : Colors.red,
                ),
                const SizedBox(width: 8),
                _MetaChip(
                  icon: Icons.timer_outlined,
                  label: lesson.duration,
                  color: context.textSecondary,
                ),
                const SizedBox(width: 8),
                _MetaChip(
                  icon: Icons.category_outlined,
                  label: lesson.phase,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _RichLessonContent(content: lesson.content),
            if (lesson.quizzes.isNotEmpty) ...[
              const SizedBox(height: 40),
              const Text(
                'Knowledge Check',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              _QuizSection(quizzes: lesson.quizzes),
            ],
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                if (!isCompleted) {
                  await ref.read(educationProvider.notifier).completeLesson(lesson.id);
                }
                if (context.mounted) Navigator.pop(context);
              },
              icon: Icon(isCompleted ? Icons.check_circle : Icons.check_circle_outline),
              label: Text(isCompleted ? 'Lesson Completed' : 'Complete Lesson'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: isCompleted ? Colors.green : AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RichLessonContent extends StatelessWidget {
  final String content;
  const _RichLessonContent({required this.content});

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) {
        widgets.add(const SizedBox(height: 12));
      } else if (line.startsWith('![') && line.contains('](') && line.endsWith(')')) {
        final urlStart = line.indexOf('](') + 2;
        final url = line.substring(urlStart, line.length - 1);
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    url,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: context.cardColor,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.borderColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image_outlined, color: context.textSecondary, size: 40),
                          const SizedBox(height: 8),
                          Text(
                            'Image failed to load',
                            style: TextStyle(color: context.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (line.startsWith('**') && line.endsWith('**')) {
        final text = line.replaceAll('**', '');
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      } else if (line.startsWith('• ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '• ',
                  style: TextStyle(color: AppColors.primary, fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    line.substring(2),
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              line,
              style: TextStyle(
                color: context.textSecondary,
                fontSize: 15,
                height: 1.7,
              ),
            ),
          ),
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class _QuizSection extends StatefulWidget {
  final List<QuizQuestion> quizzes;
  const _QuizSection({required this.quizzes});

  @override
  State<_QuizSection> createState() => _QuizSectionState();
}

class _QuizSectionState extends State<_QuizSection> {
  final Map<int, int> _selectedAnswers = {};
  bool _showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < widget.quizzes.length; i++)
          _buildQuestion(i, widget.quizzes[i]),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showAnswers = true;
            });
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            _showAnswers ? 'Reviewing Answers' : 'Check Answers',
            style: TextStyle(
              color: context.isDark ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion(int index, QuizQuestion question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${question.question}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: context.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(question.options.length, (optIndex) {
            final isSelected = _selectedAnswers[index] == optIndex;
            final isCorrect = optIndex == question.correctOptionIndex;

            Color? bgColor = context.cardColor;
            Color borderColor = context.borderColor;

            if (_showAnswers) {
              if (isCorrect) {
                bgColor = Colors.green.withValues(alpha: 0.15);
                borderColor = Colors.green;
              } else if (isSelected && !isCorrect) {
                bgColor = Colors.red.withValues(alpha: 0.15);
                borderColor = Colors.red;
              }
            } else if (isSelected) {
              bgColor = AppColors.primary.withValues(alpha: 0.15);
              borderColor = AppColors.primary;
            }

            return GestureDetector(
              onTap: _showAnswers
                  ? null
                  : () {
                      setState(() {
                        _selectedAnswers[index] = optIndex;
                      });
                    },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: borderColor,
                    width: isSelected || (_showAnswers && isCorrect) ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _showAnswers
                          ? (isCorrect
                                ? Icons.check_circle
                                : (isSelected
                                      ? Icons.cancel
                                      : Icons.circle_outlined))
                          : (isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked),
                      color: _showAnswers
                          ? (isCorrect
                                ? Colors.green
                                : (isSelected
                                      ? Colors.red
                                      : context.textSecondary))
                          : (isSelected
                                ? AppColors.primary
                                : context.textSecondary),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        question.options[optIndex],
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
