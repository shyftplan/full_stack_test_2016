(function () {

  'use strict';

  angular.module('app')
    .factory('eventRepository', ['$resource', function ($resource) {
      var eventResource = $resource('/api/v1/events/:id',
        {
          id: '@id'
        }, {
          'update' : {
            method: 'PUT'
          },
          'destroy': {
            method: 'DELETE'
          }
        });

      return {
        create : function (name, started_at, finished_at) {
          var params = {name: name, started_at: started_at, finished_at: finished_at};
          return eventResource.save(params).$promise;
        },
        update : function (id, name, started_at, finished_at) {
          var params = {id: id, name: name, started_at: started_at, finished_at: finished_at};
          return eventResource.update(params).$promise;
        },
        show   : function (id) {
          var params = {id: id};
          return eventResource.get(params).$promise;
        },
        destroy: function (id) {
          var params = {id: id};
          return eventResource.destroy(params).$promise;
        },
        index  : function () {
          return eventResource.query().$promise;
        }
      }
    }])
})();