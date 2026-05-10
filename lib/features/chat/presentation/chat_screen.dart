import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final VoidCallback onBack;

  const ChatScreen({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewPadding.bottom;

    final bool isThreeButtonNavigation =
        bottomInset > 20;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),

      body: SafeArea(
        bottom: false,

        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),

              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF1F1F2B),
                  ),
                ),
              ),

              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBack,

                    child: Container(
                      width: 42,
                      height: 42,

                      decoration: BoxDecoration(
                        color: const Color(0xFF12121A),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 42,
                    height: 42,

                    decoration: BoxDecoration(
                      color: const Color(0xFF12121A),
                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons.smart_toy_rounded,
                      color: Color(0xFF00BFFF),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Chintu AI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 2),

                        Text(
                          "Online",
                          style: TextStyle(
                            color: Color(0xFFA0A0B2),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // CHAT LIST
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),

                children: const [
                  AiMessageBubble(
                    message:
                        "Hey Abhinandan 👋\nWhat would you like to plan today?",
                  ),

                  SizedBox(height: 16),

                  UserMessageBubble(
                    message:
                        "Help me create a study schedule for Flutter development.",
                  ),

                  SizedBox(height: 16),

                  AiMessageBubble(
                    message:
                        "Sure. I can create a focused daily routine with learning, practice, and project building blocks.",
                  ),

                  SizedBox(height: 16),

                  TypingIndicator(),
                ],
              ),
            ),

            // INPUT AREA
            Container(
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                isThreeButtonNavigation ? 20 : 10,
              ),

              decoration: const BoxDecoration(
                color: Color(0xFF0B0B0F),

                border: Border(
                  top: BorderSide(
                    color: Color(0xFF1F1F2B),
                  ),
                ),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFF12121A),

                        borderRadius:
                            BorderRadius.circular(16),

                        border: Border.all(
                          color:
                              const Color(0xFF1F1F2B),
                        ),
                      ),

                      child: const TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText: "Message Chintu...",

                          hintStyle: TextStyle(
                            color: Color(0xFFA0A0B2),
                          ),

                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 54,
                    height: 54,

                    decoration: BoxDecoration(
                      color: const Color(0xFF6A5ACD),

                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: IconButton(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiMessageBubble extends StatelessWidget {
  final String message;

  const AiMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF12121A),

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: const Color(0xFF1F1F2B),
          ),
        ),

        child: Text(
          message,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class UserMessageBubble extends StatelessWidget {
  final String message;

  const UserMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,

      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF6A5ACD),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Text(
          message,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: const Color(0xFF12121A),

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: const Color(0xFF1F1F2B),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            dot(),
            const SizedBox(width: 6),
            dot(),
            const SizedBox(width: 6),
            dot(),
          ],
        ),
      ),
    );
  }

  Widget dot() {
    return Container(
      width: 8,
      height: 8,

      decoration: const BoxDecoration(
        color: Color(0xFF00BFFF),
        shape: BoxShape.circle,
      ),
    );
  }
}