import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_music_app/services/spotify_auth_services.dart'; // Pastikan path ini benar
import 'providers/artist_provider.dart'; 
import 'providers/song_provider.dart';   
import 'screen/search_screen.dart';

void fetchSpotifyToken() async {
  try {
    String accessToken = await SpotifyAuthService.getAccessToken();
    print('Access Token: $accessToken');
  } catch (e) {
    print('Error: $e');
  }
}

void main() {
  // Panggil fetchSpotifyToken() jika ingin melihat token
  fetchSpotifyToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
        ChangeNotifierProvider(create: (_) => SongProvider()),
      ],
      child: MaterialApp(
        title: 'My Music App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SearchScreen(),
      ),
    );
  }
}
