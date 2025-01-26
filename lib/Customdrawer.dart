import 'package:chat_gpt_clone/SettingsPage.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildListTile(
            icon: Image.asset(
              'assets/ChatGPT.png',
              width: 40,
              height: 40,
            ),
            title: 'ChatGPT',
          ),
          _buildListTile(
            icon: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text('M', style: TextStyle(color: Colors.white)),
            ),
            title: 'Text Formatter',
          ),
          _buildListTile(
            icon: const Icon(Icons.grid_4x4),
            title: 'Explore GPTs',
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Today',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          _buildListTile(
            title: 'ChatGPT UI Update',
            showLeading: false,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Yesterday',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          _buildListTile(
            title: 'Dynamic Chat UI Rendering',
            showLeading: false,
          ),
          _buildListTile(
            title: 'WebSocket Chat Integration',
            showLeading: false,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '2 days ago',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          _buildListTile(
            title: 'Beginner Flutter Developer Bio',
            showLeading: false,
          ),
          _buildListTile(
            title: 'Flutter LinkedIn Headline Tips',
            showLeading: false,
          ),
          _buildListTile(
            title: 'ChatGPT Flutter UI',
            showLeading: false,
          ),
          const Spacer(),
          const Divider(),
          _buildListTile(
            icon: const CircleAvatar(
              backgroundImage: NetworkImage('https://placeholder.com/48'),
            ),
            title: 'Rishabh Singh',
            trailing: InkWell(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    ),
                child: const Icon(Icons.settings)),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    Widget? icon,
    required String title,
    Widget? trailing,
    bool showLeading = true,
  }) {
    return ListTile(
      leading: showLeading ? icon : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
