<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>
					
					
					<!-- Redirect register -->
					<div class="panel-heading" style="position: relative; height: 40px">
						Board List Page
						<button id="regBtn" type="button" 
						class="btn btn-primary" 
						style="position: absolute; top:0; right:0; ">
							Register New Book
						</button>
					</div>
                   
                   
                   
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>#번호</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>수정일</th>
                                        </tr>
                                    </thead>
                                    
                                    <c:forEach items="${list }" var="board">
                                    	<tr>
                                    		<td><c:out value="${board.bno }" /></td>
                                    		<td>
                                    			<a class="move" href='<c:out value="${board.bno }"/>'>
                                    				<c:out value="${board.title }" />
                                    			</a>
                                    		</td>
                                    		<td><c:out value="${board.writer }" /></td>
                                    		<td><fmt:formatDate pattern="yyyy-MM-dd" 
                                    		 value="${board.regdate }"/></td>
                                    		<td><fmt:formatDate pattern="yyyy-MM-dd"
                                    		 value="${board.updateDate }" /></td>
                                    	</tr>
                                    </c:forEach>
                                </table>
                                
                                <div class="col-lg-12">
                                	<form action="/board/list" method="get" id="searchForm">
                                		<select name="type" id="option" style="width: 150px;"
                                		class="custom-select custom-select-sm form-control form-control-sm">
                                			<option value=""
                                			<c:out value="${pageMaker.cri.type eq null?'selected':'' }"/>>--
                                			<option value="T"
                                			<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목
                                			<option value="C"
                                			<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용
                                			<option value="W"
                                			<c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자
                                			<option value="TC"
                                			<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용
                                			<option value="TW"
                                			<c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자
                                			<option value="TCW"
                                			<c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목 or 내용 or 작성자
                                		</select>
                                		<input type="text" name="keyword" id="keyword" 
                                		value=<c:out value="${pageMaker.cri.keyword }"/>>
                                		<input type="hidden" name="pageNum" 
                                		value=<c:out value="${pageMaker.cri.pageNum }"/>>
                                		<input type="hidden" name="amount" 
                                		value=<c:out value="${pageMaker.cri.amount }"/>>
                                		<button class="btn btn-primary">Search</button>
                                	</form>
                                </div>
                                
                                <!-- 없는 거라 포기 -->
                                <div class="col-md-7" style="margin-top : 20px;">
                                	<ul class="pagination">
                                		<c:if test="${pageMaker.prev}">
                                			<li class="paginate_button page-item previous disabled" id="dataTable_previous">
                                				<a href="${pageMaker.startPage-1 }" 
                                				class="btn btn-primary">
                                				Previous</a>
                                			</li>
                                		</c:if>
                                		
                                		<c:forEach var="num" begin="${pageMaker.startPage }"
                                		 end="${pageMaker.endPage }">
                                		 	<li class='paginate_button page-item ${pageMaker.cri.pageNum == num?"active":"" }'>
                                		 		<a href="${num }" class="btn">${num }</a>
                                		 	</li>
                                		 </c:forEach>
                                		 
                                		 <c:if test="${pageMaker.next }">
                                		 	<li class="paginate_button page-item next disabled" id="dataTable_next">
                                		 		<a href="${pageMaker.endPage + 1 }" class="btn btn-primary">Next</a>
                                		 	</li>
                                		 </c:if>
                                	</ul>
                                </div>
                                
                                 <!-- Modal add -->
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                                aria-labelledby="myModalLabel" aria-hidden="true">
                                <!-- aria = Accessible Rich Internet Applications -->
                                	<div class="modal-dialog">
                                		<div class="modal-content">
                                			<div class="modal-header">
                                				<button type="button" class="close" 
                                				data-dismiss="modal"
                                				aria-hidden="true">
                                					&times;
                                				</button>
                                				<div class="modal-body">
                                					처리가 완료되었습니다
                                				</div>
                                				<div class="modal-footer">
                                					<button type="button" 
                                					class="btn btn-default"
                                					data-dismiss="modal">
                                						Close
                                					</button>
                                					<button type="button"
                                					class="btn btn-primary"
                                					data-dismiss="modal">
                                						Save changes
                                					</button>
                                				</div>
                                			</div> 
                                			<!-- /.modal-header -->
                                		</div>
                                		<!-- /.modal-content -->
                                	</div>
                                	<!-- /.modal dialog -->
                                </div>
                                <!-- /.modal fade -->
                            </div>
                        </div>
                    </div>
	
	<form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>'>
	</form>
	
<%@include file="../includes/footer.jsp" %>

	<!-- register 와 연동하기 위한 modal -->
 	<script type="text/javascript">
 	// jQuery 추가
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';
		
        checkModal(result);
        
        history.replaceState({},null,null);
        
        
        function checkModal(result) {
        	
            if(result ==='' || history.state){
                return;
            }

            if(parseInt(result)>0){
                $(".modal-body").html("게시글 "+result+"등록");
            }
            $("#myModal").modal('show');
        }

		
        // 도서 등록 페이지로 이동하는 버튼 기능 추가
        $("#regBtn").on("click",function() {
        	self.location = "/board/register";
        });
        
        var actionForm = $("#actionForm")
        $(".paginate_button a").on("click",function(e) {
        	
        	e.preventDefault();
        	
        	console.log("click")
        	
        	actionForm.find("input[name='pageNum']").val($(this).attr("href"))
        	actionForm.submit()
        })
        
        $(".move").on("click",function(e) {
        	
        	e.preventDefault()
        	actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>")
        	actionForm.attr("action","/board/get")
        	actionForm.submit()
        })
        
        
        // 검색할 때 1 페이지로 이동 및 검색종류 설정 및 키워드 입력이 없을 시 alert 실행 후 false 리턴
        var searchForm = $("#searchForm");
        $("#searchForm button").on("click", function(e){
        	// 검색옵션을 선택하지 않을 시
        	if (!searchForm.find("option:selected").val()){
        		alert("검색 종류를 선택하세요");
        		$("#option").focus();
        		return false;
        	}
        	if (!searchForm.find("input[name='keyword']").val()){
        		alert("키워드를 입력하세요");
        		$("#keyword").focus();
        		return false;
        	}
        	
        	searchForm.find("input[name='pageNum']").val("1");
        	e.preventDefault();
        	
        	searchForm.submit();
        })
	});
	</script>
