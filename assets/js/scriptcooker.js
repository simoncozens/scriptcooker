// Generated by CoffeeScript 1.8.0
var ScriptCooker;

ScriptCooker = {
  'level': 'Easy',
  'init': function() {
    $('.changeLevel li').click(function() {
      $('.changeLevel li.active').removeClass('active');
      ScriptCooker.level = $(this).data('level');
      $(this).addClass('active');
      return ScriptCooker.generate();
    });
    return ScriptCooker.generate();
  },
  'generate': function() {
    var c, counter, cpid, font, name, possible, row, s, script, td, th, v, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2, _ref3;
    possible = (function() {
      var _ref, _results;
      _ref = ScriptCooker.scripts;
      _results = [];
      for (s in _ref) {
        v = _ref[s];
        if (v.level === ScriptCooker.level) {
          _results.push(s);
        }
      }
      return _results;
    })();
    name = possible[Math.floor(Math.random() * possible.length)];
    script = ScriptCooker.scripts[name];
    $("#script").html(name);
    $("#glyphcount").html(script.glyph_count);
    if (script.noto === "sans") {
      script.noto_family = "Noto Sans " + name;
      script.noto_css = "@import url(http://fonts.googleapis.com/earlyaccess/notosans" + (name.toLowerCase()) + ".css";
    }
    if (script.noto_css) {
      $("#fonts").html(script.noto_css);
      $("#fonts").append("#udhr, #codepoints { font-family: \"" + script.noto_family + "\" }");
    }
    if (script.other_fonts) {
      counter = 1;
      _ref = script.other_fonts;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        font = _ref[_i];
        $("#fonts").append(font.css);
        $("#fonts").append(".other-" + counter + " { font-family: \"" + font.name + "\" }");
        counter = counter + 1;
      }
    }
    if (script.adhesion) {
      $("#adhesion").html(script.adhesion);
      $("#adhesion-wrapper").removeClass("hidden");
    } else {
      $("#adhesion-wrapper").addClass("hidden");
    }
    if (script.udhr) {
      $("#udhr").html(script.udhr);
      $("#udhr-wrapper").removeClass("hidden");
    } else {
      $("#udhr-wrapper").addClass("hidden");
    }
    $("#more-info").empty();
    $("#more-info-wrapper").addClass("hidden");
    if (script.scriptsource) {
      $("#more-info-wrapper").removeClass("hidden");
      $("#more-info").append("<li> <a href=\"http://scriptsource.org/scr/" + script.scriptsource + "\">" + name + " on Scriptsource</a></li>");
    }
    $("#codepoints").empty();
    row = $("<tr><th>Codepoint</th><th>Name</th><th>Noto</th></tr>");
    if (script.other_fonts) {
      _ref1 = script.other_fonts;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        font = _ref1[_j];
        th = $("<th>" + font.name + "</th>");
        row.append(th);
      }
    }
    $("#codepoints").append(row);
    _ref2 = script.codepoints;
    for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
      c = _ref2[_k];
      cpid = c[0].toString(16);
      name = c[1];
      row = $("<tr>");
      while (cpid.length < 4) {
        cpid = "0" + cpid;
      }
      td = $("<td>").html("U+" + cpid);
      row.append(td);
      td = $("<td>").html(name);
      row.append(td);
      td = $("<td class=\"glyph\">").html(String.fromCharCode(c[0]));
      row.append(td);
      if (script.other_fonts) {
        counter = 1;
        _ref3 = script.other_fonts;
        for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
          font = _ref3[_l];
          td = $("<td class=\"glyph other-" + counter + "\">").html(String.fromCharCode(c));
          row.append(td);
          counter = counter + 1;
        }
      }
      $("#codepoints").append(row);
    }
    return console.log(name);
  }
};

$(ScriptCooker.init);

//# sourceMappingURL=scriptcooker.js.map
