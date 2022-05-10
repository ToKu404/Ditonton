// import '../pages/tv_page.dart';
// import '../pages/watchlist_page.dart';
// import 'package:flutter/material.dart';

// import '../pages/about_page.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: AssetImage('assets/circle-g.png'),
//             ),
//             accountName: Text('Ditonton'),
//             accountEmail: Text('ditonton@dicoding.com'),
//           ),
//           ListTile(
//             leading: Icon(Icons.movie),
//             title: Text('Movies'),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.live_tv),
//             title: Text('Tv Shows'),
//             onTap: () {
//               Navigator.pushNamed(context, HomeTvPage.ROUTE_NAME);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.save_alt),
//             title: Text('Watchlist'),
//             onTap: () {
//               Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
//             },
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
//             },
//             leading: Icon(Icons.info_outline),
//             title: Text('About'),
//           ),
//         ],
//       ),
//     );
//   }
// }
