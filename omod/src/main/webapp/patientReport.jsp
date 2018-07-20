<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="localHeader.jsp"%>

<div>
<div id="searchform "
	style="background: #E2E4FF; border: 1px #808080 solid; padding: 0.5em; margin-bottom: 0em">
<form action=" " method="post">
<table>
	<tr>
		<td>Patient:</td>
		<td><openmrs:fieldGen type="org.openmrs.Patient"
			formFieldName="patientId" val="${patient}" /></td>
	</tr>
	<tr>
		<td><spring:message code="laboratorymanagement.from" /></td>
		<td><openmrs_tag:dateField formFieldName="startDate"
			startValue="${startdate}" /></td>

		<td><spring:message code="laboratorymanagement.to" /></td>
		<td><openmrs_tag:dateField formFieldName="endDate"
			startValue="${enddate}" /></td>
	</tr>
	<tr>
		<td><input type="submit" name="submitButton "
			value="<spring:message code="laboratorymanagement.search"/>"></td>
	</tr>
</table>
</form>
</div>
<br>
<br>
<br>
<c:if test="${fn:length(mappedLabExams)>0}">
	<b>LABORATORY TEST RESULTS</b>
	<div style="float: right;">
	<form action="exportToPDF.form" method="get"><input
		type="hidden" name="patientId" value="${patient.patientId}"> <input
		type="hidden" name="startDate" value="${startDate}"> <input
		type="hidden" name="endDate" value="${endDate}"> <input
		type="submit" value="Export to pdf"></form>
	</div>

	<br>

	<div id="Identification"
		style="border: 2px #000000 double; width: 100 %;">
	<div>
	<table>
		<tr>
			<td><spring:message code="laboratorymanagement.givenName" /> :</td>
			<td>${patient.givenName}</td>
		</tr>
		<tr>
			<td>patient name:</td>
			<td>${patient.familyName}</td>
		</tr>
		<tr>
			<td>Gender:</td>
			<td><img
				src="${pageContext.request.contextPath}/images/${patient.gender == 'M' ? 'male' : 'female'}.gif" /></td>

		</tr>
		<tr>
			<td>Patient Id:</td>
			<td>${patient.patientId}</td>

		</tr>
	</table>
	</div>


	</div>
	<br>
	<br>
	<div id="labResults" style="border: 2px #000000 double; width: 100 %;">

	<table width="100%" border="0">
		<td><b>Test name</b></td>
		<td><b>Result</b></td>
		<td><b>Normal range</b></td>
		<td>Orderer</td>
		<c:forEach var="labExamMap" items="${mappedLabExams}"
			varStatus="status">
			<tr>
				<td><b>${labExamMap.key}</b></td>
				<td></td>
				<td></td>
				<td></td>

			</tr>
			<c:forEach var="labTest" items="${labExamMap.value}"
				varStatus="status">
				<tr>
					<c:choose>
						<c:when test="${labTest[0].valueCoded != null}">
							<td><c:out value="${labTest[0].concept.name}" /></td>
							<td><c:out value="${labTest[0].valueCoded.name}" /></td>
							<td>-</td>
							<td><c:out value="${labTest[0].order.orderer.familyName}" /></td>
						</c:when>
						<c:when test="${labTest[0].valueNumeric != null}">
							<td><c:out value="${labTest[0].concept.name}" /></td>
							<td><c:out value="${labTest[0].valueNumeric}" /></td>
							<td><c:out value="${labTest[1]}" /></td>

							<td><c:out value="${labTest[0].order.orderer.familyName}" /></td>
						</c:when>
						<c:when test="${labTest[0].valueText != null}">
							<td><c:out value="${labTest[0].concept.name}" /></td>
							<td><c:out value="${labTest[0].valueText}" /></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</c:when>
						<c:when test="${labTest[0].valueDatetime != null}">
							<td><c:out value="${labTest[0].concept.name}" /></td>
							<td><openmrs:formatDate date="${labTest[0].valueDatetime}" /></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</c:when>
					</c:choose>

				</tr>
			</c:forEach>
		</c:forEach>
	</table>
	</div>
</c:if></div>
<%@ include file="/WEB-INF/template/footer.jsp"%>