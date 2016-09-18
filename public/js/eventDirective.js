(function () {

  'use strict';

  angular.module('app')
    .directive('event', ['$timeout', function ($timeout) {
      return {
        scope: {
          'event'      : '=',
          'updateEvent': '='
        },
        link : function ($scope, element, attrs) {
          element.draggable({
            stop: function () {
              var week      = $('.week');
              var first_day = $('.day_content:first');
              var top       = first_day.offset().top;
              var left      = week.offset().left;
              var height    = first_day.height();
              var width     = week.width();
              var x         = element.offset().left;
              var y         = element.offset().top;
              var duration  = $scope.event.hour_of_end - $scope.event.hour_of_start;
              var day       = Math.round((x - left) * 7 / width) + 1;
              if (day > 7) {
                day = 7;
              }
              if (x <= left) {
                day = 1;
              }
              if (x >= left + width) {
                day = 7;
              }
              var hour_of_start = Math.round((y - top) * 24 / height);
              if (hour_of_start > 24 - duration) {
                hour_of_start = 24 - duration
              }
              if (y <= top) {
                hour_of_start = 0;
              }
              if (y >= top + height) {
                hour_of_start = 24 - duration;
              }
              $scope.updateEvent($scope.event, day, hour_of_start);
              $scope.event.dragged = true;
              $timeout(function () {
                delete $scope.event.dragged;
              }, 1);
            }
          });
        }
      };
    }])
})();