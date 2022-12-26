import requests
from urllib.parse import quote as encodeURIComponent

url = "https://matrix.org/_matrix/client/r0/register?kind=guest"

res = requests.post(url, data="{}")

access_token = res.json().get('access_token')


roomId = "#raspberrypi:matrix.org"

if roomId[0] == "#":
    getIdUrl = "https://matrix.org/_matrix/client/r0/directory/room/"
    getIdUrl += encodeURIComponent(roomId)
    res = requests.get(getIdUrl)
    data = res.json()
    print(data)


def loadScriptFromEventId(startEventId):
    url = "https://matrix.maxstuff.net/_matrix/client/r0/rooms/" + \
        encodeURIComponent(data["room_id"]) + \
        "/context/" + \
        encodeURIComponent(startEventId) + \
        "?limit=100&access_token=" + \
        access_token

    print(url)
    response = requests.get(url)

    print(response)

    newEvents = []

    # // we only want the events that follow our start events
    newEvents.append(response.json().get("events_after"))

    # // and we only want events that contain a body field,
    # i.e. that are messages
    for events in newEvents:
        print(events)

    # // finally, since we're using React for this app,
    # // we store these messages in the state object
    return newEvents


# if this.state.messageCount > this.state.events.length:
#     // get last known event
#     var lastEvent = res.data.events_after[res.data.events_after.length - 1];
#     this.loadScriptFromEventId(lastEvent.event_id);
# } else {
#     this.setState({events: this.state.events.slice(0, this.state.messageCount), statusMessage: "Done"});
# }
