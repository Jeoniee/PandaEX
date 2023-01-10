<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>PANDA</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 헤더 -->
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/css.jsp"%>
<!-- JS -->

<!-- css -->
<style type="text/css">
.py-5 {
    padding-top: 3rem;
    padding-bottom: 3rem;
	padding-left: 6rem;
}
.how-active1 {
    color: #28a745;
}

.px-2 {
    padding-right: 1rem!important;
    padding-left: 1rem!important;
}
.row {
    margin-top: 100px;
    margin-bottom: 100px;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}
.stext-104 {
    font-family: fangsong;
    font-size: 20px;
    line-height: 2;
}
.stext-105 {
    font-family: ui-monospace;
    font-size: 18px;
    line-height: 1.466667;
    letter-spacing: 1px;
}
.cl4 {
    color: #343a40;
}
</style>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c915430ac4edcd6aa694ae234c0de27"></script>
<script type="text/javascript">

$(function() {
	
	$("#sort").val($("#g_sort").val()).prop("selected", true);
	
	$("#searchA").keydown(function(keyNum){
		if(keyNum.keyCode == 13){ 
			var keyword = $("#searchA").val();
			var sort = $("#sort").val();
			location.href='/goods/list?k='+keyword+'&s='+sort;
		}
	})
	
	$('#sort').change(function() {
		var sort = $("#sort").val();
		var keyword = $("#searchA").val();
		location.href='/goods/list?s='+sort;
		if (keyword!="") {
			location.href='/goods/list?k='+keyword+'&s='+sort;
		}
	});
	
});

$(function() {
	   $('#findlocationH').on('click', function() {
	   	if($('#us').val()!="") {
	      navigator.geolocation.getCurrentPosition(function(position) {
	         var error = "위치정보 조회실패";
	         var error2 = "위치정보 조회를 동의 후 재시도해주세요";
	         var succe = "위치조회가 완료되었습니다.";
	         var userlat = position.coords.latitude;
	         var userlong = position.coords.longitude;
	         var href = window.location.href;
	         var userlocation = {
	               "userlat" : userlat,
	               "userlong" : userlong
	         };
	         $.ajax({
	            type : "get",
	            url : href,
	            data : userlocation,
	            async:false,
	            success : function(data) {
	               $.ajax({
	                  type : 'get',
	                  url : "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x="+userlong+"&y="+userlat,
	                  headers: {
	                          Authorization: "KakaoAK 02cf39cd2fef571915d16c04ab4e60f7"
	                      },
	                      datatype : 'json',
	                      async:false,
	                  success : function(data){      
	                     var address = JSON.stringify(data);
	                     var addp = JSON.parse(address);
	                     var si = addp.documents[0].region_1depth_name;
	                     var gu = addp.documents[0].region_2depth_name;
	                     var keyword = $("#searchA").val();
	         			 var sort = $("#sort").val();
	                     $('#locationH').html(si+","+gu);
	                     if (keyword!="" & sort!="") {
	                     location.href='/goods/list?k='+keyword+'&s='+sort+'&l='+si+'&ll='+gu;
	                     }
	                     else if (keyword!="") {
	                    	 location.href='/goods/list?k='+keyword+'&l='+si+'&ll='+gu;
	                     }
	                     else if (sort!="") {
	                    	 location.href='/goods/list?s='+sort+'&l='+si+'&ll='+gu;
	                     }
	                     location.href='/goods/list?l='+si+'&ll='+gu;
	                  }
	               });
	            }   
	         });
	      });
	   	}
	   });
});
	   

