createMap = ->
  new google.maps.Map document.getElementById('map'),
    zoom: 6
    center: new google.maps.LatLng(36.3, -118)
    mapTypeId: google.maps.MapTypeId.ROADMAP

view = ->
  [ 'div'
    ['p', 'Signatures by zip code:']
    [ '#map'
      style:
        width: '100%'
        height: 700
    ]
  ]

T(view()).render here: true 

map = createMap()

addMarkers = (data) ->
  for zip, zipData of data
    continue if zipData.signed <= 0
    position = new google.maps.LatLng zipData.latitude, zipData.longitude
    icon = "images/markers/marker#{if zipData.signed > 99 then 99 else zipData.signed}.png"
    marker   = new google.maps.Marker
      map      : map
      position : position
      animation: google.maps.Animation.DROP
      title    : zip
      icon     : icon
      zIndex   : zipData.signed

if location.host.match(/capeus.org/)
  jQuery.getJSON "http://gcao.cloudant.com/cape/sca5signatures?callback=?", (resp) -> addMarkers(resp.data)
else
  addMarkers(data)


