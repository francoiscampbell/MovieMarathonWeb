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
</head>

<body>
<div class="jumbotron">
    <div class="container">
        <h1>Generated ${schedules.size()} schedules:</h1>
        <g:each in="${schedules}" var="schedule" status="i">
            <h2>Schedule ${i + 1} at ${schedule.theatre.name}:</h2>
            <g:each in="${schedule.showtimes}" var="showtime">
                <p>${showtime.toFriendlyString(true)}</p>
                <g:set var="delay" value="${schedule.getDelayAfterShowtime(showtime)}"/>
                <g:if test="${delay != null}">
                    <g:set var="plural" value="${delay.getStandardMinutes() == 1 ? "minute" : "minutes"}"/>
                    <p>Delay of ${delay.getStandardMinutes()} ${plural}</p>
                </g:if>
            </g:each>
        </g:each>
    </div>
</div>

</body>
</html>