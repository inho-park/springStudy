console.log("Reply Module");

var replyService = (function() {
	
	// 댓글 작성 시 데이터베이스에 추가하기 위한 함수
	function add(reply, callback, error) {
		console.log("reply.js : add()..............");
		
		$.ajax({
			type : 'post',
			url : '/reply/new',
			data : JSON.stringify(reply),
			// contentType 이 json 형태
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr) {
				// callback 을 함수로 받음
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				// error 를 함수로 받음
				if (error) {
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error) {
		console.log("reply.js : getList()............");
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/reply/pages/" + bno + "/" + page + ".json",
			function(data){
				if (callback) {
//					callback(data); // 댓글 목록만 가져오기
					callback(data.replyCnt, data.list); // 댓글 숫자와 목록을 가져오기
				}
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	function remove(rno, callback, error) {
		$.ajax({
			type : "delete",
			url : '/reply/' + rno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	
	function update(reply, callback, error) {
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type : "put",
			url : '/reply/' + reply.rno,
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(reply),
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
				
			}
		});
	}
	
	function get(rno, callback, error) {
		$.get("/reply/" + rno + ".json", function(result){
			if (callback) {
				callback(result);
			}
		}).fail(function(xhr, status, er){
			if (error) {
				error(er);
			}
		})
	}
	
	function displayTime(timeValue) {
		var today = new Date();
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
			
		// 댓글이 작성된 지 하루가 채 안됐을 시
		if(gap < (1000 * 60 * 60 * 24)) {
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':',
					(mi > 9 ? '' : '0') + mi, ':',
					(ss > 9 ? '' : '0') + ss].join('');
		}
		
		// 댓글이 작성된 날이 하루가 지났을 시
		else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd].join('');
		}
	}
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
})();

