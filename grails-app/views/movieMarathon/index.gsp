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

    <!-- bower:js -->
    <!-- endbower -->
    <script src="https://maps.googleapis.com/maps/api/js?libraries=places"></script>
    <asset:javascript src="autocomplete.js"/>
    <asset:javascript src="dateTimePicker.js"/>
    <asset:stylesheet src="movieMarathon.index.css"/>
</head>

<body>
<div class="jumbotron">
    <div class="container">
        <h1>Movie Marathon</h1>

        <p>This app helps plan movie marathons at Canadian and US movie theatres.</p>
        <g:form class="form-horizontal" name="form-postcode" action="movies" method="post">
            <div class="form-group form-group-lg">

                <div class="col-lg-6">
                    <input type="text" class="form-control" name="pac-place"
                           placeholder="Where are you?"
                           value="" id="pac-place"/>
                </div>
                <input type="hidden" name="lat" id="lat"/>
                <input type="hidden" name="lng" id="lng"/>

                <div class="col-lg-6">
                    <div class='input-group date' id='dateTimePicker'>
                        <input type='text' class="form-control" title="When?"/>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>

                <div class="col-lg-12">
                    <g:submitButton class="btn btn-info btn-lg btn-block" name="submitButton" value="Choose movies"/>
                </div>

            </div>
        </g:form>
    </div>
</div>
</body>
</html>