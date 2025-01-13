import 'package:bloc/bloc.dart';
import 'package:flutter_application_alon2/domain/use_cases/get_all_chats_use_case.dart';
part 'api_request_drawer_event.dart';
part 'api_request_drawer_state.dart';

class ApiRequestDrawerBloc
    extends Bloc<ApiRequestDrawerEvent, ApiRequestDrawerState> {
  final GetAllChatsUseCase getAllChatsUseCase;
  ApiRequestDrawerBloc({required this.getAllChatsUseCase}) : super(ApiRequestDrawerInitial()) {
    on<ApiRequestDrawerLoadEvent>((event, emit) async {
      try {
        final response = await getAllChatsUseCase.getAllChats();
        if (response.statusCode == 200) {
          print("BIEEEEEEEEEEEEEN");
          emit(SuccessfulResponse());
        } else {
          print("FAIL, NO 200");
          emit(const ErrorResponse(message: "Conexion fallida (No es 200)"));
        }
      } catch (error) {
        print("ERRORRRR");
        emit(ErrorResponse(message: error.toString()));
      }
    });
  }
}



// class ApiRequestDrawerBloc
//     extends Bloc<ApiRequestDrawerEvent, ApiRequestDrawerState> {
//   final GetAllChatsUseCase getAllChatsUseCase;
//   ApiRequestDrawerBloc({required this.getAllChatsUseCase}) : super(ApiRequestDrawerInitial()) {
//     on<ApiRequestDrawerLoadEvent>((event, emit) async {
//       final url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
//       try {
//         final response = await http.get(url);
//         if (response.statusCode == 200) {
//           emit(SuccessfulResponse());
//         } else {
//           emit(const ErrorResponse(message: "Conexion fallida (No es 200)"));
//         }
//       } catch (error) {
//         emit(ErrorResponse(message: error.toString()));
//       }
//     });
//   }
// }
