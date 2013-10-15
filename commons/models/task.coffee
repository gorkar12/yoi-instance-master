"use strict"

Yoi     = require "yoi"
Schema  = Yoi.Mongoose.Schema
db      = Yoi.Mongo.connections.primary

Task = new Schema
    name        : type: String
    description : type: String
    done        : type: Boolean, default: false
    created_at  : type: Date, default: Date.now

Task.statics.create = (values) ->
    promise = new Yoi.Hope.Promise()
    task = db.model "Task", Task
    new task(values).save (error, value) -> promise.done error, value
    promise

Task.statics.findId = (id) ->
    promise = new Yoi.Hope.Promise()
    @findById(id).exec (error, value) ->
        error = true if error?
        promise.done error, value
    promise



Task.methods.parse = ->
    id          : @_id
    name        : @name
    description : @description
    done        : @done
    created_at  : @created_at


exports = module.exports = db.model "Task", Task