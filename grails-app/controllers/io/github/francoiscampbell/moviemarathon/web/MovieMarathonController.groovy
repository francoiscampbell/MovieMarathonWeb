package io.github.francoiscampbell.moviemarathon.web

import grails.util.Environment
import io.github.francoiscampbell.api.OnConnectApiRequest
import io.github.francoiscampbell.model.Schedule
import io.github.francoiscampbell.model.ScheduleGenerator
import org.joda.time.Duration
import org.joda.time.LocalDate

class MovieMarathonController {

    def index() {} //do nothing here, just go right to the view

    //TODO: add user choice for builder params in index controller and fetch them here
    def movies() {
        if (params.lat == null || params.lng == null) {
            redirect action: "index"
            return
        }
        float lat
        float lng
        try {
            lat = Float.parseFloat(params.lat)
            lng = Float.parseFloat(params.lng)
        } catch (NumberFormatException ignore) {
            redirect action: "index"
            return
        }
        String currentDate = LocalDate.now().toString()
        OnConnectApiRequest request

        if (Environment.current == Environment.PRODUCTION) {
            request = new OnConnectApiRequest.Builder(currentDate)
                    .apiKey(ApiKey.API_KEY)
                    .latlng(lat, lng) //TODO: fix exceptions for wrong data
                    .radiusUnit(OnConnectApiRequest.RadiusUnit.KM)
                    .mockResponse(new File("mockResponse.json"))
                    .build()
        } else {
            request = new OnConnectApiRequest.Builder(currentDate)
                    .mockResponse(new File("mockResponse.json"))
                    .build()
        }

        def builder = request.execute()
        session["builder"] = builder
        [builder: builder]
    }

    def schedules() {
        ScheduleGenerator.Builder builder = session.builder
        chooseParameters(builder)
        //TODO: choose parameters before and save the fully-built generator instead of the builder

        def allMovies = builder.build().getAllMovies()
        def desiredMovies = allMovies.findAll { params.movies?.contains it.tmsId }

        List<Schedule> possibleSchedules = builder.build().generateSchedules(desiredMovies)

        [schedules: possibleSchedules]
    }

    private def chooseParameters(ScheduleGenerator.Builder builder) {
        boolean ignorePreviews = params.addPreviewsToRunningTime == "on"
        long maxOverlapMinutes = Long.parseLong(params.maxOverlap ?: "0")

        builder.sortByDelay(true)
                .ignorePreviews(ignorePreviews)
                .maxOverlap(Duration.standardMinutes(maxOverlapMinutes))
    }

}
