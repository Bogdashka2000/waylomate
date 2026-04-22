import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/repositories/auth_content_repository.dart';
import 'package:waylomate/core/network/repositories/post_repository.dart';
import 'package:waylomate/features/authorization/presentation/blocs/login_sheet_bloc/bloc.dart';
import 'package:waylomate/features/authorization/presentation/blocs/registration_form_bloc/bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/post_bloc/post_bloc.dart';
import 'package:waylomate/waylomate_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  final dioClient = DioClient();
  await dioClient.init();
  final acr = AuthContentRepository(dioClient.dio);
  final postRepository = PostRepository(dioClient);
  final isLogged = await dioClient.hasToken();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DioClient>.value(value: dioClient),
        RepositoryProvider<AuthContentRepository>.value(value: acr),
        RepositoryProvider<PostRepository>.value(value: postRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginFormBloc>(create: (_) => LoginFormBloc(acr)),
          BlocProvider<RegistrationFormBloc>(
            create: (_) => RegistrationFormBloc(acr),
          ),
          BlocProvider<FeedFormBloc>(
            create: (_) => FeedFormBloc(postRepository),
          ),
          BlocProvider<PostFormBloc>(
            create: (_) => PostFormBloc(postRepository),
          ),
        ],
        child: WaylomateApp(isLogged: isLogged, acr: acr),
      ),
    ),
  );
}
