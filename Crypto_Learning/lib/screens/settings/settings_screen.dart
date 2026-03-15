import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/theme_provider.dart';
import '../main_navigation/main_navigation_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _currency = 'USD';
  bool _priceAlerts = true;
  bool _newsNotifications = false;
  bool _biometrics = false;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: context.textPrimary),
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
        children: [
          const SizedBox(height: 8),

        // Appearance Section
        _SectionHeader(title: 'Appearance'),
        _SettingsTile(
          icon: Icons.dark_mode,
          iconColor: Colors.indigo,
          title: 'Dark Mode',
          subtitle: isDark ? 'Dark theme active' : 'Light theme active',
          trailing: Switch(
            value: isDark,
            onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
            activeThumbColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.attach_money,
          iconColor: Colors.green,
          title: 'Display Currency',
          subtitle: _currency,
          trailing: Icon(Icons.chevron_right, color: context.textSecondary),
          onTap: () => _showPicker(
            context: context,
            title: 'Display Currency',
            options: ['USD', 'EUR', 'GBP', 'JPY', 'INR', 'AUD'],
            selected: _currency,
            onSelect: (v) => setState(() => _currency = v),
          ),
        ),

        const SizedBox(height: 8),
        _SectionHeader(title: 'Notifications'),
        _SettingsTile(
          icon: Icons.price_change,
          iconColor: Colors.orange,
          title: 'Price Alerts',
          subtitle: 'Get notified on significant price moves',
          trailing: Switch(
            value: _priceAlerts,
            onChanged: (v) => setState(() => _priceAlerts = v),
            activeThumbColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.newspaper,
          iconColor: Colors.teal,
          title: 'News Updates',
          subtitle: 'Breaking crypto news notifications',
          trailing: Switch(
            value: _newsNotifications,
            onChanged: (v) => setState(() => _newsNotifications = v),
            activeThumbColor: AppColors.primary,
          ),
        ),

        _SettingsTile(
          icon: Icons.fingerprint,
          iconColor: Colors.purple,
          title: 'Biometric Login',
          subtitle: 'Use fingerprint or Face ID to login',
          trailing: Switch(
            value: _biometrics,
            onChanged: (v) => setState(() => _biometrics = v),
            activeThumbColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.lock_outline,
          iconColor: Colors.red,
          title: 'Change Password',
          subtitle: 'Update your account password',
          trailing: Icon(Icons.chevron_right, color: context.textSecondary),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password change coming soon')),
          ),
        ),

        const SizedBox(height: 8),
        _SectionHeader(title: 'About'),
        _SettingsTile(
          icon: Icons.info_outline,
          iconColor: AppColors.textSecondary,
          title: 'Version',
          subtitle: '1.0.0 (Build 100)',
          trailing: const SizedBox.shrink(),
        ),
        _SettingsTile(
          icon: Icons.description_outlined,
          iconColor: AppColors.textSecondary,
          title: 'Terms of Service',
          trailing: Icon(Icons.chevron_right, color: context.textSecondary),
        ),
        _SettingsTile(
          icon: Icons.privacy_tip_outlined,
          iconColor: AppColors.textSecondary,
          title: 'Privacy Policy',
          trailing: Icon(Icons.chevron_right, color: context.textSecondary),
        ),
        _SettingsTile(
          icon: Icons.help_outline,
          iconColor: AppColors.textSecondary,
          title: 'Help & Support',
          trailing: Icon(Icons.chevron_right, color: context.textSecondary),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Educational use only. Not financial advice.',
            textAlign: TextAlign.center,
            style: TextStyle(color: context.textSecondary, fontSize: 11),
          ),
        ),
        const SizedBox(height: 40),
      ],
    ),
  );
}

  void _showPicker({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selected,
    required void Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          ...options.map(
            (opt) => ListTile(
              title: Text(opt, style: TextStyle(color: context.textPrimary)),
              trailing: opt == selected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                onSelect(opt);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: context.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: context.textPrimary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
