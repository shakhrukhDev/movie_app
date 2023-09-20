import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie/bloc/movie_bloc.dart';
import 'package:movie_app/features/movie/detail/detail_page.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff15141F),
      appBar: AppBar(
        title: const Text(
          'MOVIES',
          style: TextStyle(fontSize: 25.0, color: Color(0xfff43370)),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xff191826),
      ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if(state.movies != null){
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.movies?.docs?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: (1 / 2),
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DetailPage()),
                        );
                        context.read<MovieBloc>().add(GetMovieIdEvent(
                            state.movies?.docs?[index].id.toString() ?? ''));
                      },
                      child: Card(
                        color: const Color(0xff15141F),
                        elevation: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              state.movies?.docs?[index].poster?.previewUrl ?? "",
                              fit: BoxFit.fill,
                            ),
                            Text(
                              'Название: ${state.movies?.docs?[index].name ?? ''}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Год: ${state.movies?.docs?[index].year ?? ''}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Рейтинг: ${state.movies?.docs?[index].rating?.imdb ?? ''}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }
}
