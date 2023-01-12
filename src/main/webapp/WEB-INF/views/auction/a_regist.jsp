<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- 헤더 -->
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/css.jsp"%>
<!-- 서머노트를 위해 추가해야할 부분 -->
<script	src="https://code.jquery.com/jquery-3.4.1.slim.min.js" 
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<!-- 글자수체크 -->
<script>
	$(document).ready(function(){
		$(".contentsLength").keyup(function(e) {
			//console.log("#########################");
			console.log($(this)[0].id);
			
			//alert("@@@@@@@@@@@@@@@@@@@@");
		    //console.log("키업!");
			var content = $(this).val();
			$("#textLengthCheck").val("(" + content.length + "/ 30)"); //실시간 글자수 카운팅
			if (content.length > 30) {
				alert("최대 30자까지 입력 가능합니다.");
				$(this).val(content.substring(0, 30));
				$('#textLengthCheck').html("(30 / 최대 30자)");
			}
		});
		
		$("#resetB").click(function() {
			$(".note-editable").empty();
		});
	});
</script>

<!--  CSS -->
<style type="text/css">
.card {
    margin: auto;
    margin-top: 130px;
    margin-bottom: 70px;
    width: 1050px;
}
.card-body {
    padding: 4.5rem;
}
.form-check-label {
    padding-left: 0.5rem;
    padding-right: 1.5rem;
    align-content: center;
}
.form {
	align-content: center;
}
.py-4 {
    padding-top: 1rem!important;
}
.btn {
    padding: 3rem 3rem;
    font-size: 1rem;
    line-height: 1.25;
    border-radius: 0.25rem;
}
.form-check-input { 
    position: absolute;
    margin-top: 0.25rem;
    margin-left: -1.25rem;
    accent-color: #28a745;
}
.form-control:focus {
  border-color: #28a745;
}
</style>
</head>
<body >
<!-- 상품찜 -->
<input type="hidden" name="auction_like" value="off">
<!-- 판매현황 -->
<input type="hidden" name="auction_trade" value="0">
<!-- 0:등록, 1:예약 2:완료 -->
<!-- 작성자 -->


