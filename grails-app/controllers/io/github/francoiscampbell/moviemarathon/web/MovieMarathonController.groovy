package io.github.francoiscampbell.moviemarathon.web

import io.github.francoiscampbell.api.OnConnectApiRequest
import io.github.francoiscampbell.model.Schedule
import io.github.francoiscampbell.model.ScheduleGenerator
import org.joda.time.Duration
import org.joda.time.LocalDate

class MovieMarathonController {

    def index() {} //do nothing here, just go right to the view

    //TODO: add user choice for builder params in index controller and fetch them here
    def movies() {
        String currentDate = LocalDate.now().toString()
        OnConnectApiRequest request = new OnConnectApiRequest.Builder(currentDate)
                .apiKey(ApiKey.API_KEY)
                .latlng(Float.parseFloat(params.lat), Float.parseFloat(params.lng)) //TODO: fix exceptions for wrong data
                .radiusUnit(OnConnectApiRequest.RadiusUnit.KM)
//                .logLevel(RestAdapter.LogLevel.FULL)
                .build()

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
        builder.sortByDelay(true)
                .includePreviewsLength(false)
                .maxOverlap(Duration.standardMinutes(0))
    }
}
