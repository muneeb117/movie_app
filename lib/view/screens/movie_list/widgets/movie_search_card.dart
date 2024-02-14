
import 'package:flutter/material.dart';

import '../../../../models/movie_model.dart';
import '../../../../utils/colors_list.dart';
import '../../movie_detail_screen/movie_detail_screen.dart';

class MovieSearchCard extends StatelessWidget {
  final Movie movie;
  final String imageUrlBase = 'https://image.tmdb.org/t/p/w500';

  const MovieSearchCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String genreDisplayText = movie.genres.isNotEmpty
        ? movie.genres.map((e) => e.name).join(', ')
        : 'Genre Not Available';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movie: movie,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:BorderRadius.circular(10),
                  child: Image.network(
                    imageUrlBase + movie.posterPath,
                    width: 140,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const  SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const  SizedBox(height: 4),
                      Text(
                        genreDisplayText,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz,color: fillColor,),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
