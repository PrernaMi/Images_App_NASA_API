import 'package:mars_images/models/api_data_model.dart';

abstract class MarsState{}

class InitialState extends MarsState{}
class LoadingState extends MarsState{}
class LoadedState extends MarsState{
  MarsModel marsModel;
  LoadedState({required this.marsModel});
}
class ErrorState extends MarsState{
  String erroMsg;
  ErrorState({required this.erroMsg});
}