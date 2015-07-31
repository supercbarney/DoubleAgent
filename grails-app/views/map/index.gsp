<%--
  Created by IntelliJ IDEA.
  User: CHRIS
  Date: 7/29/2015
  Time: 6:08 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Page title</title>
    <link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.3/leaflet.css"/>
    %{--<link rel="stylesheet" type="text/css" href="../../grails-app/assets/stylesheets/main.css"/>--}%
</head>
<style>
#map {
    height: 500px;
}
</style>

<body>
<label style="background-color:blue">Male</label>&nbsp;&nbsp;<label style="background-color: red">Female</label>
<br/>
Max Age: <input type="number" id="maxAge"/>&nbsp;Name: <input type="text" id="filterName" type="text"/>

<div id="map"></div>
</body>
<script src="http://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.3/leaflet.js"></script>
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
    var markers = new Array();
    var popupMarkers = new Array();
    $().ready(function () {
        var map = L.map('map').setView([40, -100], 3);

        var tileUrl = 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
                layer = new L.TileLayer(tileUrl, {maxZoom: 18});

        // add the layer to the map
        map.addLayer(layer);
        <g:each in="${agents}" var="agent">
        var circle;
        <g:if test="${agent.Gender == 'Male'}">
        circle = L.circle([${agent.Latitude}, ${agent.Longitude}], 500, {
            color: 'blue',
            fillOpacity: 0.5
        }).addTo(map);
        </g:if>
        <g:else>
        circle = L.circle([${agent.Latitude}, ${agent.Longitude}], 500, {
            color: 'red',
            fillOpacity: 0.5
        }).addTo(map);
        </g:else>
        var popup = L.popup()
                .setContent("${agent.Name}<br/>${agent.Age} years old");
        circle.AGE = ${agent.Age};
        circle.NAME = "${agent.Name}";
        circle.GENDER = "${agent.Gender}";
        circle.bindPopup(popup);
        markers.push(circle);

        </g:each>

        $("#maxAge").on("change", function () {
            var maxAge = $("#maxAge").val();
            $.each(markers, function (i, marker) {
                var agentAge = marker.AGE;
                map.removeLayer(marker);
                if (agentAge <= maxAge || maxAge == "") {
                    map.addLayer(marker);
                }
            });
        });

        $("#filterName").on("change", function () {
            var fName = $("#filterName").val();
            $.each(popupMarkers, function (i, p) {
                map.removeLayer(p);
            });
            $.each(markers, function (i, marker) {
                var agentName = marker.NAME;
                if (fName!="" && agentName.toLowerCase().indexOf(fName.toLowerCase()) != -1) {
                    var popup = new L.popup();
                    popup.setLatLng(marker._latlng);
                    popup.setContent(marker._popup._content);
                    map.addLayer(popup);
                    marker.setStyle({color: "green"});
                    popupMarkers.push(popup);
                } else {
                    if (marker.GENDER == "Male") {
                        marker.setStyle({color: "blue"});
                    } else {
                        marker.setStyle({color: "red"});
                    }
                }
            });
        });
    });


</script>
</html>