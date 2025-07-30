import 'package:flutter/material.dart';

Widget buildMessageInput(TextEditingController messageController ,  VoidCallback onSend, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      border: Border(
        top: BorderSide(color: Colors.grey[800]!),
      ),
    ),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: ()=> _showAttachmentOptions(context)
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              onSubmitted: (_) => onSend,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onSend,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF007AFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

void _showAttachmentOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1C1C1E),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAttachmentOption(
              icon: Icons.photo_camera,
              label: 'Camera',
              onTap: () {},
              context: context
            ),
            _buildAttachmentOption(
              icon: Icons.photo_library,
              label: 'Gallery',
              onTap: () {},
               context: context
            ),
            _buildAttachmentOption(
              icon: Icons.insert_drive_file,
              label: 'Document',
              onTap: () {},
               context: context
            ),
            _buildAttachmentOption(
              icon: Icons.location_on,
              label: 'Location',
              onTap: () {},
               context: context
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildAttachmentOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
    onTap: () {
      Navigator.pop(context);
      onTap();
    },
  );
}