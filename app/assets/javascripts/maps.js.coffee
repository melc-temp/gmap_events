# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->

    markerDetails = []
    jQuery ->
        markerDetails = maps

    # Create the autocomplete object, restricting the search
    # to geographical location types.
    # initialize searchbox autocomplete
    autocomplete = new google.maps.places.Autocomplete(document.getElementById("map_location"), types: [])
 
    # initialize map  
    map = new google.maps.Map(document.getElementById("map"))
    marker = new google.maps.Marker()

    # initialize self geolocation
    selfGeoLocation = new google.maps.LatLng()
    
    # initialize directionsservice and directionsrenderer
    directionsService = new google.maps.DirectionsService()
    directionsDisplay = new google.maps.DirectionsRenderer()

    streetView = new google.maps.StreetViewService()
    panoramaStreetView = new google.maps.StreetViewPanorama(document.getElementById('panoDIV'));

    # initialize markers array of jSon
    markers = []

    # contentStr = ""

    # initialize markers bounds
    #bounds = new google.maps.LatLngBounds()

# Perform search over this bounds 

    # initialize panoramio view
    # panoramioLayer = new google.maps.panoramio.PanoramioLayer()
    
    # Start: find user's location 
    if navigator.geolocation
        success = (pos) ->
            crd = pos.coords
            selfGeoLocation = new google.maps.LatLng(crd.latitude, crd.longitude)

            buildMap selfGeoLocation, 14
            #autocomplete.setBounds new google.maps.LatLngBounds(selfGeoLocation.lat(), selfGeoLocation.lng())

        error = (err) ->
          alert "ERROR: " + err.message
        
        options = 
          enableHighAccuracy: true
          timeout: 3000
          maximumAge: 0

        navigator.geolocation.getCurrentPosition success, error, options
    else
        alert "My location search plugin is down!"
    # End: find user's location

    # Start: Build map
    buildMap = (GeoLoc, zoomVal) ->

        map.setCenter(new google.maps.LatLng(GeoLoc.lat(), GeoLoc.lng()))
        map.setZoom(zoomVal)
        map.setMapTypeId(google.maps.MapTypeId.ROADMAP)

        setMarkers map, markerDetails
        $(document).on "change", "#mode", ->
            calcRoute map

    # End: Build map

    setMarkers = (map, markerDetails) ->
        # add marker of user's location onto map
        selfIcon = "http://maps.google.com/mapfiles/kml/pushpin/pink-pushpin.png"
        addMarker map,selfGeoLocation, "My Location", selfIcon, false        
 
        # add markers in the array onto map
        iMarker = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
        i = 0
        while i < markerDetails.length
            geolocation = new google.maps.LatLng(markerDetails[i].latitude, markerDetails[i].longitude)
            addMarker map, geolocation, markerDetails[i].name, "http://maps.google.com/mapfiles/kml/paddle/" + iMarker[i] + ".png", false
            i++

        markerCluster = new MarkerClusterer(map, markers);

    # Start: Add marker onto Map
    addMarker = (map, GeoLoc, title, iconUrl, isDraggable) ->
        marker = new google.maps.Marker(
            position: GeoLoc
            map: map
            title: title
            draggable: isDraggable
            animation: google.maps.Animation.DROP
            icon: 
                url: iconUrl
                size: new google.maps.Size(32, 32)
                scaledSize: new google.maps.Size(32, 32)
        )

        # setupInfoWinContent marker
        # attachInWindow contentStr, marker

        markers.push marker  
    # End: Add a marker onto map
        
    # Start: Remove a marker from map
    removeMarker = (marker) ->
        marker.setMap null
    # End: Remove a marker from map

    # Start: Draw route and direction, and display direction in a modal
    calcRoute = (map) ->
        directionsDisplay.setMap map
        start = new google.maps.LatLng(selfGeoLocation.lat(), selfGeoLocation.lng())
        end = new google.maps.LatLng(markerDetails[0].latitude, markerDetails[0].longitude)
        selectedMode = document.getElementById("mode").value
        request =
            origin: start
            destination: end
            travelMode: google.maps.TravelMode[selectedMode]

        directionsService.route request, (response, status) ->
            directionsDisplay.setDirections response  if status is google.maps.DirectionsStatus.OK

        $("#directions-panel").modal "show"
        directionsDisplay.setPanel document.getElementById("directionDetail")
        $("#directions-panel").on "shown", ->
            google.maps.event.trigger map, "resize"
    # End: Draw driving route and direction, and display direction in a modal

    # Start: Popup Infowindow
    # attachInfoWindow = (contentStr, marker) ->
    #     infowindow = new google.maps.InfoWindow(content: contentStr, maxWidth: 300)
    #     google.maps.event.addListener marker, "click", ->
    #         infowindow.open map, marker
    # End: Popup Infowindow        

    # setupInfoWinContent = (marker) ->
    #     i = 0
    #     alert marker.getPosition().lat()
    #     while i < markerDetails.length
    #         if marker.getPosition().lat() is markers[i].latitude and marker.getPosition().lng() is markers[i].longitude
    #             if markers[i].name isnt "" and markers[i].name?
    #                 name = markers[i].name
    #             else
    #                 name = ""
    #             if markers[i].formatted_address isnt "" and markers[i].formatted_address?
    #                 address = markers[i].formatted_address
    #             else
    #                 address = ""
    #             if markers[i].formatted_phone_number isnt "" and markers[i].formatted_phone_number?
    #                 phone_number = markers[i].formatted_phone_number
    #             else
    #                 phone_number = ""
    #             if markers[i].rating isnt "" and markers[i].rating?
    #                 rating = markers[i].rating
    #             else
    #                 rating = ""
    #             if markers[i].url isnt "" and markers[i].url?
    #                 url = markers[i].url
    #             else
    #                 url = ""
    #             if markers[i].website isnt "" and markers[i].website?
    #                 website = markers[i].website         
    #             else
    #                 website = ""
    #         i++

    #     contentStr = 
    #          '<div style="width: 300px;">
    #             <div>
    #               <span class="gm-title">' + name + '</span>
    #               <span class="gm-more"><a href="' + url +'" target="_blank">more info</a></span>
    #             </div>' + rating + '
    #             <div class="gm-basicinfo">
    #                 <div class="gm-addr">' + address + '</div>
    #                 <div class="gm-website"><a href="' + website + '" target="_blank">' + website + '</a></div>         
    #                 <div class="gm-phone">' + phone_number + '</div>
    #             </div>
    #         </div>'
    #     alert contentStr

    # $(document).on "click", "#myloc", ->
    #     if document.getElementById("myloc").name == "Off"
    #         document.getElementById("myloc").name = "On"
    #     else
    #         document.getElementById("myloc").name = "On"

    # Start: Location Searchbox Autocomplete
    # When the user selects an address from the dropdown,
    # populate the address fields in the form.
    google.maps.event.addListener autocomplete, "place_changed", ->
      
        # Get the place details from the autocomplete object.      
        place = autocomplete.getPlace()
        
        # Retrieve Places Details reponse address_component array item
        for addressComponent of addressForm
            document.getElementById(addressComponent).value = ""
            document.getElementById(addressComponent).disabled = false

        # Get each component of the address from the place details
        # and fill the corresponding field on the form.
        i = 0
        while i < place.address_components.length
            addressType = place.address_components[i].types[0]
            if addressForm[addressType]
                val = place.address_components[i][addressForm[addressType]]
                document.getElementById(addressType).value = val
            i++

        # Retrieve Place Details response formatted_address, formatted_phone_number
        # url, website, rating items
        document.getElementById("latitude").value = place.geometry.location.lat()
        document.getElementById("longitude").value = place.geometry.location.lng() 
        document.getElementById("name").value = place.name
        document.getElementById("formatted_address").value = place.formatted_address 
        document.getElementById("formatted_phone_number").value = place.formatted_phone_number
        document.getElementById("url").value = place.url
        document.getElementById("website").value = place.website
        document.getElementById("rating").value = place.rating
    # End: Location Searchbox Autocomplete

    # Start: Create Panoramio View
    # $('#panoramioView').on "click", ->
    #     panoramioLayer.setMap map
    #     photoPanel = document.getElementById("photo-panel")
    #     map.controls[google.maps.ControlPosition.RIGHT_TOP].push photoPanel

    # End: Create Panoramio View

    # Start: Set Panoramio View InfoWindow
    # google.maps.event.addListener panoramioLayer, "click", (photo) ->
    #     li = document.createElement("li")
    #     link = document.createElement("a")
    #     link.innerHTML = photo.featureDetails.title + ": " + photo.featureDetails.author
    #     link.setAttribute "href", photo.featureDetails.url
    #     li.appendChild link
    #     photoPanel.appendChild li
    #     photoPanel.style.display = "block"
    # End: Set Panoramo View InfoWindow

addressForm =
    street_number: "short_name"
    route: "long_name"
    locality: "long_name"
    administrative_area_level_1: "short_name"
    country: "long_name"
    postal_code: "short_name"


#$("#message_modal").modal "show"  if document.getElementById("latitude").value is ""
