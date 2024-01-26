part of 'images_bloc.dart';

sealed class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class AddImages extends ImagesEvent {
  List<Images> listImg;
  AddImages(this.listImg);
}
