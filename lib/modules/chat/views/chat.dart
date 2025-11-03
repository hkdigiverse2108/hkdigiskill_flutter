import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/chat/controllers/chat_controller.dart';

class Chat extends GetView<ChatController> {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 32,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://randomuser.me/api/portraits/women/32.jpg",
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Martha Craig',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            // SizedBox(width: 4),
            // Icon(Icons.verified, color: Colors.blue, size: 16),
          ],
        ),
        // backgroundColor: Color(0xff075e54),
        actions: [
          Icon(Icons.call, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.black),
          SizedBox(width: 8),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Color(0xffece5dd),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              itemCount: controller.messages.length,
              itemBuilder: (context, idx) {
                final msg = controller.messages[idx];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  alignment: msg.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: msg.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (msg.text.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: msg.isMe ? Color(0xffdcf8c6) : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(msg.isMe ? 12 : 0),
                              bottomRight: Radius.circular(msg.isMe ? 0 : 12),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      if (msg.isFile)
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffdcf8c6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.insert_drive_file_outlined,
                                size: 24,
                                color: Colors.grey[700],
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg.filename ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    msg.filesize ?? '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 6),
                          Text(
                            msg.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (msg.isMe)
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(
                                Icons.done_all,
                                size: 15,
                                color: Colors.blue,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                // Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                // SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      filled: true,
                      fillColor: Color(0xfff0f0f0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => controller.sendMessage(),
                  ),
                ),
                SizedBox(width: 8),

                // Send Button
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.primary),
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
