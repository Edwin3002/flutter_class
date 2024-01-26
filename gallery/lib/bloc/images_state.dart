part of 'images_bloc.dart';

class ImagesState extends Equatable {
  final List<Images> listImages;

  ImagesState({required this.listImages});

  ImagesState copyWith({List<Images>? listImages}) => ImagesState(
        listImages: listImages ?? this.listImages,
      );

  @override
  List<Object> get props => [listImages];
}