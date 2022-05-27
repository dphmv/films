import 'package:films/components/locals/locals.dart';
import 'package:films/presentation/catalog/catalog_page.dart';
import 'package:flutter/material.dart';

void showErrorDialog({BuildContext? context, required String error}) {
  final _context = context ?? CatalogPage.globalKey.currentContext;
  if (_context != null) {
    showDialog(
      context: _context,
      builder: (_) => ErrorDialog(error),
    );
  }
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
                      '${context.locale.error} ${error ?? context.locale.unknown}',
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
