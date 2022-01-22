part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  final List<Comment> comments;
  CommentState([comments]) : comments= comments ?? <Comment>[];

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoaded extends CommentState {
  CommentLoaded(comments) : super(comments);

  @override
  List<Object> get props => [comments];
}

class CommentUpdating extends CommentState {
  CommentUpdating(comments) : super(comments);

  @override
  List<Object> get props => [comments];
}
