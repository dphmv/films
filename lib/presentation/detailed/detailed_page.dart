import 'package:films/components/widgets/image_network.dart';
import 'package:flutter/material.dart';

class DetailedArguments {
  const DetailedArguments(
    this.id,
    this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
    this.description,
  );

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
}

class DetailedPage extends StatelessWidget {
  const DetailedPage({required this.arguments, Key? key}) : super(key: key);

  final DetailedArguments arguments;

  static const path = '/detailed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          arguments.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ImageNetwork(arguments.picture),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'Дата выхода: ${arguments.releaseDate}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 5),
                            child: Icon(
                              Icons.star,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Text(
                            arguments.voteAverage.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: arguments.voteAverage < 6
                                  ? Colors.red
                                  : arguments.voteAverage >= 8
                                      ? Colors.green
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      arguments.description,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Row(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       Flexible(
//         child: ImageNetwork(arguments.picture),
//         flex: 1,
//       ),
//       Flexible(
//         flex: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 arguments.title,
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Row(
//                   children: <Widget>[
//                     const Padding(
//                       padding: EdgeInsets.only(right: 8),
//                       child: Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                       ),
//                     ),
//                     Text(
//                       arguments.voteAverage.toStringAsFixed(1),
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: arguments.voteAverage < 4
//                             ? Colors.red
//                             : arguments.voteAverage >= 8
//                                 ? Colors.green
//                                 : Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16, bottom: 8),
//                 child: Text(
//                   'Дата выхода: ${arguments.releaseDate}',
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//               ),
//               Text(arguments.description),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
