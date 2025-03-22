import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_cubit.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/widgets/retry_widget.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/widgets/rocket_card.dart';

class RocketList extends StatefulWidget {
  const RocketList({super.key});

  @override
  State<RocketList> createState() => _RocketListState();
}

class _RocketListState extends State<RocketList> {
  @override
  void initState() {
    super.initState();
    context.read<RocketCubit>().getAllRockets();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RocketCubit, RocketState>(
      listener: (context, state) {
        if (state is RocketLoadError) {
          print("error: ${state.message}");
        }
      },
      builder: (context, state) {
        return state is RocketLoaded
            ? ListView.builder(
                itemCount: state.rockets.length,
                itemBuilder: (context, index) => RocketCard(
                  id: state.rockets[index].id,
                  name: state.rockets[index].name,
                  country: state.rockets[index].country,
                  engines: state.rockets[index].engineCount,
                  imageUrl: state.rockets[index].flickerImages[0],
                ),
              )
            : state is RocketLoadError
                ? RetryWidget(
                    message: state.message,
                    retryFunction: () =>
                        context.read<RocketCubit>().getAllRockets())
                : const Center(
                    child: CircularProgressIndicator(),
                  );
      },
    );
  }
}
