// Lấy id html -------------------
var mymap = document.getElementById("map");

//---	Thêm bản đồ nền		---
var mapObject = L.map(mymap, { center: [10.030249, 105.772097], zoom: 10 });
L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}', {
	maxZoom: 20,
	subdomains: ['mt0', 'mt1', 'mt2', 'mt3']
}).addTo(mapObject);

// View All----------------------------------------------------------------------------------------
function ViewAll_TGDD() {
	$.ajax({
		url: '/MapTGDD/getAllTGDD',
		dataType: "json",
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		success: res => {
			//drawnItems.clearLayers();
			//console.log(res);
			res.map(i => {
				var type = i.toado.split(' ')[0]; //Lấy loại là point, LineString or Polygon
				var coors = i.toado.match(/[0-9]+\.*[0-9]*/ig); // Lấy tọa độ bằng biểu thức chính quy

				//coors = [17,1872, 101,8218];
				var popupContent =
					'<form>' +
					'Mã: <br><input readonly type="text" id="input_id" value="' + i.MaDC + '"><br>' +
					'Tên:<br><input type="text" id="input_name" value="' + i.name + '"><br>' +
					'<input type="button" value="Submit" id="submitSuaTen">' +
					'</form>';
				var objectCoords = coors;
				//if (type == "POINT") {
				var marker = L.marker([objectCoords[0], objectCoords[1]]).bindPopup(i.name).addTo(mapObject);
				//marker.id = i.MaDC;

				//marker.on('click', e => {
				//	//marker.bindPopup(popupContent).openPopup();
				//	$("#combobox2").val(i.MaQH);
				//	//document.getElementById("combobox2").value = el.MaQH;
				//})
				//containerMarker.push(marker);


				//var type = i.toado.split(' ')[0];
				//var coors = i.toado.match(/[0-9]+\.*[0-9]*/ig);
				//var objectCoords = coors;
				//if (type == "POINT") {
				//	L.marker([objectCoords[0], objectCoords[1]]).bindPopup(i.name).addTo(drawnItems);
				//}
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

//---	Ghi file json vào text	---
document
	.getElementById('ID-inputJSON')
	.addEventListener(
		'change',
		function () {
			var fr = new FileReader();
			fr.onload = function () {
				document.getElementById('geojsontext1').textContent = this.result;
			};
			fr.readAsText(this.files[0]);
		}
);

var tempLayer = L.layerGroup().addTo(mapObject);

//---	button Add --> chỉ thêm dữ diệu vào map		---
$('#submit1').click(e => {
	tempLayer.clearLayers();
	var Geo = document.getElementById('geojsontext1').textContent;
	L.geoJSON(JSON.parse(Geo),
		{
			pointToLayer: function (feature, latlng) {
				return L.circleMarker(latlng).bindPopup(feature.properties.name);
			}
		}).addTo(tempLayer);
	alert('Load xong')
})

//---	button Save --> post dữ liệu lên controller		---
$('#submit2').click(e => {
	var m = tempLayer.getLayers()[0].getLayers();
	tempLayer.clearLayers();
	m.map((el, ind) => {
		var name = el.feature.properties.name;
		var latlng = `Point(${el.getLatLng().lat} ${el.getLatLng().lng})`;
		var MaQH = el.feature.properties.MaQH;
		var data = {
			'name': name,
			'toado': latlng,
			'MaQH': MaQH
		};
		$.ajax({
			url: '/ThemBangJson/save',
			type: 'post',
			data: data,
			success: res => {
				console.log(res);
				res.map(i => {
					var type = i.toado.split(' ')[0]; //Lấy loại là point, LineString or Polygon
					var coors = i.toado.match(/[0-9]+\.*[0-9]*/ig); // Lấy tọa độ bằng biểu thức chính quy

					//coors = [17,1872, 101,8218];
					var popupContent =
						'<form>' +
						'Mã: <br><input readonly type="text" id="input_id" value="' + i.MaDC + '"><br>' +
						'Tên:<br><input type="text" id="input_name" value="' + i.name + '"><br>' +
						'<input type="button" value="Submit" id="submitSuaTen">' +
						'</form>';
					var objectCoords = coors;
					//if (type == "POINT") {
					var marker = L.marker([objectCoords[0], objectCoords[1]]).bindPopup(i.name).addTo(mapObject);
				})
			}
		});
	});
	
})









