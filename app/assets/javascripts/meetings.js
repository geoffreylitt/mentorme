// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// only run on meetings#show
$(document).ready(function() {
  if($('body').data('controller')=='meetings' && $('body').data('action')=='show') {
    //note: opentok data is populated in an inline script at the bottom of the view

    var session;
    var publisher;
    var subscribers = {};

    TB.addEventListener("exception", exceptionHandler);
    
    // Un-comment the following to set automatic logging:
    // TB.setLogLevel(TB.DEBUG);

    if (TB.checkSystemRequirements() != TB.HAS_REQUIREMENTS) {
      alert("You don't have the minimum requirements to run this application."
          + "Please upgrade to the latest version of Flash.");
    } else {
      session = TB.initSession(opentok_session_id);  // Initialize session

      // Add event listeners to the session
      session.addEventListener('sessionConnected', sessionConnectedHandler);
      session.addEventListener('sessionDisconnected', sessionDisconnectedHandler);
      session.addEventListener('connectionCreated', connectionCreatedHandler);
      session.addEventListener('connectionDestroyed', connectionDestroyedHandler);
      session.addEventListener('streamCreated', streamCreatedHandler);
      session.addEventListener('streamDestroyed', streamDestroyedHandler);

      connect();
    }

    //--------------------------------------
    //  UTILITY FUNCTIONS
    //--------------------------------------

    function connect() {
      session.connect(opentok_api_key, opentok_token);
    }

    function disconnect() {
      session.disconnect();
    }

    function startPublishing() {
      if (!publisher) {
        var $stream_div = $("#" + user_role + "_stream"); // div to append stream to => "#mentor_stream", etc
        var $publisher_div = $("<div></div>").attr("id", "opentok_publisher");

        $stream_div.append($publisher_div);

        //video size determined by the surrounding box's width
        var publisher_props = {width: $publisher_div.width(), height: $publisher_div.height()};

        publisher = TB.initPublisher(opentok_api_key, $publisher_div.attr("id"), publisher_props);  // Pass the replacement div id and properties
        session.publish(publisher);
      }
    }

    function stopPublishing() {
      if (publisher) {
        session.unpublish(publisher);
      }
      publisher = null;
    }

    //--------------------------------------
    //  OPENTOK EVENT HANDLERS
    //--------------------------------------

    function sessionConnectedHandler(event) {
       subscribeToStreams(event.streams);
       startPublishing(); 
    }
    
    function streamCreatedHandler(event) {
      subscribeToStreams(event.streams);
    }
    
    function subscribeToStreams(streams) {
      for (i = 0; i < streams.length; i++) {
        var stream = streams[i];
        if (stream.connection.connectionId != session.connection.connectionId) {
          //not myself, okay to subscribe

          var $stream_div = $("#" + stream.connection.data + "_stream"); // div to append stream to => "#mentor_stream", etc
          var $subscriber_div = $("<div></div>").attr("id", stream.streamID);

          $stream_div.append($publisher_div);

          //video size determined by the surrounding box's width
          var subscriber_props = {width: $subscriber_div.width(), height: $subscriber_div.height()};

          session.subscribe(stream, $subscriber_div.attr("id"), subscriber_props);
        }
      }
    }

    //eventually replace addStream entirely!
    function addStream(stream) {
      // Check if this is the stream that I am publishing, and if so do not publish.
      if (stream.connection.connectionId == session.connection.connectionId) {
        return;
      }
      var subscriberDiv = document.createElement('div'); // Create a div for the subscriber to replace
      subscriberDiv.setAttribute('id', stream.streamId); // Give the replacement div the id of the stream as its id.
      document.getElementById("subscribers").appendChild(subscriberDiv);
      var subscriberProps = {width: VIDEO_WIDTH, height: VIDEO_HEIGHT};
      subscribers[stream.streamId] = session.subscribe(stream, subscriberDiv.id, subscriberProps);
    }


    function streamDestroyedHandler(event) {
      // This signals that a stream was destroyed. Any Subscribers will automatically be removed.
      // This default behaviour can be prevented using event.preventDefault()
    }

    function sessionDisconnectedHandler(event) {
      // This signals that the user was disconnected from the Session. Any subscribers and publishers
      // will automatically be removed. This default behaviour can be prevented using event.preventDefault()
      publisher = null;

    }

    function connectionDestroyedHandler(event) {
      // This signals that connections were destroyed
    }

    function connectionCreatedHandler(event) {
      // This signals new connections have been created.
    }


    function exceptionHandler(event) {
      alert("Exception: " + event.code + "::" + event.message);
    }

  }

});

