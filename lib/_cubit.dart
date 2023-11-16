
import 'package:bloc/bloc.dart';
import 'package:proyecto_pro_movil/_state.dart';

class StringCubit extends Cubit<StringState> {
int counter = 0;
StringCubit() : super(StringLoading());


  void addData() {
  counter = counter + 1;
  emit(StringNew(data: counter.toString()));
  }
}
