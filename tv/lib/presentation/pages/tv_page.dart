import 'package:core/common/constants.dart';

import '../bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';
import '../bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import '../bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/tv_card_horizontal.dart';
import 'top_rated_tvs_page.dart';
import 'package:flutter/material.dart';


import '../../domain/entities/tv.dart';
import 'on_the_air_tvs_page.dart';
import 'popular_tvs_page.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);
  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnTheAirTvsBloc>(context, listen: false)
        .add(FetchOnTheAirTvs());
      BlocProvider.of<TopRatedTvsBloc>(context, listen: false)
        .add(FetchTopRatedTvs());
      BlocProvider.of<PopularTvsBloc>(context, listen: false)
        .add(FetchPopularTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          _buildSubHeading(
            title: 'On The Air',
            onTap: () =>
                Navigator.pushNamed(context, OnTheAirTvsPage.ROUTE_NAME),
          ),
          BlocBuilder<OnTheAirTvsBloc, OnTheAirTvsState>(
            builder: ((context, state) {
              if (state is OnTheAirTvLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is OnTheAirTvHasData) {
                return TvList(state.listTv);
              } else {
                return const SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: Text('Failed')));
              }
            }),
          ),
          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
          ),
          BlocBuilder<PopularTvsBloc, PopularTvsState>(
            builder: ((context, state) {
              if (state is PopularTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is PopularTvsHasData) {
                return TvList(state.listTv);
              } else {
                return const SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: Text('Failed')));
              }
            }),
          ),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
          ),
          BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
            builder: ((context, state) {
              if (state is TopRatedTvsLoading) {
                return const SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TopRatedTvsHasData) {
                return TvList(state.listTv);
              } else {
                return const SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: Text('Failed')));
              }
            }),
          ),
        ],
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              EvaIcons.arrowIosForward,
              size: 20,
              color: kDavysGrey,
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return TvCardList(tv: tv);
        },
        itemCount: tvs.length,
      ),
    );
  }
}
