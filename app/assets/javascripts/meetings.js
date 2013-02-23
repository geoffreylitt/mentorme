// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// only run on meetings#show
$(document).ready(function() {
  if($('body').data('controller')=='meetings' && $('body').data('action')=='show') {
    //note: opentok data is populated in an inline script at the bottom of the view

    var session;
    var publisher;
    var subscribers = {};
    var VIDEO_WIDTH = 320;
    var VIDEO_HEIGHT = 240;

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
    }

    //--------------------------------------
    //  LINK CLICK HANDLERS
    //--------------------------------------

    /*
    If testing the app from the desktop, be sure to check the Flash Player Global Security setting
    to allow the page from communicating with SWF content loaded from the web. For more information,
    see http://www.tokbox.com/opentok/build/tutorials/helloworld.html#localTest
    */
    function connect() {
      session.connect(opentok_api_key, opentok_token);
    }

    function disconnect() {
      session.disconnect();
    }

    /*don't think we need this funciton

    // Called when user wants to start publishing to the session
    function startPublishing() {
      if (!publisher) {
        var parentDiv = document.getElementById("myCamera");
        var publisherDiv = document.createElement('div'); // Create a div for the publisher to replace
        publisherDiv.setAttribute('id', 'opentok_publisher');
        parentDiv.appendChild(publisherDiv);
        var publisherProps = {width: VIDEO_WIDTH, height: VIDEO_HEIGHT};
        publisher = TB.initPublisher(apiKey, publisherDiv.id, publisherProps);  // Pass the replacement div id and properties
        session.publish(publisher);
        show('unpublishLink');
        hide('publishLink');
      }
    }

    */

    function stopPublishing() {
      if (publisher) {
        session.unpublish(publisher);
      }
      publisher = null;

      show('publishLink');
      hide('unpublishLink');
    }

    //--------------------------------------
    //  OPENTOK EVENT HANDLERS
    //--------------------------------------

    function sessionConnectedHandler(event) {
      // Subscribe to all streams currently in the Session
      for (var i = 0; i < event.streams.length; i++) {
        addStream(event.streams[i]);
      }
    }

    function streamCreatedHandler(event) {
      // Subscribe to the newly created streams
      for (var i = 0; i < event.streams.length; i++) {
        addStream(event.streams[i]);
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

    /*
    If you un-comment the call to TB.setLogLevel(), above, OpenTok automatically displays exception event messages.
    */
    function exceptionHandler(event) {
      alert("Exception: " + event.code + "::" + event.message);
    }

    //--------------------------------------
    //  HELPER METHODS
    //--------------------------------------

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

});

