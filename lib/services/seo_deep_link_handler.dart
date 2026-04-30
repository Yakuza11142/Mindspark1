class SeoDeepLinkHandler {
  static void handleLink(Uri uri) {
    print("🔗 Deep Link intercepted: Routing user directly to ${uri.pathSegments.last}");
  }
}