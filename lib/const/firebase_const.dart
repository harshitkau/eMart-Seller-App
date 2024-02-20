import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

User? currentUser = auth.currentUser; //all data will be get from this variable

// collections
const vendorCollection = "vendor";
const productsCollection = "products";
const chatsCollection = "chats";
const messagesCollection = "messages";
const orderCollection = "orders";
