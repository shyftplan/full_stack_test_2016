(function () {

  'use strict';

  angular.module('app', ['ngResource'])
    .controller('appCtrl', ['eventRepository', function (eventRepository) {

      // Prepare everything
      var vm   = this;
      vm.mode  = 'main';
      vm.event = {
        name       : '',
        started_at : new Date(),
        finished_at: new Date()
      };
      vm.events = [];
      prepareEvent(vm.event);
      var titles = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      vm.days    = [];
      for (var i = 0; i < 7; i++) {
        vm.days.push({num: i + 1, title: titles[i]});
      }
      vm.hours = [];
      for (i = 0; i < 24; i++) {
        vm.hours.push({id: i});
      }


      // Work with weeks
      var startDate, endDate;
      var getWeek = function () {
        var curr        = new Date();
        var day_of_week = curr.getDay() > 0 ? curr.getDay() : 7;
        var first       = curr.getDate() - day_of_week + 1;
        var last        = first + 7;
        curr.setDate(first);
        startDate = new Date(curr.setHours(0, 0, 0, 0));
        curr.setDate(last);
        endDate = new Date(curr.setHours(0, 0, 0, 0));
      };
      getWeek();
      vm.previousWeek = function () {
        endDate   = new Date(startDate);
        var date  = startDate.getDate() - 7;
        startDate = new Date(startDate.setDate(date));
      };
      vm.nextWeek = function () {
        startDate = new Date(endDate);
        var date  = endDate.getDate() + 7;
        endDate   = new Date(endDate.setDate(date));
      };
      vm.getWeekName = function () {
        var lastDate = new Date(endDate);
        lastDate     = new Date(lastDate.setDate(lastDate.getDate() - 1));
        return startDate.toLocaleDateString() + ' - ' + lastDate.toLocaleDateString();
      };


      // Event visibility and styling
      vm.inWeek = function (event) {
        return event.started_at >= startDate && event.finished_at <= endDate;
      };
      vm.getStyle = function (event) {
        return {
          top   : (event.hour_of_start * 100.0 / 24).toString() + '%',
          height: ((event.hour_of_end - event.hour_of_start) * 100.0 / 24).toString() + '%'
        }
      };


      // Popups
      vm.openNewEventPopup = function () {
        vm.event = {
          name       : '',
          started_at : new Date(),
          finished_at: new Date()
        };
        prepareEvent(vm.event);
        vm.mode = 'popup';
      };
      vm.openUpdateEventPopup = function (event) {
        if(!event.dragged) {
          vm.event = event;
          vm.mode = 'popup';
        }
      };
      vm.back = function () {
        vm.mode = 'main';
      };


      // Work with events
      vm.saveEvent = function () {
        var started_at  = new Date(vm.event.date.setHours(vm.event.hour_of_start, 0, 0, 0));
        var finished_at = new Date(vm.event.date.setHours(vm.event.hour_of_end, 0, 0, 0));
        var promise;
        if (vm.event.id) {
          promise = eventRepository.update(vm.event.id, vm.event.name, started_at, finished_at);
        } else {
          promise = eventRepository.create(vm.event.name, started_at, finished_at);
        }
        promise.then(function () {
          loadEvents();
          vm.back();
        })
      };
      vm.updateEvent = function (event, day, hour_of_start) {
        var started_at  = new Date(new Date(startDate).setDate(startDate.getDate() + day - 1));
        var finished_at = new Date(started_at);
        var duration    = event.hour_of_end - event.hour_of_start;
        started_at      = new Date(started_at.setHours(hour_of_start, 0, 0, 0));
        finished_at     = new Date(finished_at.setHours(hour_of_start + duration, 0, 0, 0));
        eventRepository.update(event.id, event.name, started_at, finished_at).then(function () {
          loadEvents();
        });
      };
      vm.deleteEvent = function () {
        eventRepository.destroy(vm.event.id).then(function () {
          loadEvents();
          vm.back();
        })
      };

      function loadEvents() {
        eventRepository.index().then(function (events) {
          vm.events = events;
          angular.forEach(vm.events, function (event) {
            prepareEvent(event);
          });
        })
      }
      loadEvents();
      function prepareEvent(event) {
        event.started_at    = new Date(event.started_at);
        event.finished_at   = new Date(event.finished_at);
        event.day_num       = event.started_at.getDay() > 0 ? event.started_at.getDay() : 7;
        event.date          = new Date(new Date(event.started_at).setHours(0, 0, 0, 0));
        event.hour_of_start = event.started_at.getHours();
        event.hour_of_end   = event.finished_at.getHours();
        event.hour_of_end   = event.hour_of_end > 0 ? event.hour_of_end : 24;
      }
    }
    ]);
})();