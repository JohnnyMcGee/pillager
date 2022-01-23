import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final String docId;
  final DatabaseService store;
  late final StreamSubscription _comments;

  CommentBloc({required this.docId, required this.store})
      : super(CommentInitial()) {
    _comments = store
        .getComments(docId)
        .listen((comments) => add(CommentChange(comments)));

    on<CommentChange>((event, emit) => emit(CommentLoaded(event.comments)));
    on<SubmitComment>(_onSubmitComment);
    on<DeleteComment>(_onDeleteComment);
  }

  void _onSubmitComment(SubmitComment event, Emitter emit) {
    final update = List<Comment>.from(state.comments)..add(event.comment);
    store.updateComments(docId, update);
    emit(CommentUpdating(state.comments));
  }

  void _onDeleteComment(DeleteComment event, Emitter emit) {
    final update = List<Comment>.from(state.comments)..removeWhere((comment) => comment == event.comment);
    store.updateComments(docId, update);
    emit(CommentUpdating(state.comments));
  }

  @override
  Future<void> close() {
    _comments.cancel();
    return super.close();
  }
}
