import 'package:flutter/material.dart';
import 'package:spacex_rockets/utils/style_resources/styles.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({required this.message, required this.retryFunction, super.key});

  final String message;
  final VoidCallback retryFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message, style: Styles.semiBoldStyleS,textAlign: TextAlign.center,),
          ElevatedButton(
            onPressed: retryFunction,
            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.purple)),
            child: Text("Retry",style: Styles.boldStyleM.copyWith(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
