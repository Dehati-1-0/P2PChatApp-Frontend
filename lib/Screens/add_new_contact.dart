import 'package:flutter/material.dart';

class AddNewContactPage extends StatefulWidget {
  @override
  _AddNewContactPageState createState() => _AddNewContactPageState();
}

class _AddNewContactPageState extends State<AddNewContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle saving contact information here
      Navigator.pop(context);
    }
  }

  void _navigateToQRCodePage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => QRCodePage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'New Contact',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        // Removed the actions list to get rid of the checkmark icon
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value ?? '';
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Public key',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the public key';
                            }
                            // Add more specific phone number validation if needed
                            return null;
                          },
                          onSaved: (value) {
                            _phoneNumber = value ?? '';
                          },
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 300,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: _saveForm,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1A2247),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 1,
                width: double.infinity,
                color: Color.fromARGB(61, 135, 136, 144).withOpacity(0.3),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(61, 135, 136, 144).withOpacity(0.3),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: _navigateToQRCodePage,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code,
                          color: Color(0xFF1A2247)), // QR code icon
                      SizedBox(width: 10), // Space between icon and text
                      Text(
                        "Add via QR code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A2247),
                          decoration: TextDecoration
                              .underline, // Optional: underline text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
