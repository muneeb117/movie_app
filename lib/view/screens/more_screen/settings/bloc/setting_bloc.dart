
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/view/screens/more_screen/settings/bloc/setting_state.dart';
import 'package:movie_app/view/screens/more_screen/settings/bloc/state_event.dart';

class SettingBlocs extends Bloc<SettingEvents,SettingStates>{
  SettingBlocs():super(const SettingStates()){
    on<TriggeredEvents>(_triggeredEvents);
  }
  _triggeredEvents(SettingEvents,Emitter<SettingStates>emit){
    emit(const SettingStates());
  }
}