part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentChange extends CommentEvent {
  final List<Comment> comments;

  const CommentChange(this.comments);

  @override
  List<Object> get props => [comments];
}

class SubmitComment extends CommentEvent {
  final Comment comment;

  const SubmitComment(this.comment);

  @override
  List<Object> get props => [comment];
}

class DeleteComment extends CommentEvent {
  final Comment comment;

  const DeleteComment(this.comment);

  @override
  List<Object> get props => [comment];
}