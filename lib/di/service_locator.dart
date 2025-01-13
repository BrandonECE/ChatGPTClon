import 'package:flutter_application_alon2/di/chat_service_locator.dart';
import 'package:flutter_application_alon2/di/message_service_locator.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  setupChatServiceLocator();
  setupMssageServiceLocator();
}
