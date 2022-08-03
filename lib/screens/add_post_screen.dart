// ignore_for_file: unused_local_variable, prefer_const_constructors
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:new_life/providers/user_provider.dart';
import 'package:new_life/resources/firestore_methods.dart';
import 'package:new_life/utils/colors.dart';
import 'package:new_life/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );

      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        showSnackBar("Posted!", context);
        clearImage();
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(err.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title:  Text("Create a Post",style: TextStyle(fontFamily: 'Nutino'),),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a Photo",style: TextStyle(fontFamily: 'Nutino'),),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(
                  () {
                    _file = file;
                  },
                );
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choose from gallery",style: TextStyle(fontFamily: 'Nutino'),),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(
                  () {
                    _file = file;
                  },
                );
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child:  Text("Cancel",style: TextStyle(fontFamily: 'Nutino'),),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Using Provider: It will make just one call to Database that's why useful.
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return _file == null
        ? Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              color: Colors.white.withOpacity(0.2),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
        backgroundColor: Colors.black54.withOpacity(0.8),
        title: Text("Add Post",style: TextStyle(fontFamily: 'Nutino',fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
        centerTitle: true,
        
      ),
          body: Center(
              child: IconButton(
                iconSize: 250.0,
                onPressed: () => _selectImage(context),
                icon: SvgPicture.asset(
                  "assets/upload.svg",
                  //color: Theme.of(context).primaryColor,
                  height: 250,
                ),
              ),
            ),
        )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Post to",style: TextStyle(fontFamily: 'Nutino'),),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                      userProvider.getUser.uid,
                      userProvider.getUser.username,
                      userProvider.getUser.phototUrl),
                  child:  Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Nutino'
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(userProvider.getUser.phototUrl),
                    ),
                    // ignore: duplicate_ignore
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      // ignore: prefer_const_constructors
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          hintStyle: TextStyle(fontFamily: 'Nutino'),
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            // ignore: prefer_const_constructors
                            image: DecorationImage(
                              // ignore: prefer_const_constructors
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 2,
                  color: primaryColor,
                )
              ],
            ),
          );
  }
}
