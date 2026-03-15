import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/education_provider.dart';
import '../../screens/main_navigation/main_navigation_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../models/lesson.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    final completedLessonIds = ref.watch(educationProvider);
    
    // Real data calculation
    final totalLessons = mockLessons.length;
    final completedLessons = completedLessonIds.length;
    
    final foundationsTotal = mockLessons.where((l) => l.phaseId == 'foundations').length;
    final technicalTotal = mockLessons.where((l) => l.phaseId == 'technical').length;
    final advancedTotal = mockLessons.where((l) => l.phaseId == 'advanced').length;
    final riskTotal = mockLessons.where((l) => l.phaseId == 'risk').length;

    final foundationsCompleted = mockLessons.where((l) => l.phaseId == 'foundations' && completedLessonIds.contains(l.id)).length;
    final technicalCompleted = mockLessons.where((l) => l.phaseId == 'technical' && completedLessonIds.contains(l.id)).length;
    final advancedCompleted = mockLessons.where((l) => l.phaseId == 'advanced' && completedLessonIds.contains(l.id)).length;
    final riskCompleted = mockLessons.where((l) => l.phaseId == 'risk' && completedLessonIds.contains(l.id)).length;

    final rank = completedLessons == 0
        ? 'Novice'
        : completedLessons < totalLessons / 3
            ? 'Adept'
            : completedLessons < totalLessons * 0.8
                ? 'Professional'
                : 'Grandmaster';

    return Scaffold(
      backgroundColor: context.bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Elegant Header
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            stretch: true,
            leading: IconButton(
              icon: Icon(Icons.menu, color: context.textPrimary),
              onPressed: () => AppDrawerScope.of(context)
                  ?.scaffoldKey
                  .currentState
                  ?.openDrawer(),
            ),
            backgroundColor: context.bgColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.1),
                      context.bgColor,
                    ],
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: context.cardColor,
                          child: Icon(
                            Icons.person_rounded,
                            size: 45,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.username ?? 'Trader Pro',
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'trader@example.com',
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          rank.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                // Knowledge Progress
                _SectionHeader(
                  title: 'Knowledge Base',
                  icon: Icons.school_rounded,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.borderColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Overall Journey',
                            style: TextStyle(
                              color: context.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${totalLessons > 0 ? (completedLessons / totalLessons * 100).toInt() : 0}%',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: totalLessons > 0 ? completedLessons / totalLessons : 0.0,
                          backgroundColor: context.borderColor,
                          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _PhaseRow(
                        icon: Icons.trending_up,
                        title: 'Foundations',
                        progress: foundationsTotal > 0 ? foundationsCompleted / foundationsTotal : 0.0,
                        completed: foundationsCompleted,
                        total: foundationsTotal,
                      ),
                      _PhaseRow(
                        icon: Icons.candlestick_chart,
                        title: 'Technical Analysis',
                        progress: technicalTotal > 0 ? technicalCompleted / technicalTotal : 0.0,
                        completed: technicalCompleted,
                        total: technicalTotal,
                      ),
                      _PhaseRow(
                        icon: Icons.layers_rounded,
                        title: 'Advanced Trading',
                        progress: advancedTotal > 0 ? advancedCompleted / advancedTotal : 0.0,
                        completed: advancedCompleted,
                        total: advancedTotal,
                      ),
                      _PhaseRow(
                        icon: Icons.account_balance_wallet_rounded,
                        title: 'Risk Management',
                        progress: riskTotal > 0 ? riskCompleted / riskTotal : 0.0,
                        completed: riskCompleted,
                        total: riskTotal,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Support & More
                _SectionHeader(
                  title: 'Account & Support',
                  icon: Icons.help_outline_rounded,
                ),
                const SizedBox(height: 12),
                _SettingsGroup(
                  items: [
                    _SettingsItem(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      titleColor: AppColors.danger,
                      onTap: () async {
                        await ref.read(authStateProvider.notifier).logout();
                        if (context.mounted) context.go('/login');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}


class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.textSecondary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PhaseRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final double progress;
  final int completed;
  final int total;
  const _PhaseRow({
    required this.icon,
    required this.title,
    required this.progress,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimary,
                      ),
                    ),
                    Text(
                      '$completed/$total',
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: context.borderColor,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primary.withValues(alpha: 0.7),
                    ),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> items;
  const _SettingsGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              item,
              if (index < items.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: context.borderColor, height: 1),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: context.textSecondary, size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? context.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: onTap != null
          ? Icon(
              Icons.chevron_right_rounded,
              color: context.textSecondary,
              size: 20,
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}