<!-- 본문 -->
<form method="post" enctype="multipart/form-data">
<input type="hidden" name="${sessionScope.user_no}" value="user_no">
	<div class="container">
		<div>
				<div class="card">
					<div class="card-body">
						<div>
							<div class="col-sm">
								<h2>상품등록</h2><hr>
							</div>
						</div>
						<div class="row py-4 border-bottom">
							<div class="col-sm-2">
								<label class="form-label">이미지</label>
							</div>
							<div class="col-sm d-flex">
								<div class="inputArea">
							 <label for="gdsImg"></label>
							 <input type="file" id="uploadFile" name="file" accept=".jpg,.png,.jpeg"/>
							 <div class="select_img"><img src="" /></div>
							 
							 <!-- 등록할 사진 보여주기 -->
							 <script>
							  $("#uploadFile").change(function(){
							   if(this.files && this.files[0]) {
							    var reader = new FileReader;
							    reader.onload = function(data) {
							     $(".select_img img").attr("src", data.target.result).width(150);        
							    }
							    reader.readAsDataURL(this.files[0]);
							   }
							  });
							 </script>
								</div>
							</div>
						</div>
						이미지 실제경로 : <%=request.getRealPath("/") %>
						
						<div class="row py-4 border-bottom">
							<div class="col-sm-2">
								<label for="auction_title" class="form-label"></label>
							</div>
							<div class="col-sm">
								<br>* 상품 이미지는 640x640에 최적화 되어 있습니다. 
								<br>- 상품 이미지는 PC에서는 1:1, 모바일에서는 1:1.23 비율로 보여집니다. 
								<br>- 이미지는 상품 등록 시정사각형으로 잘려서 등록됩니다. 
								<br>- 이미지를 클릭할 경우 원본 이미지를 확인할 수 있습니다. 
								<br>- 이미지를 클릭 후 이동하여 등록순서를 변경할 수 있습니다. 
								<br>- 큰 이미지일 경우 이미지가 깨지는 경우가 발생할 수 있습니다. 
								<br>최대 지원 사이즈인 640 X 640으로 리사이즈 해서 올려주세요.(개당 이미지 최대 10M)
							</div>
						</div>
						<div class="row py-4 border-bottom">
							<div class="col-sm-2">
								<label for="auction_category" class="form-label">카테고리</label>
							</div>
							<div class="col-sm">
								<select class="form-control" id="auction_category" name="auction_category">
									<option selected>카테고리를 입력하세요</option>
									<option value="전자기기">전자기기</option>
									<option value="의류">의류</option>
									<option value="생활가전">생활가전</option>
									<option value="인테리어">인테리어</option>
									<option value="도서">도서</option>
									<option value="교환권">교환권</option>
									<option value="식품">식품</option>
									<option value="기타중고물품">기타중고물품</option>
								</select>
							</div>
						</div>
						<div class="row py-4 border-bottom">
							<div class="col-sm-2">
								<label for="auction_title" class="form-label">상품명</label>
							</div>
							<div class="col-sm">
								<input type="text" class="form-control contentsLength" id="searchKeyword" name="auction_title" placeholder="상품명을 입력해주세요" maxlength="30" />
								<div class="text-right mt-1">
									<span class="text-success">
										<input type="text" id="textLengthCheck" style="display: inline-block; text-align: right;">
									</span>
								</div>
							</div>
						</div>
						<div class="row py-4 border-bottom" style="margin-top:-30px;">
							<div class="col-sm-2">
								<label class="form-label">가격</label>
							</div>
							<div class="col-sm">
								<input type="number" class="form-control" name="auction_price" placeholder="숫자만 입력하세요" maxlength="9" />
							</div>
							<div class="col-sm align-self-center">원</div>
						</div>
						<div class="row py-4 border-bottom">
						<div class="col-sm-2">
							<label class="form-label">상품상태</label>
						</div>
						<div class="col-sm">
							<div class="col-sm-10">
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="auction_condition" value="상"> 
									<label class="form-check-label" for="inlineRadio1">상</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="auction_condition" value="중"> 
									<label class="form-check-label" for="inlineRadio2">중</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="auction_condition" value="하"> 
									<label class="form-check-label" for="inlineRadio3">하</label>
								</div>
							</div>
						</div>
					</div>
						<div class="row py-4 border-bottom">
							<div class="col-sm-2">
								<label class="form-label">상품소개</label>
							</div>
							<div class="col-sm">
								<textarea id="summernote" name="auction_detail" rows="5" maxlength="100"></textarea>
								<div class="text-right mt-1">
									<span class="text-success"></span>
								</div>
								<script>
								 $('#summernote').summernote({
				    			        tabsize: 2,
				    			        height: 150,
				    			        id: 'contentsLength',
				    			        toolbar: [
				    			          ['style', ['style']],
				    			          ['font', ['bold', 'underline', 'clear']],
				    			          ['color', ['color']],
				    			          ['para', ['ul', 'ol', 'paragraph']],
				    			          ['table', ['table']],
				    			          ['insert', ['link', 'picture', 'video']],
				    			          ['view', ['fullscreen', 'codeview', 'help']]
				    			        ]
				    			  });
								 </script>
								 
							</div>
						</div>
						<div class="G_btn" align="center">
							<button type="submit" class="btn btn-success py-2 px-3">작성완료</button>
							<button type="reset" class="btn btn-success py-2 px-3" id="resetB">초기화</button>
							<button onclick="href='/auction/a_list';" class="btn btn-success py-2 px-3">목록이동</button>
						</div>
					</div>
				</div>
		</div>
	</div>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		//태그와 줄바꿈, 공백을 제거하고 텍스트 글자수만 가져옵니다.
		function setContentsLength(str, index) {
		    var status = false;
		    var textCnt = 0; //총 글자수
		    var maxCnt = 10; //최대 글자수
		    var editorText = f_SkipTags_html(str); //에디터에서 태그를 삭제하고 내용만 가져오기
		    editorText = editorText.replace(/\s/gi,""); //줄바꿈 제거
		    editorText = editorText.replace(/&nbsp;/gi, ""); //공백제거

	        textCnt = editorText.length;
		    if(maxCnt > 0) {
	        	if(textCnt > maxCnt) {
	                status = true;
	        	}
		    }

		    if(status) {
	        	var msg = "등록오류 : 글자수는 최대 "+maxCnt+"까지 등록이 가능합니다. / 현재 글자수 : "+textCnt+"자";
	        	console.log(msg);
		    }
		}
		
		//에디터 내용 텍스트 제거
		function f_SkipTags_html(input) {
			// 허용할 태그는 다음과 같이 소문자로 넘겨받습니다. (<a><b><c>)
		    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
		    commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
		    return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
		    });
		}
	});
	
	
</script>
<!--   푸터 -->
<%@ include file="../include/footer.jsp"%>
</body>
</html>