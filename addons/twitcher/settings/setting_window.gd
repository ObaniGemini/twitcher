@tool
extends Control

const Token = preload("res://addons/twitcher/lib/oOuch/token.gd")
const TOKEN_INFO = preload("res://addons/twitcher/settings/token_info.tscn")

@onready var client_id_input: LineEdit = %ClientIdInput
@onready var client_secret_input: LineEdit = %ClientSecretInput
@onready var flow_input: OptionButton = %FlowInput
@onready var client_info: GridContainer = %ClientInfo

var _token_infos: Array[Node] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	client_id_input.text_changed.connect(_on_client_id_changed)
	client_secret_input.text_changed.connect(_on_client_secret_changed)
	flow_input.item_focused.connect(_on_flow_changed)
	flow_input.item_selected.connect(_on_flow_changed)

	client_id_input.text = TwitchSetting.client_id
	client_secret_input.text = TwitchSetting.client_secret
	_select_flow(TwitchSetting.authorization_flow)


func _on_client_id_changed(new_text: String) -> void:
	TwitchSetting.client_id = new_text


func _on_client_secret_changed(new_text: String) -> void:
	TwitchSetting.client_secret = new_text


func _on_flow_changed(index: int) -> void:
	match index:
		0: TwitchSetting.authorization_flow = TwitchSetting.FLOW_AUTHORIZATION_CODE
		1: TwitchSetting.authorization_flow = TwitchSetting.FLOW_DEVICE_CODE_GRANT
		2: TwitchSetting.authorization_flow = TwitchSetting.FLOW_IMPLICIT
		3: TwitchSetting.authorization_flow = TwitchSetting.FLOW_CLIENT_CREDENTIALS


func _select_flow(selected_flow: String) -> void:
	match selected_flow:
		TwitchSetting.FLOW_AUTHORIZATION_CODE: flow_input.select(0)
		TwitchSetting.FLOW_DEVICE_CODE_GRANT: flow_input.select(1)
		TwitchSetting.FLOW_IMPLICIT: flow_input.select(2)
		TwitchSetting.FLOW_CLIENT_CREDENTIALS: flow_input.select(3)
