// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// only run on meetings#show
$(document).ready(function() {
  if($('body').data('controller')=='meetings' && $('body').data('action')=='show') {
    //note: opentok data is populated in an inline script at the bottom of the view

    var session;
    var publisher;
    var subscribers = {};
    var video_enabled = true;

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

        if($stream_div.is(":hidden")){
          //for the translator div, which starts out hidden

          $stream_div.parent().css('display', 'block');
        }

        var $publisher_div = $("<div></div>").attr("id", "opentok_publisher");

        $stream_div.append($publisher_div);

        //video size determined by the surrounding box's width
        var publisher_props = {width: $stream_div.width(), height: $stream_div.height()};

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
      console.log("sessionconnected");
      subscribeToStreams(event.streams);
      startPublishing(); 
    }
    
    function streamCreatedHandler(event) {
      console.log("streamcreated");
      subscribeToStreams(event.streams);
    }
    
    function subscribeToStreams(streams) {
      console.log("subscribetostreams");
      console.log(streams.length);
      for (i = 0; i < streams.length; i++) {
        console.log("one stream");
        var stream = streams[i];
        if (stream.connection.connectionId != session.connection.connectionId) {
          //not myself, okay to subscribe

          var $stream_div = $("#" + stream.connection.data + "_stream"); // div to append stream to => "#mentor_stream", etc

          if($stream_div.is(":hidden")){
            //for the translator div, which starts out hidden

            $stream_div.parent().css("display", "block");
          }

          subscriber_div_id = "stream_" + stream.streamId;
          $stream_div.append("<div id='" + subscriber_div_id + "'></div>");

          $subscriber_div = $("#" + subscriber_div_id);

          //video size determined by the surrounding box's width
          var subscriber_props = {width: $stream_div.width(), height: $stream_div.height()};
          subscribers[stream.streamID] = session.subscribe(stream, $subscriber_div.attr("id"), subscriber_props);

        }
        else{
          console.log("rejected myself");
        }
      }
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

    $("a#video_toggle").click(function(){
      video_enabled = video_enabled ? false : true; //switch video_enabled

      publisher.publishVideo(video_enabled);
      for (var sub in subscribers) {
        if (!subscribers.hasOwnProperty(sub)) {
            continue;
        }
      sub.subscribeToVideo(video_enabled);
      }

      if(video_enabled){
        $(this).siblings("span.message").text("Not enough bandwidth?")
        $(this).text("Turn video off");
      }
      else{
        $(this).siblings("span.message").text("Need for speed?")
        $(this).text("Turn video on");
      }
    });

  }

});

