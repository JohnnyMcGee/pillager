import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pillager/models/models.dart';
import 'package:pillager/services/services.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final String docId;
  final DatabaseService store;
  
  CommentBloc({required this.docId, required this.store}) : super(CommentInitial()) {

    store.getComments(docId).listen((comments) => add(CommentChange(comments)));
    
    on<CommentChange>((event, emit) => emit(CommentLoaded(event.comments)));
    on<SubmitComment>(_onSubmitComment);
  }

  void _onSubmitComment(SubmitComment event, Emitter emit) {
    final update = List<Comment>.from(state.comments)..add(event.comment);
    store.updateComments(docId, update);
    emit(CommentUpdating(state.comments));
  }
}
