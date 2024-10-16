import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/products/constants/color_constants.dart';
import 'package:instagram_clone/products/constants/string_constants.dart';
import 'package:instagram_clone/products/utils/utils.dart';
import 'package:instagram_clone/products/widgets/follow_button.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance.collection(StringConstants.users).doc(widget.uid).get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection(StringConstants.posts)
          .where(StringConstants.uid, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()![StringConstants.followers].length;
      following = userSnap.data()![StringConstants.following].length;
      isFollowing = userSnap.data()![StringConstants.followers].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstants.mobileBackgroundColor,
              title: Text(userData[StringConstants.username] ?? StringConstants.globalProfile),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorConstants.secondaryColor,
                            backgroundImage: userData[StringConstants.photoUrl] != null
                                ? NetworkImage(userData[StringConstants.photoUrl])
                                : const AssetImage('assets/default_avatar.png') as ImageProvider,
                            radius: 50,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(label: StringConstants.profilePosts, num: postLen),
                                    buildStatColumn(label: StringConstants.profileFollowers, num: followers),
                                    buildStatColumn(label: StringConstants.profileFollowing, num: following),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                                        ? FollowButton(
                                            text: StringConstants.profileSignOut,
                                            backgroundColor: ColorConstants.mobileBackgroundColor,
                                            textColor: ColorConstants.primaryColor,
                                            borderColor: ColorConstants.secondaryColor,
                                            function: () async {
                                              await AuthMethods().signOut();
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(builder: (context) => const LoginScreen()));
                                            },
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                text: StringConstants.profileUnfollow,
                                                backgroundColor: ColorConstants.primaryColor,
                                                textColor: ColorConstants.blackColor,
                                                borderColor: ColorConstants.secondaryColor,
                                                function: () async {
                                                  await FirestoreMethods().followUser(
                                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                                    followId: userData[StringConstants.uid],
                                                  );
                                                  setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                text: StringConstants.profileFollow,
                                                backgroundColor: ColorConstants.blueColor,
                                                textColor: ColorConstants.primaryColor,
                                                borderColor: ColorConstants.blueColor,
                                                function: () async {
                                                  await FirestoreMethods().followUser(
                                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                                    followId: userData[StringConstants.uid],
                                                  );
                                                  setState(() {
                                                    isFollowing = true;
                                                    followers++;
                                                  });
                                                },
                                              )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData[StringConstants.username] ?? StringConstants.profileNoUser,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          userData[StringConstants.bio] ?? StringConstants.profileNoBioAvailable,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection(StringConstants.posts)
                      .where(StringConstants.uid, isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(
                              snap[StringConstants.postUrl],
                            ),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
  }

  Column buildStatColumn({required int num, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: ColorConstants.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
