package io.github.francoiscampbell.moviemarathon.web

import io.github.francoiscampbell.api.ApiRequest
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
        def currentDate = LocalDate.now().toString()
        def request = new ApiRequest.Builder(currentDate)
                .apiKey(ApiKey.API_KEY)
                .latlng(lat, lng)
                .radiusUnit(ApiRequest.RadiusUnit.KM)
                .mockResponse(new File("mockResponse.json"))
                .build()

        def movies = new LinkedList()
        request.execute().toBlocking().forEach({ movies.add it })

        def builder = new ScheduleGenerator.Builder(movies)
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
                .ignorePreviews(true)
                .maxOverlap(Duration.standardMinutes(0))
    }
}
