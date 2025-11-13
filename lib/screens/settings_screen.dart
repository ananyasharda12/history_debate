import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _reduceMotion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      appBar: AppBar(
        backgroundColor: AppTheme.darkNavy,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppTheme.whiteText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Appearance', [
                _buildSettingItem(
                  'Font size',
                  'Medium',
                  () {},
                ),
                _buildSettingItem(
                  'Theme',
                  'Dark',
                  () {},
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Account', [
                _buildSettingItem(
                  'Badges',
                  '0 badges',
                  () {},
                ),
                _buildSettingItem(
                  'Debate streak',
                  '0 day streak',
                  () {},
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Language', [
                _buildSettingItem(
                  'Language',
                  'English',
                  () {},
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Accessibility', [
                _buildToggleItem(
                  'Reduce motion',
                  _reduceMotion ? 'On' : 'Off',
                  _reduceMotion,
                  (value) {
                    setState(() {
                      _reduceMotion = value;
                    });
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
      // Bottom nav is handled by MainNavigationScreen
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.whiteText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildSettingItem(String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.whiteText,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.lightGray,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppTheme.whiteText,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildToggleItem(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.whiteText,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.lightGray,
            fontSize: 14,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.brightRed,
        ),
      ),
    );
  }

}

