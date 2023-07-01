import 'package:bloc_practicing/cubit/names_cubit.dart';
import 'package:flutter/material.dart';
import '/constants/people.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final NamesCubit cubit;
  Color screenColor = Colors.white;
  late AnimationController _animationController;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        shadowColor: Colors.blue,
      ),
      body: Center(
        child: StreamBuilder<StateChanger?>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final button = SizedBox(
              width: 100,
              child: FloatingActionButton(
                  onPressed: () {
                    cubit.pickTextAndChangeColor();
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              color: Colors.green.shade500),
                        ]),
                    child: const Center(
                        child: Text(
                      'Pick a name',
                      style: TextStyle(color: Colors.white),
                    )),
                  )),
            );
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;
              case ConnectionState.waiting:
                return button;
              case ConnectionState.active:
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: cubit.color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    const Center(
                                        child: Text(
                                      'Change Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                      ),
                                    )),
                                    AlertDialog(
                                      actions: [
                                        for (var i = 0;
                                            i < People.names.length;
                                            ++i)
                                          Center(
                                              child: TextButton(
                                            onPressed: () {
                                              cubit.pickTextAndChangeColor(
                                                  chosenName: People.names[i]);
                                              print('${cubit.name}');
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                People.names[i],
                                                style: TextStyle(
                                                  color: cubit.color !=
                                                          Colors.white
                                                      ? cubit.color
                                                      : Colors.teal.shade400,
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        },
                        onPressed: () {
                          /// this property just required, just required!;
                        },
                        child: Text(
                          cubit.name!,
                          style: TextStyle(
                            shadows: const <Shadow> [
                              Shadow(
                                offset: Offset(6.0, 4.0,),
                                blurRadius: 3.0,
                                color: Colors.white24,
                              ),
                            ],
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: cubit.color == Colors.white
                                  ? Colors.grey.shade500
                                  : Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      button,
                    ],
                  ),
                );
              case ConnectionState.done:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
