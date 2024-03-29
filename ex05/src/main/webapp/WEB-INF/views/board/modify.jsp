<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html lang="en">

<%@include file="../includes/header.jsp" %>

<body class="bg-gradient-primary">


    <div class="container">
    
    <div class="bigPictureWrapper">
		<div class="bigPicture">
				
		</div>
	</div>

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">도서 등록</h1>
                            </div>
                            <form role="form" action="/board/modify" method="post">
                               	<div class="form-group">
                               		<label>Bno</label>
                               		<input class="form-control" name='bno'
                               		value='<c:out value="${board.bno }"/>' readonly="readonly">
                               	</div>
                               	<div class="form-group">
                               		<label>Title</label>
                               		<input class="form-control" name='title'
                               		value='<c:out value="${board.title }"/>' >
                               	</div>
                               	<div class="form-group">
                               		<label>Text area</label>
                               		<textarea rows="3" class="form-control" 
                               		name='content'><c:out value="${board.content }"/>
                               		</textarea>
                               	</div>
                               	<div class="form-group">
                               		<label>Writer</label>
                               		<input class="form-control" name='writer'
                               		value='<c:out value="${board.writer }"/>' >
                               	</div>
                               	<!-- 난 진짜 이게 왜 안되는 건지 모르겠다...
                               	<div class="form-group">
                               		<label>RegDate</label>
                               		<input class="form-control" name='regdate'
                               		value='<fmt:formatDate pattern="yyyy/MM/dd" 
                               		value="${board.regdate }" />' readonly="readonly">
                               	</div>
                               	<div class="form-group">
                               		<label>Update Date</label>
                               		<input class="form-control" name='updateDate'
                               		value='<fmt:formatDate pattern="yyyy/MM/dd" 
                               		value="${board.updateDate }" />' readonly="readonly">
                               	</div>
                               	 -->
                               	<button type="submit" data-oper='modify' 
                               	class="btn btn-primary">Modify
                               	</button>
                               	<button type="submit" data-oper='remove' 
                               	class="btn btn-danger">Remove
                               	</button>
                               	<button type="submit" data-oper='list' 
                               	class="btn btn-info">List
                               	</button>
                               	<input type="hidden" name="pageNum" 
                					value='<c:out value="${cri.pageNum }"/>'>
                				<input type="hidden" name="amount"
                					value='<c:out value="${cri.amount }"/>'>
                				<input type="hidden" name="type"
                					value='<c:out value="${cri.type }"/>'>
                				<input type="hidden" name="keyword"
                					value="<c:out value='${cri.keyword }'/>">
                            </form>
                            <hr>
                        </div>
                        <div class="row" style="margin-left: 30px">
		                	<div class="panel panel-heading">
		                		Files
		                	</div>
							<div class="panel-body">
								<div class="form-group uploadDiv">
									<input type="file" name="uploadFile" mutiple='multiple'>
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
        </div>
    </div>
    
    
<%@include file="../includes/footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {
		
		// attachList 에서 꺼내기
		(function() {
			
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
				console.log("arr : "+arr);
				
				var str = "";
				
				$(arr).each(function(i,attach){
					
					//image type
					if(attach.fileType){
						
						var fileCallPath = encodeURIComponent(
								attach.uploadPath + "/s_" 
								+ attach.uuid + "_" 
								+ attach.fileName);
						
						console.log("file Path [" + i + "] : " + fileCallPath);
						
						str += "<li data-path='" + attach.uploadPath 
							+ "' data-uuid='" + attach.uuid 
							+ "' data-filename='" + attach.fileName 
							+ "' data-type='" + attach.fileType + "' >";
							
						str += "<div>";
						str += "<span> " + attach.uploadPath + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str += "</li>";
							
					}
					else {
						str += "<li data-path='" + attach.uploadPath 
						+ "' data-uuid='" + attach.uuid 
						+ "' data-filename='" + attach.fileName 
						+ "' data-type='" + attach.fileType + "' ><div>";
						
						str += "<span>" + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='${path}/resources/img/attach.png'>";
						str += "</div>";
						str += "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);	
			});
			
		})();
		
		
		
		
		
		
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;

		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			for (var i = 0; i < files.length; i++) {

				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
									
				formData.append("uploadFile",files[i]);
			}
			$.ajax({
				url : '${path}/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					showUploadResult(result);
				}
			});
		});
		
		function showUploadResult(uploadResultArr) {
			if(!uploadResultArr || uploadResultArr.length == 0){return;}
			
			var uploadUL = $(".uploadResult ul");
			
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				if(obj.image) {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'data-type='" + obj.image + "'";
					str += "><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='${path}/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				}else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'data-type='" + obj.image + "'";
					str += "><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-cricle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='${path}/resources/img/bulls.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			});
			uploadUL.append(str);
		}
		
		
		
		
		
		
		
		
		
		
		$(".uploadResult").on("click","button",function(e){
			console.log("delete file");
			
			if (confirm("Remove this file? ")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		
		
		
		
		
		
		
		
		var formObj = $("form");
		
		$('button').on("click", function(e){
			
			// 기존 document 내에 있는 submit 을 막음
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			if(operation === 'remove'){
				//remove
				formObj.attr("action","/board/remove");
			}
			else if(operation ==='list'){
				//move to list
				//self.location = "/board/list"
				formObj.attr("action","/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				
			}else if(operation === 'modify') {
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj) {
					var jobj = $(obj);
					
					console.dir(jobj);
					
					str += "<input type='hidden' name ='attachList["+i+"].fileName' value='"+ jobj.data("filename") + "'>";
					str += "<input type='hidden' name ='attachList["+i+"].uuid' value='"+ jobj.data("uuid") + "'>";
					str += "<input type='hidden' name ='attachList["+i+"].uploadPath' value='"+ jobj.data("path") + "'>";
					str += "<input type='hidden' name ='attachList["+i+"].fileType' value='"+ jobj.data("type") + "'>";
					
					formObj.append(str).submit();
				});
			}
			
			formObj.submit();
		});
	});
</script>