import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'add_card_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF002B),
          title: const Text('Profile'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Account'),
              Tab(text: 'FoodMarket'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AccountTab(),
            _AppInfoTab(),
          ],
        ),
      ),
    );
  }
}

class _AccountTab extends StatefulWidget {
  const _AccountTab();

  @override
  State<_AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<_AccountTab> {
  String fullName = 'John Doe';
  String email = 'johndoe@example.com';
  int? selectedIconIndex = 0;
  File? imageFile;

  final List<IconData> icons = [
    Icons.person,
    Icons.pets,
    Icons.star,
    Icons.cake,
    Icons.favorite,
    Icons.audiotrack,
    Icons.beach_access,
  ];

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (imageFile != null) {
      avatar = CircleAvatar(radius: 50, backgroundImage: FileImage(imageFile!));
    } else if (selectedIconIndex != null) {
      avatar = CircleAvatar(radius: 50, child: Icon(icons[selectedIconIndex!], size: 48));
    } else {
      avatar = const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 48));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(child: avatar),
        const SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF002B)),
            onPressed: _chooseProfilePicture,
            child: const Text('Modifier le profil'),
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(fullName),
          subtitle: const Text('Full Name'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editDialog(context, 'Full Name', fullName, (val) {
              setState(() => fullName = val);
            }),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddCardScreen()),
            );
          },
          icon: const Icon(Icons.credit_card),
          label: const Text('Ajouter une carte'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF002B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text(email),
          subtitle: const Text('Email'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editDialog(context, 'Email', email, (val) {
              setState(() => email = val);
            }),
          ),
        ),
      ],
    );
  }

  void _chooseProfilePicture() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Prendre une photo'),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() {
                    imageFile = File(picked.path);
                    selectedIconIndex = null;
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choisir depuis la galerie'),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    imageFile = File(picked.path);
                    selectedIconIndex = null;
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('Choisir une icône'),
              onTap: () {
                Navigator.pop(context);
                _chooseIcon();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _chooseIcon() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Choisis une icône'),
        content: Wrap(
          spacing: 12,
          children: List.generate(icons.length, (i) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIconIndex = i;
                  imageFile = null;
                });
                Navigator.pop(context);
              },
              child: CircleAvatar(child: Icon(icons[i])),
            );
          }),
        ),
      ),
    );
  }

  Future<void> _editDialog(
    BuildContext context,
    String field,
    String initial,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: initial);

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF002B)),
            onPressed: () {
              onSave(controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _AppInfoTab extends StatelessWidget {
  const _AppInfoTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: const Text('Support'),
          onTap: () {/* TODO: navigate */},
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Terms & Conditions'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Do you really want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF002B)),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}