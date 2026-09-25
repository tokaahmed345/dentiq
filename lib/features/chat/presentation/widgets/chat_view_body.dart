import 'package:dentiq/core/utils/colors/app_colors.dart';
import 'package:dentiq/features/chat/data/model/chat_model.dart';
import 'package:dentiq/features/chat/presentation/view_model/cubit/chat_cubit.dart';
import 'package:dentiq/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

  class _ChatViewBodyState extends State<ChatViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatModel> messages = [
    ChatModel(
      candidates: [
        Candidates(content: Content(parts: [Parts(text: "Hello, how can I help you?")]))
      ],
      isUser: false, 
    )
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = ChatModel(
      candidates: [
        Candidates(content: Content(parts: [Parts(text: _controller.text.trim())]))
      ],
      isUser: true,
    );

    setState(() {
      messages.add(userMessage);
    });

    context.read<ChatCubit>().fetchMessage(message: userMessage.firstMessage);

    _controller.clear();

    _scrollToBottom();
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
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  final botMessage = state.message;
                  botMessage.isUser = false; 
                  setState(() {
                    messages.add(botMessage);
                  });
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: messages.length + (state is ChatLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state is ChatLoading && index == messages.length) {
                      return   Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const SizedBox(
                              width: 24,
                              height: 24,
                              child: SpinKitDoubleBounce(color: Colors.grey, size: 16),
                            ),
                          ),
                        );
                    }

                    final message = messages[index];
                    return ChatBubble(
                      text: message.firstMessage,
                      isUser: message.isUser,
                    );
                  },
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color:Theme.of(context).brightness == Brightness.dark
          ? Colors.blueGrey.shade700   
        : Colors.grey.shade100,
                
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.send,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
