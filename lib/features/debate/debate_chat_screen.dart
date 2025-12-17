import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/historical_figure.dart';
import '../../theme/app_theme.dart';
import 'providers/debate_provider.dart';

class DebateChatScreen extends StatelessWidget {
  final HistoricalFigure figure;
  final String initialTopic;
  final String? debateId;

  const DebateChatScreen({
    super.key,
    required this.figure,
    required this.initialTopic,
    this.debateId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DebateProvider()
        ..init(
          figure: figure,
          topic: initialTopic,
          debateId: debateId,
        ),
      child: _DebateChatView(
        figure: figure,
        topic: initialTopic,
      ),
    );
  }
}

class _DebateChatView extends StatefulWidget {
  final HistoricalFigure figure;
  final String topic;

  const _DebateChatView({
    required this.figure,
    required this.topic,
  });

  @override
  State<_DebateChatView> createState() => _DebateChatViewState();
}

class _DebateChatViewState extends State<_DebateChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send(BuildContext context) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();
    await context.read<DebateProvider>().sendMessage(text);

    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted || !_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DebateProvider>();
    final messages = provider.messages;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkMaroon,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.figure.name,
          style: const TextStyle(color: AppTheme.whiteText),
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
          _buildConversationHeader(),
          const SizedBox(height: 8),
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.brightRed,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(messages[index]);
                    },
                  ),
          ),
          if (provider.isSending)
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Thinking...',
                style: TextStyle(color: AppTheme.lightGray),
              ),
            ),
          _buildInputBar(context),
        ],
      ),
    );
  }

  Widget _buildConversationHeader() {
    final title = widget.figure.title;
    final topic = widget.topic;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppTheme.darkBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You are debating:',
            style: TextStyle(color: AppTheme.lightGray, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            widget.figure.name,
            style: const TextStyle(
              color: AppTheme.whiteText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (title.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(color: AppTheme.lightGray, fontSize: 13),
            ),
          ],
          if (topic.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Topic: $topic',
              style: const TextStyle(color: AppTheme.lightRed, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageBubble(DebateMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
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
                color:
                    message.isUser ? AppTheme.brightRed : AppTheme.darkMaroon,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.text,
                style: const TextStyle(color: AppTheme.whiteText, fontSize: 16),
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

  Widget _buildInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppTheme.darkMaroon),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.darkBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.lightGray.withOpacity(0.3)),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: AppTheme.whiteText),
                decoration: const InputDecoration(
                  hintText: 'Type your message…',
                  hintStyle: TextStyle(color: AppTheme.lightGray),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _send(context),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.brightRed,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: AppTheme.whiteText),
              onPressed: () => _send(context),
            ),
          ),
        ],
      ),
    );
  }
}
