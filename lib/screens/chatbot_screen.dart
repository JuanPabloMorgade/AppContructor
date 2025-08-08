import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ChatMessage {
  const ChatMessage({required this.text, required this.isUser});
  final String text;
  final bool isUser;
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    // Espera al próximo frame para asegurar que la lista se haya renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _handleSend(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      // Mensaje del usuario
      _messages.add(ChatMessage(text: trimmed, isUser: true));
      // Mostrar "Escribiendo..." del bot
      _messages.add(const ChatMessage(text: 'Escribiendo...', isUser: false));
    });
    _controller.clear();
    _scrollToBottom();

    // Después de 1 segundo, reemplazar "Escribiendo..." por la respuesta
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        // Si el último es "Escribiendo..." (del bot), lo removemos
        if (_messages.isNotEmpty &&
            !_messages.last.isUser &&
            _messages.last.text == 'Escribiendo...') {
          _messages.removeLast();
        }
        // Añadimos respuesta
        _messages.add(
          const ChatMessage(text: 'Estamos trabajando en ello', isUser: false),
        );
      });
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primaryContainer;
    final onPrimary = Theme.of(context).colorScheme.onPrimaryContainer;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Chatbot IA'),
            SizedBox(width: 8),
            Icon(Icons.smart_toy),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final alignment = msg.isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
                final bubbleColor = msg.isUser ? primary : Colors.grey.shade300;
                final textColor = msg.isUser ? onPrimary : Colors.black;

                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text, style: TextStyle(color: textColor)),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: _handleSend,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSend(_controller.text),
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
