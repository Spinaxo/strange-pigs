extends Control

var prompt_1 = 'You are a character in a game and the player has just walked up to you. Say something completely out of pocket and confusing. Keep it to 1 or 2 sentences. Featuring absurd humor with a hint of social commentary. Use puns, wordplay, and pop-culture references. Aim for a lighthearted and humorous tone while maybe injecting a touch of satire or critique of societal norms. It can be a bit uncanny but dont overdo it. Dont greet the player just go straight into whatever you want to say.'



var test_url = "https://jsonplaceholder.typicode.com/posts"
var url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAHU0QFwMjfzBeFCdsKal2ML3Phm5nsa98"
var headers = ["Content-Type: application/json"]
var body = {
		"contents": [{
			"parts":[
				{"text": prompt_1}
			]
		}],
		"safety_settings": [
	  {
		"category": "HARM_CATEGORY_HARASSMENT",
		"threshold": "BLOCK_NONE"
	  },
	  {
		"category": "HARM_CATEGORY_HATE_SPEECH",
		"threshold": "BLOCK_NONE"
	  },
	  {
		"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
		"threshold": "BLOCK_NONE"
	  },
	  {
		"category": "HARM_CATEGORY_DANGEROUS_CONTENT",
		"threshold": "BLOCK_NONE"
	  },
	],
		"generationConfig": {
			"stopSequences": [
				"Title"
			],
			"temperature": 1.0,
			"maxOutputTokens": 800,
			"topP": 0.8,
			"topK": 10
		}
	}
var json_body = JSON.stringify(body)


func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	var response_text = json["candidates"][0]["content"]["parts"][0]["text"]
	$RichTextLabel.text = response_text


func _process(delta):
	if Input.is_action_just_pressed("Space"):
		print("Requesting...")
		$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json_body)
