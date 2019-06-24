extends Node

onready var Auth = HTTPRequest.new()
onready var Database = Node.new()
onready var Firestore = Node.new()
onready var Storage = HTTPRequest.new()

onready var config = {
    "apiKey": "AIzaSyD8_6IBQeP8DZKCOa5YLhDkqkFRLdgqHqY",
    "authDomain": "pixel-zone-8d8e4.firebaseapp.com",
    "databaseURL": "https://pixel-zone-8d8e4.firebaseio.com",
    "projectId": "pixel-zone-8d8e4",
    "storageBucket": "pixel-zone-8d8e4.appspot.com",
    "messagingSenderId": "1078122097377",
    "appId": "1:1078122097377:web:4c123f6c5f212952"
  }

func _ready():
    Auth.set_script(preload("res://addons/GDFirebase/FirebaseAuth.gd"))
    Database.set_script(preload("res://addons/GDFirebase/FirebaseDatabase.gd"))
    Firestore.set_script(preload("res://addons/GDFirebase/FirebaseFirestore.gd"))
    Storage.set_script(preload("res://addons/GDFirebase/FirebaseStorage.gd"))
    Auth.set_config(config)
    Database.set_config(config)
    Firestore.set_config(config)
    Storage.set_config(config)
    add_child(Auth)
    add_child(Database)
    add_child(Firestore)
    add_child(Storage)
    Auth.connect("login_succeeded", Database, "_on_FirebaseAuth_login_succeeded")
    Auth.connect("login_succeeded", Firestore, "_on_FirebaseAuth_login_succeeded")
    Auth.connect("login_succeeded", Storage, "_on_FirebaseAuth_login_succeeded")