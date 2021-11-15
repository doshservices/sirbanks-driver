import 'dart:convert';

import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  static String _serverIP = 'https://sirbanks.herokuapp.com/';
  // static const int SERVER_PORT = 8080;
  String token, id;
  String userId, resourceType;
  // Event
  static const String UPDATE_LOCATION = 'UPDATE_LOCATION';
  static const String UPDATE_AVAILABILITY = 'UPDATE_AVAILABILITY';
  static const String REJECT_REQUEST = 'REJECT_REQUEST';
  static const String RIDER_LOCATION_UPDATED = 'RIDER_LOCATION_UPDATED';
  static const String RIDE_REQUEST = 'RIDE_REQUEST';
  static const String ACCEPT_REQUEST = 'ACCEPT_REQUEST';
  static const String REQUEST_ACCEPTED = 'REQUEST_ACCEPTED';
  static const String CANCEL_TRIP = 'CANCEL_TRIP';
  static const String TRIP_CANCELED = 'TRIP_CANCELED';
  static const String UPDATE_DESTINATION = 'UPDATE_DESTINATION';
  static const String DESTINATION_UPDATED = 'DESTINATION_UPDATED';
  static const String SUCCESS = 'SUCCESS';
  static const String ERROR = 'ERROR';
  static const String START_TRIP = 'START_TRIP';
  static const String TRIP_ENDED = 'TRIP_ENDED';
  static const String ARRIVING_PICKUP = 'ARRIVING_PICKUP';
  static const String ARRIVED_PICKUP = 'ARRIVED_PICKUP';
  static const String ARRIVING_DESTINATION = 'ARRIVING_DESTINATION';
  static const String ARRIVED_DESTINATION = 'ARRIVED_DESTINATION';
  static const String PRIVATE_MESSAGE = 'PRIVATE_MESSAGE';
  static const String NEW_MESSAGE = 'NEW_MESSAGE';
  static const String TIMEOUT = 'TIMEOUT';

  // init connect
  IO.Socket socket;
  SocketIO socketIO;

  initSocket(String token, String id) async {
    print('Connecting user: ' + token);
    this.token = token;
    this.id = id;
    await _init();
  }

  _init() async {
    print("Token :  " + token.toString());
    // String tokenvalue = 'Bearer $token';
    socketIO = SocketIOManager().createSocketIO(
        'https://sirbanks.herokuapp.com', '/',
        query: 'authorization=Bearer $token',
        socketStatusCallback: _socketConnect);

    socketIO.init();

    // socketIO.subscribe("SUCCESS", _socketConnect);

    // socketIO.subscribe("ERROR", _socketError);

    //  var jsonData = jsonEncode({
    //    "id": "$id",
    //    "pickUpLat": "3.123455",
    //    "pickUpLon": "3.123455",
    //    "dropOffLat": "3.123455",
    //    "dropOffLon": "3.123455"
    //   });
    //  socketIO.sendMessage("GET_TRIP_DETAILS", jsonData, _socketConnect);
  }

  _socketConnect(dynamic data) {
    print("*******Socket status: " + data.toString());
    // return data;
  }

  _socketError(dynamic data) {
    print("Socket status: " + data);
    return data;
  }

  connectToSocket() {
    if (null == socketIO) {
      print("Socket is Null");
      return;
    }
    print("Connecting to socket...");
    socketIO.connect();
    // socket.connect();
  }

  setOnConnectionErrorListener(Function onConnectError) {
    onConnectError(_socketError);
    // socket.onConnectError((data) {
    //   onConnectError(data);
    // });
  }

  // setOnConnectionErrorTimeOutListener(Function onConnectTimeout) {
  //   socket.onConnectTimeout((data) {
  //     onConnectTimeout(data);
  //   });
  // }

  // setOnErrorListener(Function onError) {
  //   socket.on('ERROR', (data) => print(data));
  //   socket.onError((error) {
  //     onError(error);
  //   });
  // }

  setOnDisconnectListener(Function onDisconnect) {
    // socket.onDisconnect((data) {
    //   print("onDisconnect $data");
    //   onDisconnect(data);
    // });
  }

  emitUPDATEAVAILABILITY(String id, bool avaliable) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      print("*********UPDATE_AVAILABILITY*******");
      var jsonData = jsonEncode({"id": id, "availability": avaliable});
      socketIO.sendMessage("UPDATE_AVAILABILITY", jsonData, _socketConnect);
    }
  }

  emitStartRide(Map<String, dynamic> data) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      print("*********Strat TripY*******");
      var jsonData = jsonEncode({"id": id, "tripId": data['tripId']});
      socketIO.sendMessage("START_TRIP", jsonData, _socketConnect);
    }
  }

  emitEndRide(Map<String, dynamic> data) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      print("*********End Ride*******");
      var jsonData = jsonEncode({
      "id": id,
      "tripId": data['tripId'],
      "dropOff": data['dropOff'],
      "dropOffLon": data['dropOffLon'],
      "dropOffLat": data['dropOffLat'],
      });
      socketIO.sendMessage("END_TRIP", jsonData, _socketConnect);
    }
  }

  emitUPDATELOCATION(String id, String lat, String lon) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      print("*********UPDATE_LOCATION*******");
      var jsonData =
          jsonEncode({"id": id, "role": "driver", "lon": lon, "lat": lat});
      socketIO.sendMessage("UPDATE_LOCATION", jsonData, _socketConnect);
    }
  }

  emitACCEPTREQUEST(
    tripId, 
    String id, lat, long,
  ) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      print("*******ACCEPT_REQUEST*********");
      var jsonData = jsonEncode({
        "id": id,
        "tripId": tripId.toString(),
        "lon": long.toString(),
        "lat": lat.toString(),
      });
      print(jsonData);
      socketIO.sendMessage("ACCEPT_REQUEST", jsonData, _socketConnect);
    }
  }

  emitREJECTREQUEST(
    tripId, 
    String id,
  ) {
    print('sending out new video bc $id');
    if (null == socketIO) {
      print("Socket is Null, Cannot send message");
      return;
    }
    if (socketIO != null) {
      socketIO.connect();
      print("*******REJECT_REQUEST*********");
      var jsonData = jsonEncode(
        {
        "id": id,
        "tripId": tripId.toString(),
        });
      socketIO.sendMessage("REJECT_REQUEST", jsonData, _socketConnect);
    }
  }

  // void _onReceiveChatMessage(dynamic message) {
  //   print("Message from UFO: " + message);
  //   onTripDetailSRecieved(data);
  // }

  _onReceiveChatMessage(dynamic data) {
    print(
        " ****** Error ********* Message from UFO: " + data.toString());
    // onTripDetailSRecieved(data);
  }

  listenTRIPDETAILS(Function onRIDEREQUESTSRecieved) {
    if (socketIO != null) {
      socketIO.subscribe("RIDE_REQUEST", onRIDEREQUESTSRecieved);
    }
  }

  listenTripEnded(Function onRIDEREQUESTSRecieved) {
    if (socketIO != null) {
      socketIO.subscribe("TRIP_ENDED", onRIDEREQUESTSRecieved);
    }
  }

  listenTripCancel(Function onRIDEREQUESTSRecieved) {
    if (socketIO != null) {
      socketIO.subscribe("TRIP_CANCELED", onRIDEREQUESTSRecieved);
    }
  }

  listenError() {
    if (socketIO != null) {
      socketIO.subscribe("ERROR", _onReceiveChatMessage);
    }
  }
}
