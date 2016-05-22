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
        String paramRequestedLat = params.lat
        String paramRequestedLng = params.lng
        String paramRequestedDate = params.date ?: LocalDate.now().toString()

        if (paramRequestedLat == null || paramRequestedLng == null) {
            redirect action: "index"
            return
        }
        float lat
        float lng
        try {
            lat = Float.parseFloat(paramRequestedLat)
            lng = Float.parseFloat(paramRequestedLng)
        } catch (NumberFormatException ignore) {
            redirect action: "index"
            return
        }

        OnConnectApiRequest request
        if (Environment.current == Environment.PRODUCTION) {
        request = new OnConnectApiRequest.Builder(paramRequestedDate)
                    .apiKey(ApiKey.API_KEY)
                .latlng(lat, lng)
                    .radiusUnit(OnConnectApiRequest.RadiusUnit.KM)
                    .build()
        } else {
            request = new OnConnectApiRequest.Builder(params.date)
                    .mockResponse(new File("mockResponse.json"))
                    .build()
        }

        def builder = request.execute()
        session["builder"] = builder
        [builder: builder]
    }

    def schedules() {
        ScheduleGenerator.Builder builder = session.builder

        def allMovies = chooseParameters(builder).getAllMovies()
        def desiredMovies = allMovies.findAll { params.movies?.contains it.tmsId }
        List<Schedule> possibleSchedules = builder.build().generateSchedules(desiredMovies)

        [schedules: possibleSchedules]
    }

    private def chooseParameters(ScheduleGenerator.Builder builder) {
        boolean ignorePreviews = params.addPreviewsToRunningTime == "on"
        long previewLength = Long.parseLong(params.previewLength ?: "15")
        long maxIndividualDelay = Long.parseLong(params.maxIndividualDelay ?: "999")
        long maxTotalDelay = Long.parseLong(params.maxTotalDelay ?: "999")
        long maxOverlapMinutes = Long.parseLong(params.maxOverlap ?: "0")

        return builder.sortByDelay(true)
                .ignorePreviews(ignorePreviews)
                .maxIndividualDelay(Duration.standardMinutes(maxIndividualDelay))
                .maxTotalDelay(Duration.standardMinutes(maxTotalDelay))
                .maxOverlap(Duration.standardMinutes(maxOverlapMinutes))
                .build()
    }

}
