angular.module('SimpleTask').factory 'addHours', ->

  _addHours = (date) ->
    date.setHours(date.getHours() + 12)
    date.setMinutes(date.getMinutes() - date.getTimezoneOffset())
    date.toISOString().substring(0,10)

