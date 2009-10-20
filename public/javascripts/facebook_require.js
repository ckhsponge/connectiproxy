FB_RequireFeatures(["XFBML"], function()
{
    FB.Facebook.init(window.api_key, window.facebook_xd_receiver);
    FB.Facebook.get_sessionState().waitUntilReady(function() { } );
});