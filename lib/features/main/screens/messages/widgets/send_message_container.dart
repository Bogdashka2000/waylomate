import 'package:flutter/material.dart';

class SendMessageContainer extends StatefulWidget {
  const SendMessageContainer({
    super.key,
    required this.messageController,
    this.onSend,
    required this.isConnected,
    this.focusNode,
  });

  final TextEditingController messageController;
  final VoidCallback? onSend;
  final bool isConnected;
  final FocusNode? focusNode;

  @override
  State<SendMessageContainer> createState() => _SendMessageContainerState();
}

class _SendMessageContainerState extends State<SendMessageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.messageController,
              focusNode: widget.focusNode,
              decoration: const InputDecoration(
                hintText: 'Введите сообщение...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              onSubmitted: (_) => _handleSend(),
              enabled: true,
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            elevation: 8,
            shape: const CircleBorder(),
            onPressed: widget.isConnected ? _handleSend : null,
            backgroundColor: widget.isConnected
                ? Color.fromARGB(255, 146, 103, 222)
                : Colors.grey,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    final text = widget.messageController.text.trim();
    if (text.isEmpty) return;

    widget.onSend?.call();

    // if (widget.focusNode != null) {
    //   widget.focusNode!.unfocus();
    // }
  }
}
