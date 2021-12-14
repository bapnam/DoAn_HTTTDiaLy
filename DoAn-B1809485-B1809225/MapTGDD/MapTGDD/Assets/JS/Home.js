// Lấy id html -------------------
var mymap = document.getElementById("map");

//---	Thêm bản đồ nền		---
var mapObject = L.map(mymap, { center: [10.030249, 105.772097], zoom: 10 });
L.tileLayer(
	"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
	{
		attribution: '&copy; <a href="http://' +
			'www.openstreetmap.org/copyright">OpenStreetMap</a>'
	}
).addTo(mapObject);


// View All----------------------------------------------------------------------------------------
function ViewAll_TGDD() {
	$.ajax({
		url: '/MapTGDD/getAllTGDD',
		dataType: "json",
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		success: res => {
			//console.log(res);
			res.map(i => {
				var type = i.toado.split(' ')[0];
				var coors = i.toado.match(/[0-9]+\.*[0-9]*/ig);
				var objectCoords = coors;
				if (type == "POINT") {
					L.marker([objectCoords[0], objectCoords[1]]).bindPopup(i.name).addTo(mapObject);
				}
				//if (type == "LINESTRING") {
				//	L.polyline([[clickCoords.lat, clickCoords.lng], [objectCoords[0], objectCoords[1]]], lineStyle2).addTo(Maplayer);
				//}
				//if (type == "POLYGON") {
				//	L.polyline([[clickCoords.lat, clickCoords.lng], [objectCoords[0], objectCoords[1]]], lineStyle2).addTo(Maplayer);
				//}

			})//end res.map
		}

	});//END ajax
}

//+++++++++++++++++++	RUN		++++++++++++++
ViewAll_TGDD();







