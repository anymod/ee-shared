'use strict'

angular.module('app.core').factory 'eeSelections', ($q, eeBack, eeAuth) ->

  ## SETUP
  _inputDefaults =
    perPage:  48
    page:             null
    search:           null
    searchLabel:      null
    collection:       null

  ## PRIVATE EXPORT DEFAULTS
  _data =
    count:      null
    selections: []
    inputs:     _inputDefaults
    searching:  false

  ## PRIVATE FUNCTIONS
  _formQuery = () ->
    query = {}
    if _data.inputs.page        then query.page       = _data.inputs.page
    if _data.inputs.search      then query.search     = _data.inputs.search
    if _data.inputs.collection  then query.collection = _data.inputs.collection
    query

  _runQuery = () ->
    deferred = $q.defer()
    # if searching then avoid simultaneous calls to API
    if !!_data.searching then return _data.searching
    _data.searching = deferred.promise
    eeBack.selectionsGET 'demoseller', _formQuery()
    .then (res) ->
      { count, rows }   = res
      _data.count       = count
      _data.selections  = rows
      _data.inputs.searchLabel = _data.inputs.search
      deferred.resolve _data.selections
    .catch (err) ->
      _data.count = null
      deferred.reject err
    .finally () ->
      _data.searching = false
    deferred.promise

  ## EXPORTS
  data: _data
  fns:
    search: () ->
      _data.inputs.page = 1
      _runQuery()
    clearSearch: () ->
      _data.inputs.search = ''
      _data.inputs.page = 1
      _runQuery()
    incrementPage: () ->
      _data.inputs.page = if _data.inputs.page < 1 then 2 else _data.inputs.page + 1
      _runQuery()
    decrementPage: () ->
      _data.inputs.page = if _data.inputs.page < 2 then 1 else _data.inputs.page - 1
      _runQuery()
    setCollection: (collection) ->
      _data.inputs.page = 1
      _data.inputs.collection = if _data.inputs.collection is collection then null else collection
      _runQuery()
