// Lấy id html -------------------
var mymap = document.getElementById("map");

//---	Thêm bản đồ nền		---
var mapObject = L.map(mymap, { center: [10.030249, 105.772097], zoom: 10 });
L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}', {
	maxZoom: 20,
	subdomains: ['mt0', 'mt1', 'mt2', 'mt3']
}).addTo(mapObject);


// Tao layer -----------------------------
var Maplayer = L.layerGroup().addTo(mapObject);


//---   Thêm điều khiển mới là combo box rỗng lên bản đồ để chọn Địa Chỉ   ---
var control1 = L.control({ position: "topleft" });
control1.onAdd = function (map) {
	var div = L.DomUtil.create("div", "div1");
	div.innerHTML = '<select id="combobox1"></select>';
	return div;
};
control1.addTo(mapObject);


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
					L.marker([objectCoords[0], objectCoords[1]]).bindPopup(i.name).addTo(Maplayer);
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


//+++   Thêm dư liệu vào combobox rổng chứa địa chỉ----------------------------------------------------------------
//https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter?retiredLocale=vi

$.getJSON('/MapTGDD/getAllTGDD', function (data) {
	//console.log(data);
	var menu = $("#combobox1");
	menu.append("<option>Tất cả</option>");
	$.each(data, function (key, value) {
		menu.append("<option>" + value.name + "</option>");
	});
});

//+++   Cập nhật đối tượng trên bản đồ khi combo box được chọn---------------------------
$("#combobox1").on("change", function () {
	var valueSelected = $("#combobox1").val();
	//console.log($("#combobox1").val());
	if (valueSelected == "Tất cả") {
		//drawnItems.clearLayers();
		ViewAll_TGDD();
	} else {
		//drawnItems.clearLayers();
		//drawnItems.clearLayers();
		Maplayer.clearLayers();
		$.ajax({
			url: '/MapTGDD/getAllTGDD',
			dataType: "json",
			type: "GET",
			contentType: 'application/json; charset=utf-8',
			success: res => {
				//console.log(res);
				res.map(i => {
					if (i.name == valueSelected) { //Nếu giá trị bằng với giá trị trong combobox thì view lên Map 

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
						var marker = L.marker([objectCoords[0], objectCoords[1]]).bindPopup(popupContent).addTo(Maplayer);
						marker.id = i.MaDC;

						marker.on('click', e => {
							//marker.bindPopup(popupContent).openPopup();
							$("#combobox2").val(i.MaQH);
							//document.getElementById("combobox2").value = el.MaQH;
						})
						//containerMarker.push(marker);

						//if (type == "LINESTRING") {
						//	L.polyline([[clickCoords.lat, clickCoords.lng], [objectCoords[0], objectCoords[1]]], lineStyle2).addTo(Maplayer);
						//}
						//if (type == "POLYGON") {
						//	L.polyline([[clickCoords.lat, clickCoords.lng], [objectCoords[0], objectCoords[1]]], lineStyle2).addTo(Maplayer);
						//}
					}

				})
			}

		}); // END ajax

	}// END else

});





