import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyAuthService {
  // Fungsi untuk mendapatkan Access Token dari Spotify API
  static Future<String> getAccessToken() async {
    // Gantikan dengan client_id dan client_secret kamu
    const clientId = 'Enter ur ClientId Spotify Here';  // Masukkan client_id yang benar
    const clientSecret = 'Enter ur ClientSecret Spotify Here';  // Masukkan client_secret yang benar

    // Encode ke Base64
    String credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

    // Endpoint token Spotify
    final url = Uri.parse('https://accounts.spotify.com/api/token');
    
    // Headers
    final headers = {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    // Body request
    final body = {
      'grant_type': 'client_credentials',
    };

    // Kirim POST request
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Decode response body untuk mendapatkan access token
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['access_token']; // Return access token
    } else {
      throw Exception('Failed to get access token: ${response.statusCode}');
    }
  }
}
