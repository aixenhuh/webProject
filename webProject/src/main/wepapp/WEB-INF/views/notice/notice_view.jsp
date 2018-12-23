<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <body>
    <div id="app" class="container">
    	<notice-component></notice-component>
        <child-component :table-class123="tableClass"></child-component>
    </div>
    <script>


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
    								<td>{{ item.id }}</td>\
    								<td>{{ item.name }}</td>\
    								<td>{{ item.age }}</td>\
    								<td>{{ item.title }}</td>\
    								<td>{{ item.content }}</td>\
    								</tr>\
    						</template>\
    						</tbody>\
    						</table>',
    		data: function() {
    			return {
    				items : [
    	        		{id : 'java', name:'abc', age:'11', title:'abc',content:'this'},
    	        		{id : 'java123', name:'abc123', age:'11123', title:'abc123',content:'this123'},
    	        		{id : 'java123', name:'abc333', age:'33333', title:'abc333',content:'this333'}
    	        	],
    	        	tableClass : 'table table-striped table-hover'
    			}
    		}
    }
    
    Vue.component('child-component', {
    	props: ['tableClass'],
    	template : '<div>{{ tableClass }}</div>'
    })
    
        
    var vm = new Vue({
        el: '#app',
        components : {
        	'notice-component' : noticeComponent
        },
    	data: {
    		tableClass:"abd"
    	}
      });
    </script>
  </body>
