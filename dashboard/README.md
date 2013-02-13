# realtime dashboard example

WORK IN PROGRESS

see https://github.com/paulasmuth/fnordmetric

due to websocket, this app requires stackato >= 2.8 (does not support
legacy router).

TODO: run curl[1] from within ruby process.

[1] curl -X POST -d '{ "_type": "_incr", "value": 2, "gauge": "requests_per_minute" }' http://stackato-events.stackato-nightly.activestate.com/events
