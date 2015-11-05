ScriptCooker =
  'level': 'Easy'
  'init': ->
    $('.changeLevel li').click ->
      $('.changeLevel li.active').removeClass 'active'
      ScriptCooker.level = $(this).data('level')
      $(this).addClass 'active'
      ScriptCooker.generate()
    ScriptCooker.generate()
  'generate': ->
    possible = (s for s,v of ScriptCooker.scripts when v.level == ScriptCooker.level)
    name = possible[Math.floor(Math.random()*possible.length)]
    script = ScriptCooker.scripts[name]
    $("#script").html(name)
    if script.noto_css
      $("#fonts").html("@import url(http://fonts.googleapis.com/" + script.noto_css + ");")
      $("#fonts").append("#udhr { font-family: \""+script.noto_family+"\"")
    if script.udhr
      $("#udhr").html(script.udhr)
      $("#udhr-wrapper").removeClass("hidden")
    else
      $("#udhr-wrapper").addClass("hidden")
    $("#more-info").empty()
    $("#more-info-wrapper").addClass("hidden")
    if script.scriptsource
      $("#more-info-wrapper").removeClass("hidden")
      $("#more-info").append("<li> <a href=\""+script.scriptsource+"\">"+name+" on Scriptsource</a></li>")
    $("#codepoints").empty()
    for c in script.codepoints
      console.log(c)
      row = $("<tr>")
      cpid = c.toString(16)
      while (cpid.length < 4)
        cpid = "0" + cpid
      td = $("<td>").html("U+" + cpid)
      row.append(td)
      td = $("<td>").html(String.fromCharCode(c))
      row.append(td)
      $("#codepoints").append(row)
    console.log(name)
$ ScriptCooker.init
