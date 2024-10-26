import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_images/bloc/mars_events.dart';
import 'package:mars_images/bloc/mars_states.dart';
import 'package:mars_images/data/remote/app_repo.dart';
import 'package:mars_images/models/api_data_model.dart';

class MarsBloc extends Bloc<MarsEvent,MarsState>{
  AppRepo appRepo;
  MarsBloc({required this.appRepo}):super(InitialState()){

    on<GetImages>((event, emit)async{
      emit(LoadingState());
      try{
        var images = await appRepo.getImages();
        if(images != null){
          MarsModel photos = MarsModel.fromJson(images);
          emit(LoadedState(marsModel: photos));
        }else{
          emit(ErrorState(erroMsg: "No Data Loaded"));
        }
      }catch(e){
        emit(ErrorState(erroMsg: e.toString()));
      }
    });
  }
}