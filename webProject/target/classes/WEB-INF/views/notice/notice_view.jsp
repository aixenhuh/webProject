<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <body>
  <form id="form1" name="form1" method="post">
  	<input type="hidden" id="IDX" name="IDX" value=""></input>
  	<div id="notice_div">
	    <div id="app" class="container">
	    	<notice-component></notice-component>
	    </div>
	    <a id="write_btn" class="btn btn-default">글쓰기</a>
	    <div id="app2" class="text-center">
	    	<page-component></page-component>
	    </div>
	</div>
</form>
    <script>
	$(document).ready(function(){
		$('a#write_btn').on('click', function(){
			$.ajax({
                url:'/ajax/notice_write_ajax.jsp',
                type:'POST',
                error:function(xhr,status,e){
                       alert('Error' + e);
                },
                success: function(xml){
                    $("#notice_div").html(xml);
                }
         });
		});
	});
	
	function list(page){
		location.href="/notice/notice.do?curPage=" + page;
	}

    var noticeComponent = {
    		template : '<table :class="tableClass"><thead>\
    						<tr>\
    							<th>번호</th>\
    							<th>제목</th>\
    							<th>작성자</th>\
    							<th>날짜</th>\
    							<th>조회수</th>\
    						</tr>\
    						</thead>\
							<tbody>\
    						<template v-for="(item, index) in items">\
    								<tr>\
    								<td>{{ item.IDX }}</td>\
    								<td><a @click="noticeSelect(item.IDX)">{{ item.TITLE }}</a></td>\
    								<td>{{ item.ID }}</td>\
    								<td>{{ item.CREA_DTM }}</td>\
    								<td>{{ item.HIT_CNT }}</td>\
    								</tr>\
    						</template>\
    						</tbody>\
    						</table>\
    				        <hr/>\
    						',
    		data: function() {
    			return {
    				items : ${noticeList},
    	        	tableClass : 'table table-striped table-hover'
    			}
    		},
    		methods : {
    			noticeSelect : function(noticeNum){
    				$('#IDX').val(noticeNum);
    				$("#form1").attr('action', '/notice/notice_read.do');
    				$("#form1").submit();
				}
    		}
		};

    var pageComponent = {
    		template : '<ul class="pagination">\
							<li>\
								<a v-if="curBlock > 1" @click="prevList(prevPage)">1</a>\
							</li>\
							<li>\
								<template v-for="(item, index) in afterItem">\
									<a @click="numList(item)">{{ item }}</a>\
								</template>\
							</li>\
							<li>\
								<a v-if="curBlock <= totalBlock" @click="nextList(nextPage)">10</a>\
							</li>\
						</ul>\
    					',
    		data: function() {
    			return {
    				curBlock : ${pagenation.curBlock},
    				prevPage : ${pagenation.prevPage},
    				blockBegin : ${pagenation.blockBegin},
    				blockEnd : ${pagenation.blockEnd},
    				totalBlock : ${pagenation.totalBlock},
    				nextPage : ${pagenation.nextPage},
    	        	items : function () {
    	        		var item = new Array();
    	        		for(var i = blockBegin, j=0; i<= blockEnd; i++){
    	        			item[j] = i;
    	        			j++;
    	        		}
    	        		return item;
    	        	}
    			}
    		},
    		computed : {
    			afterItem : function(){
    				var blockBegin = this.blockBegin;
    				var blockEnd = this.blockEnd;
    				var item = new Array();
	        		for(var i = blockBegin, j=0; i<= blockEnd; i++){
	        			item[j] = i;
	        			j++;
	        		}
	        		return item;
    			}
    		},
    		methods : {
    			prevList : function(evt){
    				//list();
    			},
    			nextList : function(evt){
    				console.log(evt);
    			},
    			numList : function(evt) {
    				list(evt);
    			}
    		}
		}
        
    var vm = new Vue({
        el: '#app',
        components : {
        	'notice-component' : noticeComponent
        },
    	data: {
    		tableClass:"abd"
    	}
      });

    var vm1 = new Vue({
        el: '#app2',
        components : {
        	'page-component' : pageComponent
        },
    	data: {
    		tableClass:"abd"
    	}
      });
    </script>
  </body>
