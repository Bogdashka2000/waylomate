part of 'news_bloc.dart';

abstract class NewsFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsFormEvent {
  GetNewsEvent();
}