</script>
</head>
<body>
<!-- 위치 -->
<input type="hidden" value="${param.s}" name="g_sort" id="g_sort">
<input type="hidden" value="${user_id}" id="us">
<div class="container">
  <div class="row">
     <div class="col-8 py-4 px-5 " style="background-color: #ecc84a; border-color: #ecc84a; border-radius: 40px 0px 0px 40px/ 40px 0px 0px 40px;" >
    	<h5 class="text-white mt-1"> 내가 선택한 위치는  </h5>
    	<c:if test="${param.l!=null}">
    	<h5 class="text-white"><span class="text-white" id="locationH"><b>${param.l }, ${param.ll }</b></span> 입니다</h5>	
    	</c:if>
    	<c:if test="${param.l==null and user_id!=null}">
        <h5 class="text-white"><span class="text-white" id="locationH"><b>${vo.user_addr }, ${vo.user_area }</b></span> 입니다</h5>
        </c:if>
        <c:if test="${user_id==null}">
        <h5 class="text-white"><span class="text-white" id="locationH"><b>로그인하시면 확인하실 수 있습니다.</b></span></h5>
        </c:if>
    </div>
    <div class="col py-4 px-3 bg-light" style="border-radius: 0px 40px 40px 0px/ 0px 40px 40px 0px;">
    	<a href="#" class="btn btn-info" id="findlocationH" role="button" style="background-color: #ecc84a; border-color: #ecc84a; margin-left: 180px; margin-top: 30px"> 
    		<i>현재 위치로 변경하기 ▶ </i>
    	</a>
    </div>
  </div>
  <!-- 위치 -->
  
    <!-- 카테고리 -->
	<div class="filter-tope-group" align="center" style="margin-top: 50px;">
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*"><b>All</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".전자기기"><b>전자기기</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".의류"><b>의류</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".생활가전"><b>생활가전</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".인테리어"><b>인테리어</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".도서"><b>도서</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".교환권"><b>교환권</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".식품"><b>식품</b></button>
		<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".기타중고물품"><b>기타 중고물품</b></button>
	</div>
	<!-- 카테고리 -->
	
	<!-- 메뉴(최신순,인기순 등) -->
	<div class="row mb-4 mt-5">
	    <div class="col-9 mr-5">
	        <h2 class="fw-bold"><b>중고상품</b></h2>
 	    </div>
	    <div class="col pl-0 mr-5">
                <select class="form-select form-select-sm border-0 text-muted" id="sort">
                    <option value="0">최신 등록순</option>
                    <option value="1">가격&#8593;순</option>
                    <option value="2">가격&#8595;순</option>
                    <option value="3">조회수순</option>
                </select>
            </div>
	    
	    <div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
				<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
				<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
				Search
			</div>
	 </div>
	 <div class="dis-none panel-search w-full p-t-10 p-b-15">
			<div class="bor8 dis-flex p-l-15">
				<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
					<i class="zmdi zmdi-search"></i>
				</button>
				<input class="mtext-107 cl2 size-114 plh2 p-r-15" id="searchA" type="text" name="search-product" placeholder="Search" value="${param.k }">
			</div>	
		</div>
	<!-- 메뉴(최신순,인기순 등) -->
	
	<!-- 상품목록 -->
	<c:set var="size" value="${GoodsList.size() }" />
	<c:set var="col" value="4" />
	<c:set var="row" value="${ Math.ceil(size/col) }" />
	<c:set var="num" value="0" />
	
	<h7>총 게시글 수 : ${GoodsList.size()}</h7>
	<div class="row isotope-grid">	
		<c:forEach begin="1" end="${row }" step="1">
			<c:forEach var="i" begin="1" end="${col }" step="1">
				<c:if test="${num < size}">
					<c:set var="vo" value="${GoodsList[num]}" />
					<div class="card rounded border-0 mb-4 px-2 isotope-item ${vo.goods_category}" style="width: 300px; height: 380px;">
						<img src="${vo.thumbnail }" class="rounded" alt="사진없음">
						<div class="block2-txt flex-w flex-t p-t-14">
							<div class="block2-txt-child1 flex-col-l ">
								<a href="/goods/read?goods_no=${vo.goods_no}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
									<c:choose>
									 	<c:when test="${vo.goods_trade == '판매중'}">			
											<button type="button" class="btn btn-outline-success">${vo.goods_trade}</button>&nbsp; <b>${vo.goods_title }</b>
										</c:when>
									 	<c:when test="${vo.goods_trade == '예약중'}">			
											<button type="button" class="btn btn-outline-warning">${vo.goods_trade}</button>&nbsp; <b>${vo.goods_title }</b>
										</c:when>
									 	<c:otherwise>			
											<button type="button" class="btn btn-outline-secondary">${vo.goods_trade}</button>&nbsp; <b>${vo.goods_title }</b>
										</c:otherwise>
									</c:choose>
								</a>
	
								<span class="stext-105 cl3 text-success">
									<fmt:formatNumber value="${vo.goods_price }" pattern="#,###"/> 원
								</span>
								<span class="stext-106 cl4">
									조회수 ${vo.viewcount } 
									채팅 
								</span>
							</div>
							<div class="block2-txt-child2 flex-r p-t-3">
								<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
									<img class="icon-heart1 dis-block trans-04" src="/resources/images/icons/icon-heart-01.png" alt="ICON">
									<img class="icon-heart2 dis-block trans-04 ab-t-l" src="/resources/images/icons/icon-heart-02.png" alt="ICON">
								</a>
							</div>
						</div>
					  </div>
					<c:set var="num" value="${num+1 }" />
				</c:if>
			</c:forEach>
		</c:forEach>
	</div>
</div>
<!-- 상품목록 -->



<!-- 푸터 -->
<%@ include file="../include/footer.jsp"%>
</body>
</html>