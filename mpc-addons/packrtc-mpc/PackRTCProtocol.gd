@icon("res://mpc-addons/packrtc-mpc/PackRTCProtocol.svg")
extends MPNetProtocolBase
class_name PackRTCProtocol

## Debug URL Override
func _override_debug_url(bind_ip: String, port: int):
	return "TEST"

## Host function
func host(port, bind_ip, max_players) -> MultiplayerPeer:
	var session = await PackRTC.host()
	await session.peer_ready
	return session.rtc_peer

## Join Function
func join(address, port) -> MultiplayerPeer:
	var session = await PackRTC.join(address)
	await session.peer_ready
	return session.rtc_peer
