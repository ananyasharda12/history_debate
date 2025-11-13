import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/historical_figure.dart';

class DebateChatScreen extends StatefulWidget {
  final HistoricalFigure? figure;
  final String? initialTopic;
  
  const DebateChatScreen({super.key, this.figure, this.initialTopic});

  @override
  State<DebateChatScreen> createState() => _DebateChatScreenState();
}

class _DebateChatScreenState extends State<DebateChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<DebateMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add initial greeting message
    final figureName = widget.figure?.name ?? 'Abraham Lincoln';
    String greetingMessage;
    
    if (widget.initialTopic != null && widget.initialTopic!.isNotEmpty) {
      greetingMessage = "Greetings, young scholar. I am $figureName, and I understand you wish to discuss ${widget.initialTopic}. This is a topic of great importance, and I am eager to share my perspective. What are your thoughts on this matter?";
    } else {
      greetingMessage = "Greetings, young scholar. I am $figureName, and I am here to engage in a thoughtful discourse on matters of governance, liberty, and the pursuit of a more perfect union. What questions or topics are on your mind today?";
    }
    
    _messages.add(
      DebateMessage(
        id: '1',
        text: greetingMessage,
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
    
    // If there's an initial topic, add it as a user message
    if (widget.initialTopic != null && widget.initialTopic!.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _messages.add(
              DebateMessage(
                id: '2',
                text: "I'd like to discuss ${widget.initialTopic}.",
                isUser: true,
                timestamp: DateTime.now(),
              ),
            );
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        DebateMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _messageController.text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    });

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          DebateMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: "That is a thoughtful question. Let me share my perspective on this matter...",
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C1A1A),
      appBar: AppBar(
        backgroundColor: AppTheme.darkMaroon,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Debate',
          style: TextStyle(color: AppTheme.whiteText),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.darkBackground,
              child: const Icon(Icons.person, color: AppTheme.whiteText),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(DebateMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.darkMaroon,
              child: const Icon(Icons.person, color: AppTheme.whiteText),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: message.isUser
                    ? AppTheme.brightRed
                    : AppTheme.darkMaroon,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: AppTheme.whiteText,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.darkMaroon,
              child: Icon(Icons.person, color: AppTheme.whiteText),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.darkMaroon,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.darkMaroon,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.lightGray.withOpacity(0.3)),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: AppTheme.whiteText),
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: AppTheme.lightGray),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.brightRed,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.mic, color: AppTheme.whiteText),
              onPressed: () {
                // Handle voice input
              },
            ),
          ),
        ],
      ),
    );
  }
}

