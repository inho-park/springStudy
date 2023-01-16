<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html lang="en">

<%@include file="../includes/header.jsp" %>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">도서 등록</h1>
                            </div>
                            <form class="user" role="form" action="/board/register" 
                            method="post">
                                <!--	<div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="writer"
                                            placeholder="작가">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="exampleLastName"
                                            placeholder="Last Name">
                                    </div>
                                </div>  -->
                                <div class="form-group">
                                	<label>Title</label>
                                    <input type="text" class="form-control form-control-user"
                                    	 name="title"
                                        placeholder="책 제목">
                                </div>
                                <div class="form-group">
                                	<label>Writer</label>
                                    <input type="text" class="form-control form-control-user"
                                    	 name="writer"
                                        placeholder="작가 이름">
                                </div>
                                <div class="form-group">
                                	<label>Book Content</label>
                                	<textarea class="form-control" rows="3" name="content">
                                	</textarea>
                                </div>
                                <div class="form-group">
                                	<button type="submit" class="btn btn-default">
                                		SUBMIT 버튼
                                	</button>
                                	<button type="reset" class="btn btn-default">
                                		RESET 버튼
                                	</button>
                                </div>
                               <!--  </div>
                                <a href="login.html" class="btn btn-primary btn-user btn-block">
                                    Register Account
                                </a>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>  -->
                            </form>
                            <hr>
                        </div>
                        <div class="col-lg-12">
                		<div class="panel panel-default">
                			<div class="panel-hading">File Attach</div>
                			<div class="panel-body">
                				<div class="form-group uploadDiv">
                					<input type="file" name="uploadFile" multiple>
                				</div>
                				
                				<div class="uploadResult">
                					<ul>
                					
                					</ul>
                				</div>
                			</div>
                		</div>
                	</div>
                    </div>
                </div>
                <!--
                <div class="row">
                	<div class="col-lg-12">
                		<div class="panel panel-default">
                			<div class="panel-hading">File Attach</div>
                			<div class="panel-body">
                				<div class="form-group uploadDiv">
                					<input type="file" name="uploadFile" multiple>
                				</div>
                				
                				<div class="uploadResult">
                					<ul>
                					
                					</ul>
                				</div>
                			</div>
                		</div>
                	</div>
                </div>
                /.row -->
            </div>
        </div>
    </div>
<%@include file="../includes/footer.jsp" %>
	<script>
	
		$(document).ready(function(e){
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize){
				
				if(fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다");
					return false;
				}
				
				return true;
			}
			
			function showUploadResult(uploadResultArr) {
				
				if(!uploadResultArr || uploadResultArr.length==0) return;
				
				var uploadUL = $(".uploadResult ul");
				
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					if(obj.image) {
						console.log("showUpload : " + obj.uploadPath + " filename : " + obj.fileName);
						var fileCallPath = encodeURIComponent(obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
						
						str += "<li data-path='" + obj.uploadPath + "'";
						str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'data-type='" + obj.image + "'";
						str += "><div>";
						str += "<span>" + obj.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='${path}/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str += "</li>";
					}else {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "\\s_" + obj.uuid + "_" + obj.fileName);
						// var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
						
						str += "<li data-path='" + obj.uploadPath + "'";
						str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'data-type='" + obj.image + "'";
						str += "><div>";
						str += "<span>" + obj.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-cricle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='${path}/resources/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
					}
				});
				uploadUL.append(str);
			}
			
			$("input[type='file']").change(function(e){
				
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				for (var i=0; i<files.length; i++){
					
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				console.log("files : " + files);
				$.ajax({
					url: '${path}/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					dataType: 'json',
					success: function(result){
						console.log("Result : " + result);
						showUploadResult(result);
					}
				});
			});
			
			$(".uploadResult").on("click", "button", function(e) {
				console.log("delete File");
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");
				$.ajax({
					url : '${path}/deleteFile',
					data : {fileName: targetFile, type:type},
					dataType : 'text',
					type : 'POST',
					success : function(result) {
						alert(result);
						targetLi.remove();
					}
				});
			});
			
			
			var formObj = $("form[role='form']");
			
			$("button[type='submit']").on("click",function(e){
				
				e.preventDefault();
				
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj) {
					var jobj = $(obj);
					
					console.dir("jobj : " + jobj);
					
					str += "<input type='hidden' name ='attachList["+i+"].fileName' value='"+ jobj.data("filename") + "'>";
					str += "<input type='hidden' name ='attachList["+i+"].uuid' value='"+ jobj.data("uuid") + "'>";
					str += "<input type='hidden' name ='attachList["+i+"].uploadPath' value='"+ jobj.data("path") + "'>";
					str += "<input type='hidden' name ='attachList["+i+"].fileType' value='"+ jobj.data("type") + "'>";
					console.log("filename : " + i.fileName);
				});
				formObj.append(str).submit();
				
			});
		});
	</script>
