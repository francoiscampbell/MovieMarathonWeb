<%--
  Created by IntelliJ IDEA.
  User: francois
  Date: 15-08-01
  Time: 9:12 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Possible Schedules</title>

    <!-- bower:css -->
    <asset:stylesheet src="../../assets/bower_components/bootstrap/dist/css/bootstrap.css"/>
    <asset:stylesheet
            src="../../assets/bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css"/>
    <!-- endbower -->
</head>

<body>
<div class="jumbotron">
    <div class="container">
        <g:set var="colon" value="${schedules.size() == 0 ? "schedules." : "schedules:"}"/>
        <h1>Generated ${schedules.size()} ${colon}</h1>
        <g:each in="${schedules}" var="schedule" status="i">
            <h2>Schedule ${i + 1} at ${schedule.theatre.name}:</h2>
            <g:each in="${schedule.showtimes}" var="showtime">
                <p>${showtime.toFriendlyString(true)}</p>
                <g:set var="delay" value="${schedule.getDelayAfterShowtime(showtime)}"/>
                <g:if test="${delay != null}">
                    <g:set var="minutes" value="${delay.getStandardMinutes()}"/>
                    <g:set var="plural" value="${Math.abs(minutes) == 1 ? "minute" : "minutes"}"/>
                    <g:set var="overlap" value="${minutes < 0 ? "Overlap" : "Delay"}"/>
                    <p>${overlap} of ${Math.abs(minutes)} ${plural}</p>
                </g:if>
            </g:each>
        </g:each>
    </div>
</div>

</body>
</html>