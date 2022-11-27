import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';
import '../../2_application.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerBloc>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adviser',
          style: themeData.textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdvicerBloc, AdvicerState>(
                  builder: (BuildContext context, AdvicerState state) {
                    if (state is AdvicerInitial) {
                      return Text(
                        'Your advice is waiting for you!',
                        style: themeData.textTheme.headline1,
                      );
                    } else if (state is AdvicerLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdvicerLoaded) {
                      return AdviceField(advice: state.advice);
                    } else if (state is AdvicerError) {
                      return ErrorMessage(message: state.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                context.read<AdvicerBloc>().add(AdvicerRequestedEvent());
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
