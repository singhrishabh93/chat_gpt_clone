import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final List<Map<String, String>> prompts = const [
    {
      'title': 'Design a database schema',
      'subtitle': 'for an online merch store'
    },
    {'title': 'Explain airplain', 'subtitle': 'to someone 5 ye'},
    {'title': 'Write a blog post', 'subtitle': 'about artificial intelligence'},
    {'title': 'Debug my code', 'subtitle': 'Python error handling'},
    {'title': 'Create a workout plan', 'subtitle': 'for weight loss'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ChatGPT',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 4),
            const Text(
              '4',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: prompts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 250,
                        margin: EdgeInsets.only(
                            right: index != prompts.length - 1 ? 8 : 0),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prompts[index]['title']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              prompts[index]['subtitle']!,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.photo_camera),
                            onPressed: () {},
                            iconSize: 20,
                          ),
                          IconButton(
                            icon: const Icon(Icons.image),
                            onPressed: () {},
                            iconSize: 20,
                          ),
                          IconButton(
                            icon: const Icon(Icons.folder),
                            onPressed: () {},
                            iconSize: 20,
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.grey.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Message',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.mic),
                                onPressed: () {},
                                iconSize: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.headphones),
                        onPressed: () {},
                        iconSize: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
