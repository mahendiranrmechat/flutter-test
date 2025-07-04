import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'browse.dart';

class QuranicWords extends StatefulWidget {
  const QuranicWords({Key? key}) : super(key: key);
  @override
  State<QuranicWords> createState() => _QuranicWordsState();
}

class _QuranicWordsState extends State<QuranicWords> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QURANIC WORDS',
              textAlign: TextAlign.center,
              textScaleFactor: 2,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Text(''),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "WORD",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "OCCURRENCES",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ]),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: databaseObject.getQuranicWords(),
              builder: (context, quranicWords) {
                if (quranicWords.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: quranicWords.data!.length,
                        itemBuilder: (context, j) {
                          return Container(
                            decoration: BoxDecoration(
                              color: j % 2 == 0
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Theme.of(context)
                                      .primaryColor
                                      .withAlpha(20),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: ListTile(
                              onTap: () async {
                                buildDefinitionAlert(
                                    context, quranicWords.data![j]['word']);
                              },
                              leading: Text(
                                '${j + 1} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withAlpha(100)),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    quranicWords.data![j]['word'],
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    quranicWords.data![j]['quran_occurrence']
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
