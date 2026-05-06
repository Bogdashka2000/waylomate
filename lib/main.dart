import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/repositories/auth_content_repository.dart';
import 'package:waylomate/core/network/repositories/comments_repository.dart';
import 'package:waylomate/core/network/repositories/news_repository.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';
import 'package:waylomate/core/network/repositories/user_repository.dart';
import 'package:waylomate/features/authorization/presentation/blocs/login_sheet_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:waylomate/features/main/bloc/main_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/post_bloc/post_bloc.dart';
import 'package:waylomate/features/main/screens/messages/bloc/chat_bloc.dart';
import 'package:waylomate/features/main/screens/messages/service/chat_service.dart';
import 'package:waylomate/features/main/screens/news/bloc/news_bloc.dart';
import 'package:waylomate/features/main/screens/subs/bloc/subs_bloc.dart';
import 'package:waylomate/waylomate_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  final dioClient = DioClient();
  await dioClient.init();
  final acr = AuthContentRepository(dioClient);
  final postRepository = PostRepository(dioClient);
  final userRepository = UserRepository(dioClient);
  final commentRepository = CommentRepository(dioClient);
  final newsRepository = NewsRepository(dioClient);
  final isLogged = await dioClient.hasToken();

  final chatService = ChatService(
    dioClient: dioClient,
    baseUrl: 'ws://${dotenv.env['SERVER']}:${dotenv.env['PORT']}',
    cookieName: 'user_token',
    httpDomain: 'http://${dotenv.env['SERVER']}:${dotenv.env['PORT']}',
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioClient>.value(value: dioClient),
        RepositoryProvider<AuthContentRepository>.value(value: acr),
        RepositoryProvider<PostRepository>.value(value: postRepository),
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<CommentRepository>.value(value: commentRepository),
        RepositoryProvider<NewsRepository>.value(value: newsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ChatBloc(chatService: chatService)),
          BlocProvider<LoginFormBloc>(create: (_) => LoginFormBloc(acr)),
          BlocProvider<RegistrationFormBloc>(
            create: (_) => RegistrationFormBloc(acr),
          ),
          BlocProvider<FeedFormBloc>(
            create: (_) => FeedFormBloc(postRepository),
          ),
          BlocProvider<PostFormBloc>(
            create: (_) => PostFormBloc(userRepository, postRepository),
          ),
          BlocProvider<SubsFormBloc>(
            create: (_) => SubsFormBloc(userRepository),
          ),
          BlocProvider<MainFormBloc>(
            create: (_) => MainFormBloc(userRepository),
          ),
          BlocProvider<NewsFormBloc>(
            create: (_) => NewsFormBloc(newsRepository),
          ),
        ],
        child: WaylomateApp(isLogged: isLogged, acr: acr),
      ),
    ),
  );
}
