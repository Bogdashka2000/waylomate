import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/main/screens/feed/blocs/feed_bloc/feed_bloc.dart';
import 'package:waylomate/features/main/screens/news/bloc/news_bloc.dart';
import 'package:waylomate/features/main/screens/news/screens/news_reader.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<NewsFormBloc>().add(GetNewsEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NewsFormBloc>().add(GetNewsEvent());
        },
        child: BlocBuilder<NewsFormBloc, NewsFormState>(
          builder: (context, state) {
            if (state is LoadingNewsState) {
              return const Center(
                child: CircularProgressIndicator(
                  // color: Colors.white,
                  strokeWidth: 5,
                ),
              );
            } else if (state is NewsLoaded) {
              if (state.news.isEmpty) {
                return const Center(child: Text("Новостей нет"));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: state.news.length,
                  itemBuilder: (context, count) {
                    final text = state.news[count].text;
                    final shortText = text.length > 200
                        ? text.substring(0, 200)
                        : text;

                    return Padding(
                      padding: EdgeInsetsGeometry.all(7),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsReader(newsModel: state.news[count]),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.grey.shade500,
                            ),
                            color: const Color.fromARGB(255, 243, 242, 246),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                state.news[count].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${shortText}... Читать далее",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is LoadingNewsErrorState) {
              return Center(child: Text("${state.error}"));
            } else {
              return Center(child: Text("Произошла ошибка, повторите позже"));
            }
          },
        ),
      ),
    );
  }
}
