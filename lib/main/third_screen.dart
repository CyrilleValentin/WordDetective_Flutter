import 'package:flutter/material.dart';
class Compte extends StatefulWidget {
  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Styled Input Form')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Hide the keyboard when tapping outside the input field
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12), // Adjust the horizontal padding
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Email: $_email');
    }
  }
}
