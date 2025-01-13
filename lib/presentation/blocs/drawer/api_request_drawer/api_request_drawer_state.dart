part of 'api_request_drawer_bloc.dart';

sealed class ApiRequestDrawerState {
  const ApiRequestDrawerState();
}

final class ApiRequestDrawerInitial extends ApiRequestDrawerState {}

final class SuccessfulResponse extends ApiRequestDrawerState {}

final class ErrorResponse extends ApiRequestDrawerState {
  final String message;
  const ErrorResponse({required this.message});
}