package io.github.francoiscampbell.moviemarathon.web

import io.github.francoiscampbell.api.OnConnectApiRequest
import io.github.francoiscampbell.apimodel.Movie
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
        String currentDate = LocalDate.now().toString()
        OnConnectApiRequest request = new OnConnectApiRequest.Builder(currentDate)
                .apiKey(ApiKey.API_KEY)
                .latlng(Float.parseFloat(params.lat), Float.parseFloat(params.lng)) //TODO: fix exceptions for wrong data
                .radiusUnit(OnConnectApiRequest.RadiusUnit.KM)
//                .logLevel(RestAdapter.LogLevel.FULL)
                .build()

        def builder = request.execute()
        Collections.sort(new ArrayList<Movie>(), new Comparator<Movie>() {
            @Override
            int compare(Movie o1, Movie o2) {
                return o1.title.compareTo(o2.title)
            }
        })
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
