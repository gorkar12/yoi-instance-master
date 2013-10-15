"use strict"

Yoi     = require "yoi"
#Models
Tasks   = require "../../commons/models/task"

module.exports = (server) ->

    server.post "/api/task", (request, response, next) ->
        rest = new Yoi.Rest request, response
        rest.required ["name"]
        Task.create(_parameters(rest)).then (error, tasks) ->
            if error then rest.badRequest() else rest.run tasks.parse()

    server.put "/api/task", (request, response, next) ->
        rest = new Yoi.Rest request, response
        rest.required ["id"]
        Yoi.Hope.shield([->
            Tasks.findId rest.parameter "id"
        , (error, @task) =>
            @task.finish()
        ]).then (error, value) ->
            if error? then rest.badRequest() else rest.successful()

    server.del "/api/task", (request,response,next) ->
        rest = new Yoi.Rest request, response
        rest.requiered  ["id"]
        Yoi.Hope.shield([->
            Tasks findId rest.parameter "id"
        , (error, @task) =>
            @task.delete(rest.parameter "id")
        ]).then (error, value) ->
            if error? then rest.badRequest() else rest.successful()

