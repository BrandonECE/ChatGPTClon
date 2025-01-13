import 'package:flutter_application_alon2/di/service_locator.dart';
import 'package:flutter_application_alon2/domain/repositories/message_repository.dart';
import 'package:flutter_application_alon2/domain/services/message_services.dart';
import 'package:flutter_application_alon2/domain/use_cases/send_message_use_case.dart';
import 'package:flutter_application_alon2/infraestructure/repositories/message_repository_impl.dart';
import 'package:flutter_application_alon2/infraestructure/services/messages_services_impl.dart';

void setupMssageServiceLocator() {
  getIt.registerLazySingleton<MessageService>(() => MessageServiceImpl());
  getIt.registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(messageService: getIt<MessageService>()));
  getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(repository: getIt<MessageRepository>()));
}
