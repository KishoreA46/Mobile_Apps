import 'package:flutter/foundation.dart' show kIsWeb;

class NetworkUtils {
  NetworkUtils._();

  /// Wraps a URL with a CORS proxy if running on Flutter Web.
  /// This is necessary for images hosted on servers that don't have
  /// permissive Access-Control-Allow-Origin headers for localhost.
  static String wrapProxy(String url) {
    if (!kIsWeb) return url;
    
    // Using allorigins.win as a reliable free CORS proxy for development/demo
    // The 'raw' endpoint returns the content directly with CORS headers
    return 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(url)}';
  }
}
