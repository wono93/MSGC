<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/edocList.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4c554cd518.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
    <title>listForm</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <section>
        <div>
            <article>
                <div class="subNav">
                    <h3>전자결재</h3>
                    <ul>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/srch.do'">문서검색</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/list.do'">내문서함</li>
                        <li onclick="location.href='${pageContext.request.contextPath}/edoc/write.do'">문서기안</li>
                     </ul>
                </div>
                <div class="content">
                    <div class="control">
                        <div>
                            <h1>문서 유형</h1>
                            <div class="checkbox_wrap">
                                <label class="myDocu-container kor float" for="myDocu">내 기안문서
                                            <input type="checkbox" name="myDocu" id="myDocu" class="docuCheck" value="myDocu" checked="checked">
                                            <span class="myDocu-checkmark"></span>
                               </label>
                                <label class="reqDocu-container kor float" for="reqDocu">결재요청문서
                                            <input type="checkbox" name="reqDocu" id="reqDocu" class="docuCheck" value="reqDocu" checked="checked">
                                            <span class="reqDocu-checkmark"></span>
                               </label>
                                <label class="compDocu-container kor float" for="compDocu">결재완료문서
                                            <input type="checkbox" name="compDocu" id="compDocu" class="docuCheck" value="compDocu" checked="checked">
                                            <span class="compDocu-checkmark"></span>
                               </label>
                                <label class="refDocu-container kor float" for="refDocu">참조 문서
                                            <input type="checkbox" name="refDocu" id="refDocu" class="docuCheck" value="refDocu" checked="checked">
                                            <span class="refDocu-checkmark"></span>
                               </label>
                            </div>
                        </div>
                    </div>
                    <table>
                        <tr>
                            <th>문서ID</th>
                            <th>문서종류</th>
                            <th>제목</th>
                            <th>기안자</th>
                            <th>보안등급</th>
                            <th>기안일</th>
                            <th>유형</th>
                            <th>상태</th>
                        </tr>
					<c:forEach items="${myEdocList }" var="ed">
						<tr data-edoc-no="${ed.edocId }">
							<td>${ed.edocId }</td>
							<td>${ed.formNm }</td>
							<td>${ed.edocTitle }</td>
							<td>${ed.empName }</td>
							<td>${ed.secuNm }</td>
						<c:if test="${ed.edocEnd =='y' }">
							<td>내 기안 문서</td>
							<c:set var="flowStVal" value="false"/>
							<c:forEach items="${myEdocList.SrchFlowList	}" var="sf">
								<c:if test="${sf.flowSt = 'n'}">
									<c:set var="flowStVal" value="true"/>
								</c:if>
							</c:forEach>
							<c:if test="${flowStVal } == 'true'">
								<td>반려</td>
							</c:if>
							<c:if test="${flowStVal } == 'false'">
								<td>대기</td>
							</c:if>
						</c:if>
						<c:if test="${ed.edocEnd !='y' }">
							<c:forEach items="${myEdocList.srchFlowList }" var="sf">
								<c:if test="${sf.flowEmpNo } == ${sf.empNo } and ${sf.floword } != 1 and ${sf.flowSt } != 'y' and ${sf.flowNm } == '결재'">
									<td>
										결재요청문서
									</td>
									<td>
									
									</td>								
								</c:if>
								<c:if test="${sf.flowEmpNo } == ${sf.empNo } and ${sf.floword } != 1 and ${sf.flowSt } == 'y' and ${sf.flowNm } == '결재'">
									<td>
										결재완료문서
									</td>
									<c:if test="${empty sf.flowSt }">
										<td>
											대기
										</td>																	
									</c:if>
									<c:if test="${sf.flowSt } == 'n'">
										<td>
											반려
										</td>																	
									</c:if>
								</c:if>
								<c:if test="${sf.flowEmpNo } == ${sf.empNo } and ${sf.floword } != 1 and ${sf.flowSt } != 'y' and ${sf.flowNm } == '결재'">
									<td>
										참조문서
									</td>
									<td>
									</td>
								</c:if>
							</c:forEach>
						</c:if>
						</tr>
					</c:forEach>
                    </table>
                    <div class="pagination">
						${pageBar }
                    </div>
                    <div class="srchBar">
                        <div class="select-box">
                            <div class="select-box__current" tabindex="1">
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D0" value="edoc_title" name="Ben"/>
                                <p class="select-box__input-text">제목</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D1" value="emp_name" name="Ben"/>
                                <p class="select-box__input-text">기안자</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D2" value="form_nm" name="Ben"/>
                                <p class="select-box__input-text">문서종류</p>
                                </div>
                                <div class="select-box__value">
                                <input class="select-box__input" type="radio" id="D3" value="all" name="Ben" checked="checked"/>
                                <p class="select-box__input-text">전체</p>
                                </div><img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
                            </div>
                            <ul class="select-box__list">
                                <li>
                                <label class="select-box__option" for="D3" aria-hidden="aria-hidden">전체</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="D0" aria-hidden="aria-hidden">제목</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="D1" aria-hidden="aria-hidden">기안자</label>
                                </li>
                                <li>
                                <label class="select-box__option" for="D2" aria-hidden="aria-hidden">문서종류</label>
                                </li>
                            </ul>
                        </div>
                        <input type="text" name="" id="srchWord" placeholder="검색창 나중에 위 쪽으로 올릴것">
                        <button type="button" name="" id="srchBtn" class="yellowBtn"><i class="fas fa-search" style="font-size:15px"></i> 검색</button>
                    </div>
                </div>
            </article>
        </div>
    </section>
    <script>
    $(document).ready(function(){
    	$("tr[data-edoc-no]").on("click", function() {
			let edocId = $(this).attr("data-edoc-no");
			console.log(edocId);
			location.href="${pageContext.request.contextPath}/edoc/srchDtl.do?edocId="+edocId;
		});
 	});

    
	$("#srchBtn").click(function(){
		$("#srchBtn").trigger("srchStart");	
	})
	$(".docuCheck").change(function(){ // 상단 체크박스를 submit과 연동해 즉시 발동하도록 처리
		$("#srchBtn").trigger("srchStart");	
	})
		
	$("#srchBtn").bind("srchStart", function(){
		var arrayDocuCheck = new Array();
		$(".docuCheck:checked").each(function(){
			arrayDocuCheck.push($(this).val());
		});
		
		//폼 태그 생성
        var form = document.createElement('form');
        //폼 속성 set attribute
        form.name = 'newForm';
        form.method = 'get';
        form.action = '/msg/edoc/list.do';
        form.target = '_self';        
        //input 태그 생성
        var input1 = document.createElement('input');
        var input2 = document.createElement('input');
        var input3 = document.createElement('input');
        var input4 = document.createElement('input');
        //input태그에 set attribute
        input1.setAttribute("type", "hidden");
        input1.setAttribute("name", "member");
        input1.setAttribute("value", session.getAttribute("memberLoggedIn"));
        input2.setAttribute("type", "hidden");
        input2.setAttribute("name", "srchWord");
        input2.setAttribute("value", $("#srchWord").val());        
        input3.setAttribute("type", "hidden");
        input3.setAttribute("name", "srchType");
        input3.setAttribute("value", $("select-box__input:checked").val());
        input4.setAttribute("type", "hidden");
        input4.setAttribute("name", "arrayDocuCheck");
        input4.setAttribute("value", arrayDocuCheck);
        //완성된 input 태그를 form에 append
        form.appendChild(input1);
        form.appendChild(input2);
        form.appendChild(input3);
        form.appendChild(input4);
        //form 태그
        document.body.appendChild(form);
        // form 제출
        form.submit();
	});
	


	
    
    </script>
</body>
</html>