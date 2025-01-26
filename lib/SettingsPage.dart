import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildSection(
            title: 'ACCOUNT',
            children: [
              _buildSettingsTile(
                icon: const Icon(Icons.email_outlined),
                title: 'Email',
                value: 'rey@gmail.com',
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.add_circle_outline),
                title: 'Subscription',
                value: 'ChatGPT Plus',
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.refresh),
                title: 'Restore purchases',
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.storage_outlined),
                title: 'Data Controls',
                showChevron: true,
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.archive_outlined),
                title: 'Archived Chats',
                showChevron: true,
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.description_outlined),
                title: 'Custom instructions',
                value: 'On',
                showChevron: true,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _buildSection(
            title: 'APP',
            children: [
              _buildSettingsTile(
                icon: const Icon(Icons.brightness_6_outlined),
                title: 'Color Scheme',
                value: 'System',
                showDropdown: true,
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: const Icon(Icons.vibration),
                title: 'Haptic Feedback',
                value: true,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _buildSection(
            title: 'SPEECH',
            children: [
              _buildSettingsTile(
                icon: const Icon(Icons.graphic_eq),
                title: 'Voice',
                value: 'Breeze',
                showChevron: true,
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.language),
                title: 'Main Language',
                value: 'Auto-Detect',
                showDropdown: true,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Text(
              'For best results, select the language you mainly speak. If it\'s not listed, it may still be supported via auto-detection.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),

          _buildSection(
            title: 'ABOUT',
            children: [
              _buildSettingsTile(
                icon: const Icon(Icons.help_outline),
                title: 'Help Center',
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.description_outlined),
                title: 'Terms of Use',
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.lock_outline),
                title: 'Privacy Policy',
              ),
              const Divider(height: 1),
              _buildSettingsTile(
                icon: const Icon(Icons.circle),
                title: 'ChatGPT for iOS',
                value: '1.2024.136(91649...)',
              ),
            ],
          ),
          const SizedBox(height: 32),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildSettingsTile(
              icon: const Icon(Icons.logout, color: Colors.red),
              title: 'Logout',
              textColor: Colors.red,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required Icon icon,
    required String title,
    String? value,
    bool showChevron = false,
    bool showDropdown = false,
    Color textColor = Colors.black,
  }) {
    return ListTile(
      leading: IconTheme(
        data: IconThemeData(
          color: textColor == Colors.red ? Colors.red : Colors.black,
          size: 24,
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          if (showChevron || showDropdown)
            Icon(
              showDropdown ? Icons.expand_more : Icons.chevron_right,
              color: Colors.grey[400],
            ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      visualDensity: const VisualDensity(vertical: -2),
    );
  }

  Widget _buildSwitchTile({
    required Icon icon,
    required String title,
    required bool value,
  }) {
    return ListTile(
      leading: IconTheme(
        data: const IconThemeData(
          color: Colors.black,
          size: 24,
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: (bool value) {},
        activeColor: Colors.green,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      visualDensity: const VisualDensity(vertical: -2),
    );
  }
}