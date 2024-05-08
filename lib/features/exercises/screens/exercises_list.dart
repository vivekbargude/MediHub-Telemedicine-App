import 'package:flutter/material.dart';
import 'package:medihub/features/exercises/services/exercise_services.dart';
import 'package:medihub/models/exercise.dart';
import 'package:medihub/utils/helper.dart';

class ExerciseList extends StatefulWidget {
  static const String routeName = "/exercises-list";
  final String keyword;

  const ExerciseList({Key? key, required this.keyword}) : super(key: key);

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  List<Exercise>? exerciseList;
  final ExerciseServices exerciseServices = ExerciseServices();

  @override
  void initState() {
    super.initState();
    fetchExerciseList(widget.keyword);
  }

  void fetchExerciseList(String keyword) async {
    List<Exercise> exercises = await exerciseServices.fetchExercises(keyword, apiKey);
    setState(() {
      exerciseList = exercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Exercises List"),
      ),
      body: exerciseList == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exerciseList!.length,
              itemBuilder: (context, index) {
                return ExerciseListItem(
                  index: index + 1,
                  exercise: exerciseList![index],
                );
              },
            ),
    );
  }
}

class ExerciseListItem extends StatefulWidget {
  final int index;
  final Exercise exercise;

  const ExerciseListItem({Key? key, required this.index, required this.exercise}) : super(key: key);

  @override
  _ExerciseListItemState createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ExpansionTile(
        leading: Text(
          '${widget.index}',
          style: const TextStyle(fontSize: 16),
        ),
        title: Text(widget.exercise.name!),
        children: [
          ListTile(
            title: Text('Type: ${widget.exercise.type}'),
          ),
          ListTile(
            title: Text('Equipment: ${widget.exercise.equipment}'),
          ),
          ListTile(
            title: Text('Instructions: ${widget.exercise.instructions}'),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            _expanded = expanded;
          });
        },
        initiallyExpanded: _expanded,
      ),
    );
  }
}
