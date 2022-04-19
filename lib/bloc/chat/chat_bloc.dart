import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:variable/model/user.dart';
import 'package:variable/service/Firebase/auth.dart';
import 'package:variable/service/Firebase/curd_user_database.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is ChatStatusEvent) {
        emit(CreateCoupleLoadingState());
        bool value = event.user.chat.any((element) =>
            element.couple == FirebaseAuthenticationService.user.uid);
        if (value) {
          for (var item in event.user.chat) {
            if (item.couple == FirebaseAuthenticationService.user.uid) {
              emit(
                CreatedCoupleState(
                  chatID: item.chatid,
                ),
              );
            }
          }
        } else {
          String id = await FirebaseDatabaseCollection.createChatForUser(
            event.user.uid,
          );
          emit(
            CreatedCoupleState(
              chatID: id,
            ),
          );
        }
      }
    });
  }
}
