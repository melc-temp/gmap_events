# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on 'ready page:load', ->

#     # $("#MyLoc").on "click", ->
#     #     if document.getElementById("MyLoc").text == "Turn Off My Location"
#     #         document.getElementById("MyLoc").text = "Turn On My Location"
#     #     else
#     #         document.getElementById("MyLoc").text = "Turn On My Location"

#     # Create the autocomplete object, restricting the search
#     # to geographical location types.
    
#     # initialize map
#     # map = new google.maps.Map(document.getElementById("map"), 
#     #         mapTypeId: google.maps.MapTypeId.ROADMAP
#     # )
 
#     # initialize marker
#     marker = new google.maps.Marker(
#         icon:
#             size:
#                 width: 32
#                 height: 32
#             scaledSize:
#                 width: 32
#                 height: 32
#     ) 

#     # initialize searchbox autocomplete
#     autocomplete = new google.maps.places.Autocomplete(document.getElementById("map_location"),
#         types: [])

#     # initialize infowindow
#     infowindow = new google.maps.InfoWindow(
#         content: ""
#         maxWidth: 300
#     )

#     # initialize panoramio view
#     panoramioLayer = new google.maps.panoramio.PanoramioLayer()
    

#     # Start: find user's location 
#     if navigator.geolocation
#         success = (pos) ->
#             crd = pos.coords
#             selfGeo = new google.maps.LatLng(crd.latitude, crd.longitude)

#             buildMap selfGeo, 14
#             autocomplete.setBounds new google.maps.LatLngBounds(selfGeo.lat(), selfGeo.lng())

#         error = (err) ->
#           alert "ERROR: " + err.message
        
#         options = 
#           enableHighAccuracy: true
#           timeout: 3000
#           maximumAge: 0

#         navigator.geolocation.getCurrentPosition success, error, options
#     else
#         alert "My location search plugin is down!"
#     # End: find user's location

#     # Start: Build map
#     buildMap = (GeoLoc, zoomVal) ->

#         mapOptions =
#             zoom: zoomVal
#             center: new google.maps.LatLng(GeoLoc.lat(), GeoLoc.lng())
        
#         # map = new google.maps.Map(document.getElementById("map"), 
#         #      mapTypeId: google.maps.MapTypeId.ROADMAP
    
#         # map.setCenter = new google.maps.LatLng(GeoLoc.lat(), GeoLoc.lng())
#         # map.setZoom = zoomVal

#         # mark user's location on map
#         selfIcon = "http://maps.google.com/mapfiles/kml/pushpin/grn-pushpin.png"
#     #    addMarker map, GeoLoc, "My Location", selfIcon, false
#     # End: Build map

#     # Start: Add marker onto Map
#     addMarker = (map, GeoLoc, title, iconUrl, isDraggable) ->
#         marker.setPosition = GeoLoc
#         marker.setMap = map
#         marker.setTitle = title
#         marker.setDraggable = isDraggable
#         marker.setAnimation = google.maps.Animation.DROP
#         marker.setIcon = iconUrl

#     # End: Add a marker onto map
        
#     # Start: Remove a marker from map
#     removeMarker = (marker) ->
#         marker.setMap null
#     # End: Remove a marker from map

#     # Start: Location Searchbox Autocomplete
#     # When the user selects an address from the dropdown,
#     # populate the address fields in the form.
#     google.maps.event.addListener autocomplete, "place_changed", ->
      
#         # Get the place details from the autocomplete object.      
#         place = autocomplete.getPlace()
        
#         # Retrieve Places Details reponse address_component array item
#         for addressComponent of addressForm
#             document.getElementById(addressComponent).value = ""
#             document.getElementById(addressComponent).disabled = false

#         # Get each component of the address from the place details
#         # and fill the corresponding field on the form.
#         i = 0
#         while i < place.address_components.length
#             addressType = place.address_components[i].types[0]
#             if addressForm[addressType]
#                 val = place.address_components[i][addressForm[addressType]]
#                 document.getElementById(addressType).value = val
#             i++

#         # Retrieve Place Details response formatted_address, formatted_phone_number
#         # url, website, rating items
#         document.getElementById("latitude").value = place.geometry.location.lat()
#         document.getElementById("longitude").value = place.geometry.location.lng() 
#         document.getElementById("name").value = place.name
#         document.getElementById("formatted_address").value = place.formatted_address 
#         document.getElementById("formatted_phone_number").value = place.formatted_phone_number
#         document.getElementById("url").value = place.url
#         document.getElementById("website").value = place.website
#         document.getElementById("rating").value = place.rating
#     # End: Location Searchbox Autocomplete
    
#     # Start: Popup Infowindow
#     google.maps.event.addListener marker, "click", ->
#         contentStr = "Change Value"
#         infowindow.setContent contentStr
#         infowindow.open map, marker
#     # End: Popup Infowindow

#     # Start: Create Panoramio View
#     $('#panoramioView').on "click", ->
#         panoramioLayer.setMap map
#     # End: Create Panoramio View


# addressForm =
#     street_number: "short_name"
#     route: "long_name"
#     locality: "long_name"
#     administrative_area_level_1: "short_name"
#     country: "long_name"
#     postal_code: "short_name"


# #$("#message_modal").modal "show"  if document.getElementById("latitude").value is ""
