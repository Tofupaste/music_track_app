import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyAuthService {
  static Future<String> getAccessToken() async {
    const clientId = 'client id';  // Replace with your actual client ID
    const clientSecret = 'client secret';  // Replace with your actual client secret
    
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
      return data['access_token'];
    } else {
      throw Exception('Failed to get access token: ${response.statusCode}');
    }
  }
}
