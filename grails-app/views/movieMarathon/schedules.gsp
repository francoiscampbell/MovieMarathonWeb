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
        <g:set var="colon" value="${schedules.size() == 0 ? "schedules." : "schedules:"}"/>
        <g:if test="${schedules.size() == 0}">
            <h1>No schedules possible</h1>

            <p>The movies you selected are not playing at the same theatre on the same day or
            it was not possible to generate any schedules with your selections. Try to reduce the number of
            movies chosen or choose other movies.</p>
        </g:if>
        <g:else>
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
        </g:else>
    </div>
</div>

</body>
</html>