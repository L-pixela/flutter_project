import 'package:flutter/material.dart';
import '../model/profile_tile_model.dart';

ProfileData myProfile = ProfileData(
    name: "Sovatanak",
    position: "Flutter Developer",
    avatarUrl: 'assets/profile_pic/pikachu.jpg',
    tiles: [
      TileData(
          icon: Icons.email,
          title: "Mail",
          value: "sovatanak.phon@student.cadt.edu.kh"),
      TileData(
          icon: Icons.flutter_dash,
          title: "Flutter",
          value: "Flutter is what makes this app."),
    ]);
