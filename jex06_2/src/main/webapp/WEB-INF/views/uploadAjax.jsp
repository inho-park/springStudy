<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
   .uploadResult {
      width: 100%;
      background-color: gray;
   }
   
   .uploadResult ul {
      display: flex;
      flex-flow: row;
      justify-content: center;
      align-items: center;
   }
   
   .uploadResult ul li {
      list-style: none;
      padding: 10px;
   }
   
   .uploadResult ul li img {
      width: 20px;
   }
   
   .uploadResult ul li span {
      color:white;
   }
   
   .bigPictureWrapper {
      position: absolute;
      display: none;
      justify-content: center;
      align-items: center;
      top: 0%;
      width: 100%;
      height: 100%;
      background-color: gray;
      z-index: 100;
      background: rgba(255, 255, 255, 0.5);
   }
   
   .bigPicture {
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
   }
   
   .bigPicture img {
      width: 600px;
   }
</style>

<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
	<h1>Upload With Ajax</h1>
	
	<div class="uploadDiv">
        <input type="file" name="uploadFile" multiple />
    </div>
	   
    <div class="uploadResult">
        <ul>
      
    	</ul>
    </div>
   
    <div class="bigPictureWrapper">
    	<div class="bigPicture"></div>
    </div>
   
   
   <button id="uploadBtn">Upload</button>
	
    <script>
	    function showImage(fileCallPath) {
	        alert(fileCallPath);
	        $(".bigPictureWrapper").css("display", "flex").show();
	        $(".bigPicture")
	        .html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
	        .animate({width:'100%', height: '100%'}, 1000);
	    }

	    $(".bigPictureWrapper").on("click", function(e) {
	        $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
	        setTimeout(() => {
	            $(this).hide();
	        }, 1000);
	    });
	    
		$(document).ready(function(){
			
			// 파일 확장자를 검사하기 위한 변수
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			// 파일 크기를 검사하기 위한 변수
			var maxSize = 5242880; // 5MB
			// html 요소를 통째로 복사함
			var cloneObj = $(".uploadDiv").clone();
			
			function checkExtension(fileName, fileSize) {
				
				if(fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				
				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드 불가능");
					return false;
				}
				
				return true;
			}
			
			
			
			// 추가한 사진들을 확인하기 위한 목록 생성
			var uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr) {
				
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					if (!obj.image) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/"
										 + obj.uuid + "_" + obj.fileName);
						
						
						str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>"
						 	+ "<img src='/resources/img/attach.png'" + obj.fileName 
						 	+ "</a><span data-file=\'" + fileCallPath 
						 	+ "\' data-type='file'> X </span></div></li>";
					}else {						
						
						var fileCallPath = encodeURIComponent(obj.uploadPath+
								"/s_" + obj.uuid + "_" + obj.fileName);
						
						var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
						
						originPath = originPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li><a href=\"javascript:showImage(\'" + originPath +"\')\">" + 
						"<img src ='/display?fileName=" + fileCallPath + 
						"'></a><span data-file=\'" + fileCallPath 
					 	+ "\' data-type='image'> X </span></li>"
					}
				});
				uploadResult.append(str);
			}
			
			
			
			
			$("#uploadBtn").on("click", function(e){
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
			
				var files = inputFile[0].files;
				
				console.log("files : " + files);
				
				//add filedate to formdata
				for (var i = 0; i < files.length; i++){
					
					if(!checkExtension(files[i].name, files[i].size)) return false;
					
					formData.append("uploadFile", files[i]);
				}

				
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					dataType: 'json',
					success: function(result){
						console.log("result : " + result);
						showUploadedFile(result);
						$(".uploadDiv").html(cloneObj.html());
					}
				});
			
			});
			
			
			
			$(".uploadResult").on("click", "span", function(e) {
		         var targetFile = $(this).data("file");
		         var type = $(this).data("type");
		         console.log(targetFile);
		         
		         $.ajax({
		            url : '/deleteFile',
		            data : {fileName : targetFile, type : type},
		            dataType : 'text',
		            type : 'POST',
		            success : function(result) {
		               alert(result);
		            }
		         });
		    });
			
		});
	</script>
</body>
</html>