import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Eight7/card.dart';
import 'package:Eight7/core.dart';
import 'package:Eight7/providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            ChipsChoice<int>.single(
              value: ref.watch(number),
              onChanged: (val) =>
                  setState(() => ref.watch(number.notifier).state = val),
              choiceItems: C2Choice.listFrom<int, String>(
                source: cate,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 100),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ref
                  .watch(getproductsFutureProvider(ref.watch(number) + 1))
                  .when(
                      data: (data) {
                        return GridView.builder(
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return displayCard(data: data[index]);
                            });
                      },
                      error: (error, st) {
                        return Center(
                          child: Text(error.toString()),
                        );
                      },
                      loading: () => const CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
