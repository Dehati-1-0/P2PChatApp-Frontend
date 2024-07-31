import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserProfilePage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  UserProfilePage({required this.userName, required this.userAvatar});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late String _currentUserName;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _currentUserName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Contact info',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(widget.userAvatar),
                            radius: 30,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _isEditing
                              ? Expanded(
                                  child: TextFormField(
                                    initialValue: _currentUserName,
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _currentUserName = value;
                                      });
                                    },
                                  ),
                                )
                              : Text(
                                  _currentUserName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                          if (!_isEditing)
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                            ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color:
                            Color.fromARGB(61, 135, 136, 144).withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ID",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("PPSSJN123"), // Replace with the actual user ID
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: QrImageView(
                          data: "PPSSJN123", // Replace with the actual ID
                          version: QrVersions.auto,
                          size: 150.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_isEditing)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentUserName.isNotEmpty) {
                                // Save the new username
                                setState(() {
                                  _isEditing = false;
                                });
                              }
                            },
                            child: Text(
                              'Save',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1A2247),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
