<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adLocationCreate.jsp</title>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/css.css"/>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	
<jsp:include page="/WEB-INF/views/include/2bs4.jsp"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
 <script>
    function addressCheck(latitude,longitude) {
    	var address = document.myForm.address.value;
    	if(address == "") {
    		alert("선택한 지점의 장소명을 입력하세요.");
    		document.myForm.address.focus();
    		return false;
    	}
    	//alert("위도:"+latitude+" 경도:"+longitude+" 장소명:"+address);
    	var query = {
    		address  : address,
    		latitude : latitude,
    		longitude: longitude
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/admin/adAddressName",
    		data : query,
    		success:function(data) {
    			if(data == "1") alert("선택한 지점이 등록되었습니다.");
    			else alert("이미 같은지점이 있습니다. 이름을 변경해서 다시 등록할수 있습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    	
    }
  </script>
  <style>
  .btn-warning {
    color: #fff;
    background-color: #ff792a;
    border-color: rgb(0 0 0 / 8%);
}
  </style>
</head>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bdca9fd1682feca5a5acff3304e1e35"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
	
<body>
 <div class="container">
  <h2>클릭한 위치에 마커 표시</h2>
  <h5>위치를 클릭하면 마커가 표시됩니다.</h5>
  <hr/>
  <div id="map" style="width:100%;height:500px;"></div>
  	<p><b>지도를 클릭해 주세요</b></p>
	<form name="myForm">
		<div id="clickPoint"></div>
	</form>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bdca9fd1682feca5a5acff3304e1e35"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
		        level: 2 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 <font color="red">' + latlng.getLat() + '</font> 이고, ';
		    message += '경도는 <font color="red">' + latlng.getLng() + '</font> 입니다';
		    message += '&nbsp; <input type="button" value="처음 위치로 복귀" onclick="location.reload();"/><br/>';
		    message += '<p>선택한 지점의 장소명 : <input type="text" name="address"/> &nbsp;';
		    message += '<input type="button" value="장소 저장" onclick="addressCheck('+latlng.getLat()+','+latlng.getLng()+')"/>';
		    
		    //var resultDiv = document.getElementById('clickLatlng'); 
		    //resultDiv.innerHTML = message;
		    document.getElementById("clickPoint").innerHTML = message;
		});
	</script>
	<hr/>
	<div style="color:black;">
	  <p>
			<button type="button" class="create btn-warning"  onclick="location.href='${ctp}/admin/adAddressName2';" style= "width:200px;">저장된 지명 검색 & 삭제</button>
			<button type="button" class="create btn-warning"  onclick="location.href='${ctp}/admin/adAddressName3';" style= "width:160px;">지명 검색</button>
			<button type="button" class="create btn-warning"  onclick="location.href='${ctp}/admin/adAddressName';" style= "width:160px;">돌아가기</button>
	  </p>
	</div>   
 </div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>