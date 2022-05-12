import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../bloc/popular_tvs_bloc/popular_tvs_bloc.dart';
import '../widgets/tv_card_vertical.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvs';

  const PopularTvsPage({Key? key}) : super(key: key);

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PopularTvsBloc>(context, listen: false)
        .add(FetchPopularTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(EvaIcons.arrowBack),
        ),
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvsBloc, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.listTv[index];
                  return TvCardVertical(tv);
                },
                itemCount: state.listTv.length,
              );
            } else if (state is PopularTvsError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
