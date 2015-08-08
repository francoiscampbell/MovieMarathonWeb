<%--
  Created by IntelliJ IDEA.
  User: francois
  Date: 15-07-25
  Time: 2:17 PM
--%>

<%@ page import="io.github.francoiscampbell.apimodel.Movie" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Movie List</title>
    <g:set var="allMovies" value="${builder.build().getAllMovies().toSorted(new Comparator<Movie>() {
        int compare(Movie o1, Movie o2) {
            return o1.title.compareTo(o2.title)
        }
    })}"/>
</head>

<body>
<div class="jumbotron">
    <div class="container">
        <g:if test="${allMovies.size() == 0}">
            <h1>No movies found near that location</h1>
        </g:if> <g:else>
        <g:form method="post" action="schedules">
            <div class="form-group form-group-lg">
                <div class="col-lg-12">
                    <h1>Choose your movies:</h1>
                </div>

                <div class="col-lg-12">
                    <g:select class="form-control"
                              id="movies"
                              name="movies"
                              from="${allMovies}"
                              optionKey="tmsId"
                              multiple="true"
                              size="${Math.min(allMovies.size(), 20)}"/>
                    <g:submitButton class="btn btn-info btn-lg btn-block" name="submit" value="Generate schedules"/>
                </div>
            </div>
        </g:form>
    </g:else>
    </div>
</div>
</body>
</html>