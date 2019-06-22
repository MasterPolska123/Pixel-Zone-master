extends Control
func _ready():
	DebugConsole.connect("login", self, "login_show")
	# Called every time the node is added to the scene.
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("game_ended", self, "_on_game_ended")
	gamestate.connect("game_error", self, "_on_game_error")
func login_show():
	$connect/Button.show()
func _on_host_pressed():
	if (get_node("connect/name").text == ""):
		get_node("connect/error_label").text="Invalid name!"
		return

	get_node("connect").hide()
	get_node("players").show()
	get_node("connect/error_label").text=""

	var player_name = get_node("connect/name").text
	gamestate.host_game(player_name)
	refresh_lobby()

func _on_join_pressed():
	if (get_node("connect/name").text == ""):
		get_node("connect/error_label").text="Invalid name!"
		return

	var ip = get_node("connect/ip").text
	if (not ip.is_valid_ip_address()):
		get_node("connect/error_label").text="Invalid IPv4 address!"
		return

	get_node("connect/error_label").text=""
	get_node("connect/host").disabled=true
	get_node("connect/join").disabled=true

	var player_name = get_node("connect/name").text
	gamestate.join_game(ip, player_name)
	# refresh_lobby() gets called by the player_list_changed signal

func _on_connection_success():
	get_node("connect").hide()
	get_node("players").show()

func _on_connection_failed():
	get_node("connect/host").disabled=false
	get_node("connect/join").disabled=false
	get_node("connect/error_label").set_text("Connection failed.")

func _on_game_ended():
	show()
	get_node("connect").show()
	get_node("players").hide()
	get_node("connect/host").disabled=false
	get_node("connect/join").disabled

func _on_game_error(errtxt):
	get_node("error").dialog_text = errtxt
	get_node("error").popup_centered_minsize()

func refresh_lobby():
	var players = gamestate.get_player_list()
	players.sort()
	get_node("players/list").clear()
	get_node("players/list").add_item(gamestate.get_player_name() + " (You)")
	for p in players:
		get_node("players/list").add_item(p)

	get_node("players/start").disabled=not get_tree().is_network_server()

func _on_start_pressed():
	gamestate.begin_game()


func _on_back_pressed():
	get_tree().change_scene("scenes/Main Menu/GUI.tscn")


func _on_back3_pressed():
	$connect.show()
	$players.hide()
func _process(delta):
#	var config = File.new()
#	if config.file_exists(str(documents)  + "/Pixel Zone/.data/user_config.save"):
	var load_name = $Control.load_name
	$connect/name.set_text(str(load_name))

func _on_Button_pressed():
	$Control.show()
	$Control/Control.show()
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)


func _on_signup_pressed():
	var config = File.new()
	var config2 = File.new()
	var config3 = File.new()
	config.open(str(documents)  + "/Pixel Zone/.data/user_name.save", File.WRITE)
	config.store_line(str($Control/Control2/VBoxContainer/name.text))
	config.close()
	config2.open(str(documents)  + "/Pixel Zone/.data/user_pass.save", File.WRITE)
	config2.store_line(str($Control/Control2/VBoxContainer/password.text))
	config2.close()
	config2.open(str(documents)  + "/Pixel Zone/.data/user_config.save", File.WRITE)
	$Control/Control2.hide()
	$Control/Control.show()