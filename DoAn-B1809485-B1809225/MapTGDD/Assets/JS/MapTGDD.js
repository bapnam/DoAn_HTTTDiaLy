// Lấy id html -------------------
var mymap = document.getElementById("map");

//---	Thêm bản đồ nền		---
var mapObject = L.map(mymap, { center: [10.030249, 105.772097], zoom: 13 });
L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}', {
	maxZoom: 20,
	subdomains: ['mt0', 'mt1', 'mt2', 'mt3']
}).addTo(mapObject);

//++++++++++++++++++++++	Khai Báo    +++++++++++++++++++++++++

var _dsQH; // biến này để chứa các QH được lấy từ csdl

// Tao layer -----------------------------
var Maplayer = L.layerGroup().addTo(mapObject);


//---   Thêm điều khiển mới là combo box rỗng lên bản đồ để chọn Quận Huyện   ---
//var control1 = L.control({ position: "topleft" });
//control1.onAdd = function (map) {
//	var div = L.DomUtil.create("div", "div1");
//	div.innerHTML = '<select id="comboboxQH"></select>';
//	return div;
//};
//control1.addTo(mapObject);

//---   Thêm điều khiển mới là combo box rỗng lên bản đồ để chọn Địa Chỉ   ---
var control1 = L.control({ position: "topleft" });
control1.onAdd = function (map) {
	var div = L.DomUtil.create("div", "div1");
	div.innerHTML = '<select id="combobox1"></select>';
	return div;
};
control1.addTo(mapObject);



//++++++++++++++++++++++	END Khai Báo    +++++++++++++++++++++++++

//++++++++++++++++++++++	Điều khiển vẽ - Drawn	++++++++++++++++++++++

//Thêm điều khiển vẽ; Icon mặc nhiên trong thư mục css/images-----------------------------
/*https://cdnjs.com/libraries/leaflet.draw*/
var drawnItems = L.featureGroup().addTo(mapObject);
new L.Control.Draw({
	draw: {
		polyline: false,
		polygon: false,
		rectangle: false,
		marker: {},
		circle: false,
		circlemarker: false, 		// Turns off this drawing tool
	},
	edit: {
		featureGroup: drawnItems
	}
}).addTo(mapObject);



//++++++++++++++++++++++	END Điều khiển vẽ - Drawn	++++++++++++++++++++++

