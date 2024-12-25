import 'package:flutter/material.dart';

import '../../model/profile_tile_model.dart';
import '../../widgets&utils/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  final ProfileData profileData;
  const ProfilePage({super.key, required this.profileData});

  Iterable<ProfileTile> getTiles() {
    return profileData.tiles.map((tiles) =>
        ProfileTile(icon: tiles.icon, title: tiles.title, data: tiles.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileData.avatarUrl),
            ),
            SizedBox(height: 20),
            Text(
              profileData.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              profileData.position,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView(
              children: [...getTiles()],
            ))
          ],
        ),
      ),
    );
  }
}
