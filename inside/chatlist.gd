extends Node2D
var path = "res://save.json"
var file = File.new()
var userId
var authToken 
var username
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print ("Estamos dentro")
	file.open(path, file.READ)
	var datos = file.get_as_text()
	var json = JSON.parse(datos)
	userId = json.result["data"]["userId"]
	authToken = json.result["data"]["authToken"]
	username = json.result["data"]["me"]["username"]
	file.close()
	print (userId)
	print (authToken)
	print (username)
	#Ponemos el nombre del chat con el ultimo mernsaje
	
	
	pass # Replace with function body.
func _process(delta):
	#El header para que funcione
	var query = ""
	var headers = ["X-Auth-Token: "+authToken,
	"X-User-Id: "+userId]
	#Peticion
	$Http.request("http://35.202.176.87:3000/api/v1/channels.list",headers,false);
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#Bucle infinito



func _on_Button_pressed():
	#abrimos
	print ("hola",username)
	#print (data)
	pass # Replace with function body.


func _on_TextEdit_text_changed():
	pass # Replace with function body.


func _on_Http_request_completed(result, response_code, headers, body):
	var datos = body.get_string_from_utf8()
	var json = JSON.parse(datos)
	#print(json.result)
	if response_code==200:
		#el array del json el 0 al n (n es numero de canaleS) nombre del canal 
		#print(json.result["channels"][0]["lastMessage"]["u"]["username"])
		var mensaje = json.result["channels"][0]["lastMessage"]["msg"]
		var usuario = json.result["channels"][0]["lastMessage"]["u"]["username"]
		$usuario.text = usuario 
		$mensaje.text = mensaje
	else:
		get_tree().change_scene("res://inside/chatlist.tscn")
	pass # Replace with function body.
