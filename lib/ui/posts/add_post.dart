import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/ui/widgets/round_button.dart';
import 'package:new_firebase/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: "What's in your mind",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: loading,
                title: "Add",
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  databaseRef
                      .child(DateTime.now().microsecondsSinceEpoch.toString())
                      .set({
                    'title': postController.text.toString(),
                    'id': DateTime.now().microsecondsSinceEpoch.toString(),
                  }).then((value) {
                    Utils().toastMessage('Post Has been added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
