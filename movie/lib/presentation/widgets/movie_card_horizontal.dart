import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../pages/movie_detail_page.dart';

class MovieCardHorizontal extends StatelessWidget {
  const MovieCardHorizontal({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('movieCardKey'),
      width: 110,
      padding: const EdgeInsets.only(right: 8, bottom: 8, top: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.ROUTE_NAME,
            arguments: movie.id,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
