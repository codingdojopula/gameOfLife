(function() {
  $(function() {
    var array2d, cellPixels, cells, draw, evolve, height, init, period, shouldLive, width;
    cellPixels = 8;
    width = $('#canvas')[0].width / cellPixels;
    height = $('#canvas')[0].height / cellPixels;
    cells = [];
    period = 50;
    array2d = function() {
      var arr, x, _i, _j, _ref, _ref2, _ref3, _results, _results2, _results3;
      arr = (function() {
        _results = [];
        for (var _i = 0, _ref = width - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (x = 0, _ref2 = width - 1; 0 <= _ref2 ? x <= _ref2 : x >= _ref2; 0 <= _ref2 ? x++ : x--) {
        _results2.push(arr[x] = (function() {
          _results3 = [];
          for (var _j = 0, _ref3 = height - 1; 0 <= _ref3 ? _j <= _ref3 : _j >= _ref3; 0 <= _ref3 ? _j++ : _j--){ _results3.push(_j); }
          return _results3;
        }).apply(this, arguments));
      }
      return _results2;
    };
    init = function() {
      var x, y, _ref, _results;
      cells = array2d();
      _results = [];
      for (x = 0, _ref = width - 1; 0 <= _ref ? x <= _ref : x >= _ref; 0 <= _ref ? x++ : x--) {
        _results.push((function() {
          var _ref2, _results2;
          _results2 = [];
          for (y = 0, _ref2 = height - 1; 0 <= _ref2 ? y <= _ref2 : y >= _ref2; 0 <= _ref2 ? y++ : y--) {
            _results2.push(cells[x][y] = Math.random() >= 0.7);
          }
          return _results2;
        })());
      }
      return _results;
    };
    draw = function() {
      var context, x, y, _ref, _results;
      context = $('#canvas')[0].getContext('2d');
      context.strokeStyle = '#ddd';
      _results = [];
      for (x = 0, _ref = width - 1; 0 <= _ref ? x <= _ref : x >= _ref; 0 <= _ref ? x++ : x--) {
        _results.push((function() {
          var _ref2, _results2;
          _results2 = [];
          for (y = 0, _ref2 = height - 1; 0 <= _ref2 ? y <= _ref2 : y >= _ref2; 0 <= _ref2 ? y++ : y--) {
            context.fillStyle = cells[x][y] ? '#444' : '#f8f8f8';
            context.fillRect(x * cellPixels, y * cellPixels, cellPixels, cellPixels);
            _results2.push(context.strokeRect(x * cellPixels, y * cellPixels, cellPixels, cellPixels));
          }
          return _results2;
        })());
      }
      return _results;
    };
    shouldLive = function(x, y) {
      var alive, i, j, neighbours, _ref, _ref2, _ref3, _ref4;
      neighbours = 0;
      alive = cells[x][y];
      for (i = _ref = x - 1, _ref2 = x + 1; _ref <= _ref2 ? i <= _ref2 : i >= _ref2; _ref <= _ref2 ? i++ : i--) {
        for (j = _ref3 = y - 1, _ref4 = y + 1; _ref3 <= _ref4 ? j <= _ref4 : j >= _ref4; _ref3 <= _ref4 ? j++ : j--) {
          if ((i !== x || j !== y) && cells[(i + width) % width][(j + height) % height]) {
            neighbours++;
          }
        }
      }
      if (alive) {
        return neighbours === 2 || neighbours === 3;
      } else {
        return neighbours === 3;
      }
    };
    evolve = function() {
      var next, x, y, _ref, _ref2;
      draw();
      next = array2d();
      for (x = 0, _ref = width - 1; 0 <= _ref ? x <= _ref : x >= _ref; 0 <= _ref ? x++ : x--) {
        for (y = 0, _ref2 = height - 1; 0 <= _ref2 ? y <= _ref2 : y >= _ref2; 0 <= _ref2 ? y++ : y--) {
          next[x][y] = shouldLive(x, y);
        }
      }
      cells = next;
      return window.setTimeout(evolve, period);
    };
    init();
    return evolve();
  });
}).call(this);
