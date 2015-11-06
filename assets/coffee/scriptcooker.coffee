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
    $("#glyphcount").html(script.glyph_count)
    if script.noto == "sans"
      script.noto_family = "Noto Sans "+name
      script.noto_css = "@import url(http://fonts.googleapis.com/earlyaccess/notosans"+(name.toLowerCase())+".css"
    if script.noto_css
      $("#fonts").html(script.noto_css)
      $("#fonts").append("#udhr, #codepoints { font-family: \""+script.noto_family+"\" }")
    if script.other_fonts
      counter = 1
      for font in script.other_fonts
        $("#fonts").append(font.css)
        $("#fonts").append(".other-"+counter+" { font-family: \""+font.name+"\" }")
        counter = counter+1
    if script.adhesion
      $("#adhesion").html(script.adhesion)
      $("#adhesion-wrapper").removeClass("hidden")
    else
      $("#adhesion-wrapper").addClass("hidden")
    if script.udhr
      $("#udhr").html(script.udhr)
      $("#udhr-wrapper").removeClass("hidden")
    else
      $("#udhr-wrapper").addClass("hidden")
    $("#more-info").empty()
    $("#more-info-wrapper").addClass("hidden")
    if script.scriptsource
      $("#more-info-wrapper").removeClass("hidden")
      $("#more-info").append("<li> <a href=\"http://scriptsource.org/scr/"+script.scriptsource+"\">"+name+" on Scriptsource</a></li>")
    $("#codepoints").empty()
    row = $("<tr><th>Codepoint</th><th>Name</th><th>Noto</th></tr>")
    if script.other_fonts
      for font in script.other_fonts
        th = $("<th>"+font.name+"</th>")
        row.append(th)
    $("#codepoints").append(row)
    for c in script.codepoints
      cpid = c[0].toString(16)
      name = c[1]
      row = $("<tr>")
      while (cpid.length < 4)
        cpid = "0" + cpid
      td = $("<td>").html("U+" + cpid)
      row.append(td)
      td = $("<td>").html(name)
      row.append(td)
      td = $("<td class=\"glyph\">").html(String.fromCharCode(c[0]))
      row.append(td)
      if script.other_fonts
        counter = 1
        for font in script.other_fonts
          td = $("<td class=\"glyph other-"+counter+"\">").html(String.fromCharCode(c))
          row.append(td)
          counter = counter+1
      $("#codepoints").append(row)
    console.log(name)
$ ScriptCooker.init
