import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/chat/controllers/chats_controller.dart';
import 'package:hkdigiskill/modules/chat/widgets/chats_animation_wrapper.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:shimmer/shimmer.dart';

class Chats extends GetView<ChatsController> {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isEditing.value
                ? '${controller.selectedChats.length} selected'
                : 'Chats',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 80,
        leading: Obx(
          () => TextButton(
            onPressed: controller.toggleEditMode,
            child: Text(controller.isEditing.value ? 'Cancel' : 'Edit'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Obx(() {
            if (controller.isEditing.value &&
                controller.selectedChats.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: controller.deleteSelectedChats,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.archive, color: Colors.black),
                onPressed: () {},
              );
            }
          }),
        ],
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoading.value
            ? ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: 6, // Number of shimmer items
                itemBuilder: (context, index) => const ChatListItemShimmer(),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  return Obx(() {
                    final isSelected = controller.selectedChats.contains(index);
                    return ChatAnimationWrapper(
                      index: index,
                      onTap: () {
                        if (controller.isEditing.value) {
                          controller.selectChat(index);
                        } else {
                          Get.toNamed(Routes.chatMassage);
                        }
                      },
                      child: ChatListItem(
                        key: ValueKey('chat_${chat.hashCode}'),
                        chat: chat,
                        isSelected: isSelected,
                        isEditing: controller.isEditing.value,
                        onTap: () {},
                        onLongPress: () {
                          if (!controller.isEditing.value) {
                            controller.toggleEditMode();
                            controller.selectChat(index);
                          }
                        },
                        onArchive: () {
                          // Handle archive action
                          Get.snackbar(
                            'Archived',
                            '${chat.name} has been archived',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                          );
                        },
                        onMore: () {
                          // Show more options
                          _showMoreOptions(context, chat);
                        },
                      ),
                    );
                  });
                },
              ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context, dynamic chat) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.notifications_off,
                  color: Colors.grey,
                ),
                title: const Text('Mute Notifications'),
                onTap: () {
                  Navigator.pop(context);
                  Get.snackbar('Muted', 'Notifications muted for ${chat.name}');
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Delete Chat',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle delete chat
                  Get.snackbar(
                    'Deleted',
                    'Chat with ${chat.name} has been deleted',
                  );
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Cancel', textAlign: TextAlign.center),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class ChatListItem extends StatelessWidget {
  final dynamic chat;
  final bool isSelected;
  final bool isEditing;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback? onArchive;
  final VoidCallback? onMore;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.isSelected,
    required this.isEditing,
    required this.onTap,
    required this.onLongPress,
    this.onArchive,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return _buildListTile();
    }

    return Slidable(
      key: key ?? ValueKey(chat.hashCode),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onMore?.call(),
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.more_horiz,
            label: 'More',
          ),
          SlidableAction(
            onPressed: (context) => onArchive?.call(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: _buildListTile(),
    );
  }

  Widget _buildListTile() {
    return Material(
      color: isSelected ? Colors.grey[100] : Colors.white,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              // Selection Checkbox - Only show in edit mode
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isEditing
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Checkbox(
                          value: isSelected,
                          onChanged: (_) => onTap(),
                          activeColor: AppColors.primary,
                        ),
                      )
                    : const SizedBox(width: 0),
              ),

              // Avatar with optional selection border
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected && isEditing
                          ? Border.all(color: AppColors.primary, width: 2)
                          : null,
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: chat.avatarUrl != null
                          ? NetworkImage(chat.avatarUrl!)
                          : null,
                      child: chat.avatarUrl == null
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Chat Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          chat.date,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (chat.messageIcon != null) ...[
                          chat.messageIcon!,
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            chat.lastMessage,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Forward arrow (only in non-edit mode)
              if (!isEditing) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ChatListItemShimmer extends StatelessWidget {
  const ChatListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Checkbox placeholder (edit mode) - optional, can be omitted or rendered as a dummy box
            // Container(
            //   width: 32,
            //   height: 32,
            //   margin: const EdgeInsets.only(right: 12.0),
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade400,
            //     borderRadius: BorderRadius.circular(6),
            //   ),
            // ),
            // Avatar placeholder
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            // Chat Info placeholders
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Date
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 56,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Last message placeholder
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Forward arrow
            // Container(
            //   width: 16,
            //   height: 16,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade400,
            //     shape: BoxShape.circle,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
