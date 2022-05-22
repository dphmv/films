import 'package:films/components/constants.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, {required String error}) {
  showDialog(
    context: context,
    builder: (_) => ErrorDialog(error),
  );
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.error, {Key? key}) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CloseButton(color: Colors.white),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${FilmLocal.error} ${error ?? FilmLocal.unknown}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
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
