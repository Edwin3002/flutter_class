import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:gallery/models/images.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(ImagesState(listImages: const [])) {
    on<AddImages>(_addImages);
    // on<CounterReset>( _onCounterReset );
  }

  final dio =
      Dio(BaseOptions(baseUrl: 'https://api.unsplash.com/photos', headers: {
    'Authorization': "Client-ID Sc25Ae8RPZXDZCrVevWK94DyIBJow89Os4WAYEIrZrc",
  }));

  Future<void> _addImages(AddImages event, Emitter<ImagesState> emit) async {
    //   final response = await dio.get("");
    //   print(response);
    emit(state.copyWith(listImages: [...state.listImages, ...event.listImg]));
    print(state.listImages.length);
  }

  Future<void> getImages([int page = 1]) async {
    try {
      final response = await dio.get("/?page=$page");
      print(response.data);
      List<Images> newList = [];
      for (var element in response.data) {
        newList.add(ImagesMapper.jsonToEntity(element));
      }
      // add(AddImages([...newList, ...newList.reversed, ...newList]));
      add(AddImages([...newList]));
    } catch (e) {
      print(e);
    }
  }
}
