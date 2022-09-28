import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/ui/auth/login_screen.dart';
import 'package:new_firebase/ui/posts/add_post.dart';
import 'package:new_firebase/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                }),
          )
        ],
      ),
      appBar: AppBar(
        title: Text("Post"),
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())))
                  .onError((error, stackTrace) =>
                      Utils().toastMessage(error.toString()));
            },
            icon: Icon(Icons.logout_outlined),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
      ),
    );
  }
}
