<%--
  Created by IntelliJ IDEA.
  User: francois
  Date: 15-07-25
  Time: 2:17 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Movie List</title>
    <g:set var="allMovies" value="${builder.build().getAllMovies()}"/>
</head>

<body>
<div class="jumbotron">
    <div class="container">
        <g:if test="${allMovies.size() == 0}">
            <h1>No movies found near that location</h1>
        </g:if> <g:else>
        <div class="form-group">
            <g:form method="post" action="schedules">
                <h1>Choose your movies:</h1>
                <g:select class="form-control"
                          id="movies"
                          name="movies"
                          from="${allMovies}"
                          optionKey="tmsId"
                          multiple="true"
                          size="${allMovies.size()}"/>

                <g:submitButton name="submit" value="Submit"/>
            </g:form>
        </div>
    </g:else>
    </div>
</div>
</body>
</html>