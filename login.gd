extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print ("HTTP POST")
	#El login para la web 
	var query = "user=xxx@gmail.com&password=xxxx"
	#El header para que funcione
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	#Peticion
	$HttpPost.request("http://host:3000/api/v1/login",headers,false,HTTPClient.METHOD_POST,query);
	pass # Replace with function body.


func _on_HttpPost_request_completed(result, response_code, headers, body):
	#Si hace bien la peticion te crea un JSON parseado 
	if response_code==200:
		#creamos ruta fichero para guardarlo
		var save_path = "res://save.json"
		var datos = body.get_string_from_utf8()
		var json = JSON.parse(datos)
		var userId = json.result["data"]["userId"]
		var authToken = json.result["data"]["authToken"]
		var username = json.result["data"]["me"]["username"]
		print ("-----------UserId------------")
		print (userId)
		print ("-----------authToken----------")
		print (authToken)
		print (username)
		var file = File.new()
		file.open(save_path, File.WRITE)
		file.store_var(datos)
		file.close()
		get_tree().change_scene("res://inside/chatlist.tscn")
	else:
		print ("error ")	

	pass # Replace with function body.
