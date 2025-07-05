import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:politic_news/src/layouts/main_layout.dart';
import 'package:politic_news/src/models/news_model.dart';
import 'package:politic_news/src/screens/bookmark_screen.dart';
import 'package:politic_news/src/screens/create_news_screen.dart';
import 'package:politic_news/src/screens/edit_news_screen.dart';
import 'package:politic_news/src/screens/explore_screen.dart';
import 'package:politic_news/src/screens/home_screen.dart';
import 'package:politic_news/src/screens/introductions_screen.dart';
import 'package:politic_news/src/screens/login_screen.dart';
import 'package:politic_news/src/screens/my_news_screen.dart';
import 'package:politic_news/src/screens/news_detail_screen.dart';
import 'package:politic_news/src/screens/profile_screen.dart';
import 'package:politic_news/src/screens/register_screen.dart';
import 'package:politic_news/src/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/introductions',
        name: 'introductions',
        builder: (context, state) => const IntroductionScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(currentPath: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/explore',
            name: 'explore',
            builder: (context, state) => const ExploreScreen(),
          ),
          GoRoute(
            path: '/bookmark',
            name: 'bookmark',
            builder: (context, state) => const BookmarkScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/my-news',
        name: 'my-news',
        builder: (context, state) => const MyNewsScreen(),
      ),
      GoRoute(
        path: '/create-news',
        name: 'create-news',
        builder: (context, state) => const CreateNewsScreen(),
      ),
      GoRoute(
        path: '/edit-news',
        name: 'edit-news',
        builder: (context, state) {
          final news = state.extra as News;
          return EditNewsScreen(news: news);
        },
      ),
      GoRoute(
        path: '/news/:slug',
        name: 'news-detail',
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return NewsDetailScreen(slug: slug);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Halaman tidak ditemukan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Path: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    ),
    debugLogDiagnostics: true,
  );
}

extension AppRouterExtension on BuildContext {
  void goToSplash() => go('/splash');
  void goToIntroductions() => go('/introductions');
  void goToLogin() => go('/login');
  void goToRegister() => go('/register');
  void goToHome() => go('/home');
  void goToNews() => go('/news');
  void goToNewsDetail(String slug) => go('/news/$slug');
  void goToProfile() => go('/profile');
  void goToBookmark() => go('/bookmark');
  void goToMyNews() => go('/my-news');
  void goToCreateNews() => go('/create-news');
  void goToEditNews(String newsId) => go('/edit-news/$newsId');
  void pushLogin() => push('/login');
  void pushRegister() => push('/register');
  void pushCreateNews() => push('/create-news');
  void pushEditNews(String newsId) => push('/edit-news/$newsId');
  void pushNewsDetail(String slug) => push('/news/$slug');
}
