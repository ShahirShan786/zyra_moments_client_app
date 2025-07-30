import 'package:flutter/material.dart';

PreferredSizeWidget buildChatAppBar(
    BuildContext context, String? recipientAvatar, String recipientName) {
  return AppBar(
    backgroundColor: const Color(0xFF1C1C1E),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[800],
          backgroundImage:
              recipientAvatar != null ? NetworkImage(recipientAvatar) : null,
          child: recipientAvatar == null
              ? Text(
                  recipientName.isNotEmpty
                      ? recipientName[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipientName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Online',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.videocam_outlined, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.call_outlined, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onPressed: () {},
      ),
    ],
  );
}