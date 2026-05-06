import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/core/network/models/news_model/news_model.dart';
import 'package:waylomate/core/network/repositories/news_repository.dart';

part 'news_bloc_events.dart';
part 'news_bloc_states.dart';

class NewsFormBloc extends Bloc<NewsFormEvent, NewsFormState> {
  final NewsRepository newsRepository;
  NewsFormBloc(this.newsRepository) : super(InitialState()) {
    on<GetNewsEvent>(_onGetNews);
  }

  Future<void> _onGetNews(
    GetNewsEvent event,
    Emitter<NewsFormState> emit,
  ) async {
    emit(const LoadingNewsState());

    try {
      final result = await newsRepository.getNews();
      emit(NewsLoaded(result));
    } catch (error) {
      emit(LoadingNewsErrorState(error.toString()));
    }
  }
}