// View All----------------------------------------------------------------------------------------
function ViewAll_TGDD() {
	$.ajax({
		url: '/MapTGDD/getAllTGDD',
		dataType: "json",
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		success: res => {
			drawnItems.clearLayers();
			//console.log(res);
			res.map(i => {
				var type = i.toado.split(' ')[0]; //Lấy loại là point, LineString or Polygon
				var coors = i.toado.match(/[0-9]+\.*[0-9]*/ig); // Lấy tọa độ bằng biểu thức chính quy

				//coors = [17,1872, 101,8218];
				var popupContent =
					'<form>' +
					'Mã: <br><input readonly type="text" id="input_id" value="' + i.MaDC + '"><br>' +
					'Tên:<br><input type="text" id="input_name" value="' + i.name + '"><br>' +
					'Quận huyện: <br><select id="combobox2" >' + _dsQH + '</select> <br>' +
					'<input type="button" value="Submit" id="submitSuaTen">' +
					'</form>';
				var objectCoords = coors;
				//if (type == "POINT") {
				var marker = L.marker([objectCoords[0], objectCoords[1]]).bindPopup(popupContent).addTo(drawnItems);
				marker.id = i.MaDC;

				marker.on('click', e => {
					//marker.bindPopup(popupContent).openPopup();
					$("#combobox2").val(i.MaQH);
					//document.getElementById("combobox2").value = el.MaQH;
				})
				containerMarker.push(marker);


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

//+++++++++++++++++++   Thao tác với Combobox   +++++++++++++++++++++++++++++++++

//$.getJSON('/MapTGDD/getQH', function (data) {
//	//console.log(data);
//	var menu = $("#comboboxQH");
//	menu.append("<option>Tất cả</option>");
//	$.each(data, function (key, value) {
//		menu.append("<option>" + value.name + "</option>");
//	});
//});


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




//---	Thêm dữ liệu vào combobox thêm sửa Quận Huyện
$.getJSON('/MapTGDD/getQH', function (data) {
	$.each(data, function (key, value) {
		_dsQH += '<option value="' + value.MaQH + '">' + value.name + '</option>';
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
		drawnItems.clearLayers();
		drawnItems.clearLayers();
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
							'Quận huyện: <br><select id="combobox2" >' + _dsQH + '</select> <br>' +
							'<input type="button" value="Submit" id="submitSuaTen">' +
							'</form>';
						var objectCoords = coors;
						//if (type == "POINT") {
						var marker = L.marker([objectCoords[0], objectCoords[1]]).bindPopup(popupContent).addTo(drawnItems);
						marker.id = i.MaDC;

						marker.on('click', e => {
							//marker.bindPopup(popupContent).openPopup();
							$("#combobox2").val(i.MaQH);
							//document.getElementById("combobox2").value = el.MaQH;
						})
						containerMarker.push(marker);

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

//+++++++++++++++++++   END Thao tác với Combobox   +++++++++++++++++++++++++++++++++


//+++++++++++++++++++	Thao tác thêm		+++++++++++++++++++++++++++++++++

//---	layer để giữ đối tượng đang vẽ hoặc đang được chọn	---
var layerFocus = new L.Layer();

// Tạo popup khi thêm sửa bản đồ -----------------------------------------------------------------------------
mapObject.on("draw:created", function (e) {
	layerFocus = e.layer;
	layerFocus.addTo(drawnItems);
	var popupContent =
		'<form>' +
		'Tên:<br><input type="text" id="input_name" value=""><br>' +
		'Quận huyện: <br><select id="combobox2">' + _dsQH + '</select> <br>' +
		'<input type="button" value="Submit" id="submit">' +
		'</form>';
	layerFocus.bindPopup(popupContent).openPopup();

});

//---	Đưa dữ liệu vào layerFocus	---
drawnItems.on('popupopen', function (e) {
	layerFocus = e.layer;
});

//---	Click submit gọi hàm addprops	---
$("body").on("click", "#submit", addprops);

//---	hàm đưa dữ liệu về controller và lưu vào csdl	---
function addprops() {
	var name = $("#input_name").val();
	var toado = 'POINT(' + layerFocus.getLatLng().lat + ' ' + layerFocus.getLatLng().lng + ')';
	var MaQH = $("#combobox2").val();

	//var comboQH = document.getElementById('combobox2');

	//console.log(MaQH);
	//console.log(name, toado);

	$.ajax({
		method: "POST",
		url: '/MapTGDD/Them',
		data: { 'name': name, 'toado': toado, 'MaQH': MaQH },
		success: res => {
			window.location.href = '/MapTGDD/Index';
			console.log(res);
		}
	});//END ajax

	//layerFocus.feature = {};
	//layerFocus.feature.type = "Feature";
	//layerFocus.feature.properties = {};
	//layerFocus.feature.properties.name = $("#input_name").val();
	//layerFocus.closePopup();
	//var popup = layerFocus.getPopup(),
	//	content = popup.getContent(),
	//	start = content.indexOf('id="input_name"', 0),
	//	end = content.indexOf('>', start),
	//	l = content.substr(0, start);
	//r = content.substr(end, content.length);
	//console.log(content);
	//content = l + 'id="input_name" value="' + $("#input_name").val() + '"' + r;

	//layerFocus.bindPopup(content).closePopup();
}

//+++++++++++++++++++	END Thao tác thêm	+++++++++++++++++++++++++++++++++


//+++++++++++++++++++	 Thao tác sửa	+++++++++++++++++++++++++++++++++

var containerMarker = [];

$.ajax({
	url: '/MapTGDD/getAllTGDD',
	type: 'get',

	success: res => {
		drawnItems.clearLayers();
		res.map(el => {

			var coors = el.toado.match(/[0-9]+\.*[0-9]*/ig);
			var marker = L.marker([coors[0], coors[1]]).addTo(drawnItems);
			marker.bindPopup(el.name);
			marker.id = el.MaDC;
			marker.on('click', e => {

				var popupContent =
					'<form>' +
					'Mã: <br><input readonly type="text" id="input_id" value="' + el.MaDC + '"><br>' +
					'Tên:<br><input type="text" id="input_name" value="' + el.name + '"><br>' +
					'Quận huyện: <br><select id="combobox2" >' + _dsQH + '</select> <br>' +
					'<input type="button" value="Submit" id="submitSuaTen">' +
					'</form>';

				marker.bindPopup(popupContent).openPopup();
				$("#combobox2").val(el.MaQH);
				//document.getElementById("combobox2").value = el.MaQH;
			})
			containerMarker.push(marker);
		});
	}
});

//---	thao tác kéo thả để thay đổi tọa độ, post lên controller	---
mapObject.on('draw:edited', e => {
	var layers = e.layers;
	layers.eachLayer(function (layer) {
		if (layer instanceof L.Marker) {
			console.log(layer);
			var toado = 'POINT(' + layer.getLatLng().lat + ' ' + layer.getLatLng().lng + ')';
			$.ajax({
				url: '/MapTGDD/SuaToaDo',
				type: 'get',
				data: { 'MaDC': layer.id, 'toado': toado },
				success: res => {

				}
			});
		}
	});
})

//---	khi chọn submit gọi editprops	---
$("body").on("click", "#submitSuaTen", editprops);

//---	Hàm sửa tên và quận huyện post tên controller	---
function editprops() {
	var id = $("#input_id").val();
	var name = $("#input_name").val();
	var MaQH = $("#combobox2").val();
	console.log(MaQH);

	$.ajax({
		method: "POST",
		url: '/MapTGDD/SuaTen',
		data: { 'MaDC': id, 'name': name, 'MaQH': MaQH },
		success: res => {
			window.location.href = '/MapTGDD/Index';
			console.log(res);
		}
	});//END ajax

	layerFocus.feature = {};
	layerFocus.feature.type = "Feature";
	layerFocus.feature.properties = {};
	layerFocus.feature.properties.name = $("#input_name").val();
	layerFocus.closePopup();
	var popup = layerFocus.getPopup(),
		content = popup.getContent(),
		start = content.indexOf('id="input_name"', 0),
		end = content.indexOf('>', start),
		l = content.substr(0, start);
	r = content.substr(end, content.length);
	console.log(content);
	content = l + 'id="input_name" value="' + $("#input_name").val() + '"' + r;

	layerFocus.bindPopup(content).closePopup();
}


//+++++++++++++++++++	END Thao tác sửa	+++++++++++++++++++++++++++++++++


//+++++++++++++++++++	 Thao tác xóa	+++++++++++++++++++++++++++++++++

mapObject.on('draw:deleted', e => {
	var layers = e.layers;
	layers.eachLayer(function (layer) {
		if (layer instanceof L.Marker) {
			console.log(layer);
			var toado = 'POINT(' + layer.getLatLng().lat + ' ' + layer.getLatLng().lng + ')';
			$.ajax({
				url: '/MapTGDD/XoaDiem',
				type: 'get',
				data: { 'MaDC': layer.id },
				success: res => {

				}
			});
		}
	});
})

//+++++++++++++++++++	 END Thao tác xóa	+++++++++++++++++++++++++++++++++














