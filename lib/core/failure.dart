// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure {
  final String msg;
  const Failure({required this.msg});
}

class ServerFailure extends Failure{
  ServerFailure({required super.msg});
}