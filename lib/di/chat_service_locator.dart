import 'package:flutter_application_alon2/di/service_locator.dart';
import 'package:flutter_application_alon2/domain/repositories/chat_repository.dart';
import 'package:flutter_application_alon2/domain/services/chat_services.dart';
import 'package:flutter_application_alon2/domain/use_cases/get_all_chats_use_case.dart';
import 'package:flutter_application_alon2/infraestructure/repositories/chat_repository_impl.dart';
import 'package:flutter_application_alon2/infraestructure/services/chat_services_impl.dart';

void setupChatServiceLocator() {
  getIt.registerLazySingleton<ChatServices>(
    () => ChatServicesImpl(),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(chatServices: getIt<ChatServices>()),
  );
  getIt.registerLazySingleton<GetAllChatsUseCase>(
    () => GetAllChatsUseCase(chatRepository: getIt<ChatRepository>()),
  );
}
