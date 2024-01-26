import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/bloc/images_bloc.dart';
import 'package:gallery/models/images.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ImagesBloc(), child: const GalleryGrid());
  }
}

class GalleryGrid extends StatefulWidget {
  const GalleryGrid({
    super.key,
  });
  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  int page = 1;
  bool isLoading = false;

  void getGallery() {
    if (isLoading) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        isLoading = false;
        setState(() {});
      });
      return;
    }
    isLoading = true;
    page++;
    context.read<ImagesBloc>().getImages(page);
    setState(() {});
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getGallery();
    scrollController.addListener(() {
      if (scrollController.position.pixels + 5 >
          scrollController.position.maxScrollExtent) {
        getGallery();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Images> galleryList =
        context.select((ImagesBloc bloc) => bloc.state.listImages);
    return SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          const SliverAppBar(
            floating: true,
            title: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 15),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Filtro",
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return SizedBox(
                height: galleryList.length < 30
                    ? 700
                    : 30 * galleryList.length.toDouble(),
                child: GridView.count(
                  padding: const EdgeInsets.all(10),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children:
                      //   ListView.builder(
                      //     itemCount: galleryList.length,
                      //     itemBuilder: (context, index) {
                      //       final img = galleryList[index];
                      //       return Text(img.description);
                      //     },
                      //   )
                      List.generate(galleryList.length, (index) {
                    final img = galleryList[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        height: 250,
                        fadeOutDuration: const Duration(milliseconds: 100),
                        fadeInDuration: const Duration(milliseconds: 200),
                        image: NetworkImage(img.urls.small),
                        placeholder: const NetworkImage(
                            "https://i0.wp.com/css-tricks.com/wp-content/uploads/2017/08/card-skeleton@2x.png?w=300&ssl=1"),
                      ),
                    );
                  }),
                ),
                //   ListView.builder(
                //     keyboardDismissBehavior:
                //         ScrollViewKeyboardDismissBehavior.onDrag,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: 100,
                //     itemBuilder: (context, index) {
                //       return Text("f");
                //     },
                //   ),
              );
            },
          )),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Center(
                  child: isLoading ? CircularProgressIndicator() : null);
            },
          ))
        ],
      ),
    );
  }
}
