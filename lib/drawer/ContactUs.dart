import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class ContactUss extends StatefulWidget {

  @override
  State<ContactUss> createState() => _ContactUssState();
}

class _ContactUssState extends State<ContactUss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Mikhail and Doha',
        textColor: Colors.white,
        backgroundColor: Colors.teal.shade300,
        email: 'mikhail10@gmail.com',
        // textFont: 'Sail',
      ),
      backgroundColor: Colors.white70,
      body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: AssetImage('assets/images/contactus.jpg'),
          email: 'mikhail10@gmail.com',
          companyName: 'Mikhail and Doha',
          companyColor: Colors.teal.shade100,
          dividerThickness: 2,
          phoneNumber: '+90930117364',
          website: 'https://michael.godaddysites.com',
          githubUserName: 'doha26',
          linkedinURL:
          'https://www.linkedin.com/in/Mikhail4040-520983199/',
          tagLine: 'Flutter Developer',
          taglineColor: Colors.teal.shade100,
          instagram: 'mikhail_Ibrahim',
          facebookHandle: 'michael ibrahim'


      ),
    );
  }
}