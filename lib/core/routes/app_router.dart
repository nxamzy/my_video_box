import 'package:go_router/go_router.dart';
import 'package:my_folder_app/presentation/pages/add_pages/add_video_page.dart';
import 'package:my_folder_app/presentation/pages/add_pages/trim_page.dart';
import 'package:my_folder_app/presentation/pages/profile/profile_page.dart';
import 'package:my_folder_app/presentation/pages/sign_pages/signin_page.dart';
import 'package:my_folder_app/presentation/pages/sign_pages/signup.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/cyber_security.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SignInPage()),
      GoRoute(
        path: '/homePage',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(path: '/topic', builder: (context, state) => const TopicScreen()),
      GoRoute(
        path: '/add_video',
        builder: (context, state) => const AddVideoPage(),
      ),
      GoRoute(path: '/trimPage', builder: (context, state) => const TrimPage()),
      GoRoute(
        path: '/prolifePage',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/signUpPage',
        builder: (context, state) => const SignUpPage(),
      ),
    ],
  );
}
