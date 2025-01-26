import 'package:chat_gpt_clone/Services/gemini_service.dart';
import 'package:chat_gpt_clone/models/user_model.dart';
import 'package:chat_gpt_clone/models/message_models.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final GeminiService _geminiService =
      GeminiService('AIzaSyDTbFXYkP5NcUn9KzN4Xpt6-nTP-AOB8ew');
  final ScrollController _scrollController = ScrollController();
  String _currentGeneratingText = '';
  bool _isGenerating = false;

  final User _currentUser =
      User(id: '1', name: 'User', avatarUrl: 'assets/user_avatar.png');

  final User _aiUser =
      User(id: '2', name: 'ChatGPT', avatarUrl: 'assets/ChatGPT.png');

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = Message.create(
        content: _messageController.text.trim(),
        type: MessageType.user,
        sender: _currentUser);

    setState(() {
      _messages.add(userMessage);
      _messageController.clear();
      _isGenerating = true;
      _currentGeneratingText = '';
    });

    _scrollToBottom();

    final stream = _geminiService.getStreamResponse(userMessage.content);
    String fullResponse = '';

    await for (final chunk in stream) {
      setState(() {
        _currentGeneratingText += chunk;
      });
      fullResponse = _currentGeneratingText;
      _scrollToBottom();
    }

    setState(() {
      _isGenerating = false;
      _messages.add(Message.create(
          content: fullResponse, type: MessageType.ai, sender: _aiUser));
    });
  }

  Widget _buildMessageBubble(Message message) {
    final bool isUser = message.type == MessageType.user;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: isUser ? Colors.white : Colors.grey[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(message.sender.avatarUrl ?? ''),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(message.content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildGeneratingBubble() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(_aiUser.avatarUrl ?? ''),
          radius: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _aiUser.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _currentGeneratingText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ChatGPT',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Plus',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/ChatGPT.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'How can I help you today?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    controller: _scrollController,
                    children: [
                      ..._messages.map(_buildMessageBubble).toList(),
                      if (_isGenerating) _buildGeneratingBubble(),
                    ],
                  ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Send a message',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send, color: Colors.black),
                            onPressed: _sendMessage,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.mic, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
