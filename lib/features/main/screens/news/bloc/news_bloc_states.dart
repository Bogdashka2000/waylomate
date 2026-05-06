part of 'news_bloc.dart';

abstract class NewsFormState extends Equatable {
  const NewsFormState();
  List<Object?> get props => [];
}

class InitialState extends NewsFormState {}

class LoadingNewsState extends NewsFormState {
  const LoadingNewsState();
}

class NewsLoaded extends NewsFormState {
  final List<NewsModel> news;
  const NewsLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class LoadingNewsErrorState extends NewsFormState {
  final String error;
  const LoadingNewsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
