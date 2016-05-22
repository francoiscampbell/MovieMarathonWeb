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

    <!-- bower:css -->
    <asset:stylesheet src="../../assets/bower_components/bootstrap/dist/css/bootstrap.css"/>
    <asset:stylesheet
            src="../../assets/bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css"/>
    <!-- endbower -->
    <asset:stylesheet src="movieMarathon.movies.css"/>

    <g:set var="allMovies" value="${builder.build().getAllMovies().toSorted(new Comparator<Movie>() {
        int compare(Movie o1, Movie o2) {
            return o1.title.compareTo(o2.title)
        }
    })}"/>
</head>

<body>

<!-- bower:js -->
<asset:javascript src="../../assets/bower_components/jquery/dist/jquery.js"/>
<asset:javascript src="../../assets/bower_components/moment/moment.js"/>
<asset:javascript src="../../assets/bower_components/moment-timezone/builds/moment-timezone-with-data-2010-2020.js"/>
<asset:javascript
        src="../../assets/bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"/>
<!-- endbower -->
<asset:javascript src="advancedOptions.js"/>

<div class="jumbotron">
    <div class="container">
        <g:if test="${allMovies.size() == 0}">
            <h1>No movies found near that location</h1>
        </g:if> <g:else>
        <g:form method="post" action="schedules">
            <div class="form-group form-group-lg">
                <h1>Choose your movies:</h1>

                <g:select class="form-control"
                          id="movies"
                          name="movies"
                          from="${allMovies}"
                          optionKey="tmsId"
                          multiple="true"
                          size="${Math.min(allMovies.size(), 15)}"/>
                <g:submitButton class="btn btn-info btn-lg btn-block" name="submit" value="Generate schedules"/>

                <a href="#" id="advancedOptionsTrigger">Advanced Options</a>
            </div>

            <div id="advancedOptionsContainer">
                <div class="form-group form-group-lg">
                    Include previews time in running time: <g:checkBox name="addPreviewsToRunningTime"
                                                                       value="${true}"/><br>
                    Estimated preview length: <g:textField name="previewLength"/><br>
                    Maximum individual delay between movies: <g:textField name="maxIndividualDelay"/><br>
                    Maximum total delay: <g:textField name="maxTotalDelay"/><br>
                    Maximum overlap between movies: <g:textField name="maxOverlap" value="${0}"/><br>
                </div>
            </div>
        </g:form>
    </g:else>
    </div>
</div>
</body>
</html>