class RouteInfo {
  final String name;
  final String route;

  const RouteInfo({required this.name, required this.route});
}

class PlatformRoutes {
  static const signInPage = RouteInfo(name: 'signInPage', route: '/');
  static const homePage = RouteInfo(name: 'homePage', route: '/homePage');
  static const topicPage = RouteInfo(name: 'topic', route: '/topic');
  static const addVideoPage = RouteInfo(name: 'add_video', route: '/add_video');
  static const trimpage = RouteInfo(name: 'trimPage', route: '/trimPage');
  static const profilePage = RouteInfo(
    name: 'profilePage',
    route: '/profilePage',
  );
  static const signUpPage = RouteInfo(name: 'signUpPage', route: '/signUpPage');
}
