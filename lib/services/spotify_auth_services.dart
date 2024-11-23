import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SpotifyAuthService {
  static Future<String> getAccessToken() async {
    const clientId = 'ClientId';  // Pastikan ini benar
    const clientSecret = 'ClientSecret';  // Pastikan ini benar
    
    String credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
    final url = Uri.parse('https://accounts.spotify.com/api/token');
    
    final headers = {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final body = {
      'grant_type': 'client_credentials',
    };
    
    final response = await http.post(url, headers: headers, body: body);
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      debugPrint('Spotify Access Token: $accessToken'); // Debug token
      return accessToken;
    } else {
      debugPrint('Error fetching token: ${response.body}'); // Debug error message
      throw Exception('Failed to get access token: ${response.statusCode}');
    }
  }
}