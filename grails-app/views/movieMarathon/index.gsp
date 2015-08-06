<%--
  Created by IntelliJ IDEA.
  User: francois
  Date: 15-08-01
  Time: 2:45 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Movie Marathon</title>
    <script src="https://maps.googleapis.com/maps/api/js?libraries=places"></script>
</head>

<body>
<div class="jumbotron">
    <div class="container">
        <h1>Movie Marathon</h1>

        <p>This app helps plan movie marathons at Canadian and US movie theatres.</p>
        <g:form class="form-horizontal" name="form-postcode" action="movies" method="post">
            <div class="form-group form-group-lg">
                <div class="col-lg-10">
                    <input type="text" class="form-control" name="pac-place"
                           placeholder="Where are you?"
                           value="" id="pac-place"/>
                </div>

                <div class="col-lg-2">
                    <g:submitButton class="btn btn-info" name="submit" value="Choose movies"/>
                </div>
                <input type="hidden" name="lat" id="lat"/>
                <input type="hidden" name="lng" id="lng"/>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>