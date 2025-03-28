import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Function to handle Google Sign-In
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // Start the Google Sign-In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled login

      // Obtain authentication details from Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential using the token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // User successfully signed in, you can retrieve their details:
      final User? user = userCredential.user;

      // Save user authentication state (if needed)
      // Firebase automatically handles user sessions, but you can store details locally if required.

      return userCredential;
    } catch (error) {
      print("Google Sign-In Error: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              '', // Provide your logo image path here
              height: 120,
            ),
            SizedBox(height: 16),

            // Tagline
            Text(
              "Your training starts here.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Spacer(),

            // Google Sign-In Button
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3,
                ),
                onPressed: () async {
                  UserCredential? user = await _signInWithGoogle();
                  if (user != null) {
                    print("Signed in as: ${user.user?.displayName}");
                    // Navigate to the next screen (e.g., HomeScreen)
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/google_logo.png', // Add a Google logo in assets
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
