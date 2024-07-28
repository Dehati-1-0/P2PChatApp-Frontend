import 'package:Dehati/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 10, 40, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discover",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Here',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    //first row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(61, 135, 136, 144)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/current_user.jpg'), // Replace with the current user's image
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Username', // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("User id") // Replace with the actual user id
                            ],
                          ),
                        ),
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(61, 135, 136, 144)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/current_user.jpg'), // Replace with the current user's image
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Username', // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("User id") // Replace with the actual user id
                            ],
                          ),
                        )
                      ],
                    ),
                    //second row
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(61, 135, 136, 144)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/current_user.jpg'), // Replace with the current user's image
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Username', // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("User id") // Replace with the actual user id
                            ],
                          ),
                        ),
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(61, 135, 136, 144)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/current_user.jpg'), // Replace with the current user's image
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Username', // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("User id") // Replace with the actual user id
                            ],
                          ),
                        )
                      ],
                    ),
                    //third row
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(61, 135, 136, 144)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/current_user.jpg'), // Replace with the current user's image
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Username', // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("User id") // Replace with the actual user id
                            ],
                          ),
                        ),
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(61, 135, 136, 144)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/current_user.jpg'), // Replace with the current user's image
                                radius: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Username', // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("User id") // Replace with the actual user id
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Color(0xFF1A2247),
          padding: EdgeInsets.symmetric(vertical: 10),
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.compass_calibration_outlined,
                    color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/discover');
                },
              ),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline, color: Colors.white),
                onPressed: () {
                  // Navigator.pushNamed(context, '/contacts');
                },
              ),
              IconButton(
                icon: Icon(Icons.person_2_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/contacts');
                },
              ),
            ],
          ),
        ));
  }
}
