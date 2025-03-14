@icon("res://mpc-addons/packrtc-mpc/PackRTCProtocol.svg")
extends MPNetProtocolBase
class_name PackRTCProtocol

## PackRTC's unique channel name
@export var game_channel: String = "none"

## On PackRTC error occurred
signal on_error(err: String)
## On PackRTC code received
signal on_code(code: String)

## Debug URL Override
func _override_debug_url(bind_ip: String, port: int):
	return "TEST"

## Host function
func host(port, bind_ip, max_players) -> MultiplayerPeer:
	PackRTC.game_channel = game_channel
	var session = await PackRTC.host()
	if session is PRSession:
		await session.peer_ready
		on_code.emit(session.code)
		return session.rtc_peer
	else:
		on_error.emit(session)
		return OfflineMultiplayerPeer.new()

## Join Function
func join(address, port) -> MultiplayerPeer:
	PackRTC.game_channel = game_channel
	var session = await PackRTC.join(address)
	if session is PRSession:
		await session.peer_ready
		on_code.emit(session.code)
		return session.rtc_peer
	else:
		on_error.emit(session)
		return OfflineMultiplayerPeer.new()
