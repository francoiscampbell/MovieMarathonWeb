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
    <asset:javascript src="poster-select.js"/>
    <asset:stylesheet src="movieMarathon.movies.css"/>
</head>

<body>
<div class="jumbotron">
    <div class="container-fluid" style="display: inline-block">
        <g:if test="${allMovies.size() == 0}">
            <h1>No movies found near that location</h1>
        </g:if>
        <g:else>
            <g:form method="post" action="schedules">
                <div class="movie-container">
                    <h1>Choose your movies</h1>
                    <g:each in="${allMovies}" var="movie">
                        <div class="movie" id="${movie.tmsId}">
                            <div class="poster">
                                <div class="img-container">
                                    <img src="${movie.getPreferredImage().getUri()}">
                                </div>
                            </div>
                            ${movie.title}
                        </div>
                    </g:each>
                </div>
                <g:select class="form-control"
                          id="movies"
                          name="movies"
                          from="${allMovies}"
                          optionKey="tmsId"
                          multiple="true"/>
                <g:submitButton class="btn btn-info btn-lg btn-block" name="submit" value="Generate schedules"/>
            </g:form>
        </g:else>
    </div>
</div>
</body>
</html>